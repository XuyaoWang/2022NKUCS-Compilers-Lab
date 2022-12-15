#include "Ast.h"
#include "SymbolTable.h"
#include "Unit.h"
#include "Instruction.h"
#include "IRBuilder.h"
#include <string>
#include "Type.h"

extern FILE *yyout;
int Node::counter = 0;
IRBuilder* Node::builder = nullptr;

void exprTypeCheck(Type *fType1, Type *fType2){
    if (fType1== nullptr||fType2== nullptr){
        fprintf(stderr, "expr type can't be nullptr\n");
        exit(EXIT_FAILURE);
    }

    Type*type1;
    Type*type2;

    if (fType1->isFunc()){
        FunctionType*type=dynamic_cast<FunctionType*>(fType1);
        type1=type->getRetType();
    } else{
        type1=fType1;
    }

    if (fType2->isFunc()){
        FunctionType*type=dynamic_cast<FunctionType*>(fType2);
        type2=type->getRetType();
    } else{
        type2=fType2;
    }

    if (type1->isVoid()||type2->isVoid()){
        fprintf(stderr, "the operand's type cannot be void\n");
        exit(EXIT_FAILURE);
    }

    if (type1->getKind()==type2->getKind()){
        return;
    }
    if((type1->isFloat()&&type2->isInt())||
       (type1->isInt()&&type2->isFloat())){
        return;
    }
    fprintf(stderr, "type %s and %s mismatch in line xx\n",type1->toStr().c_str(), type2->toStr().c_str());
    exit(EXIT_FAILURE);
}

Node::Node()
{
    seq = counter++;
}

void Node::backPatch(std::vector<Instruction*> &list, BasicBlock*bb)
{
    for(auto &inst:list)
    {
        if(inst->isCond())
            dynamic_cast<CondBrInstruction*>(inst)->setTrueBranch(bb);
        else if(inst->isUncond())
            dynamic_cast<UncondBrInstruction*>(inst)->setBranch(bb);
    }
}

std::vector<Instruction*> Node::merge(std::vector<Instruction*> &list1, std::vector<Instruction*> &list2)
{
    std::vector<Instruction*> res(list1);
    res.insert(res.end(), list2.begin(), list2.end());
    return res;
}

Type *StmtNode::getNodeType() {
    return this->nodeType;
}

void StmtNode::setNodeType(Type *nodeType) {
    this->nodeType=nodeType;
}

void StmtNode::stmtTypeCheck(Type *fType1, Type *fType2) {
    Type*type1;
    Type*type2;

    // Type void is also a basic type.No need to transfer.
    if (fType1->isFunc()){
        FunctionType*type=dynamic_cast<FunctionType*>(fType1);
        type1=type->getRetType();
    } else{
        type1=fType1;
    }

    if (fType2->isFunc()){
        FunctionType*type=dynamic_cast<FunctionType*>(fType2);
        type2=type->getRetType();
    } else{
        type2=fType2;
    }

    if (type1->isVoid()){
        this->setNodeType(type2);
        return;
    }
    if (type2->isVoid()){
        this->setNodeType(type1);
        return;
    }

    if (type1->getKind()==type2->getKind()){
        this->setNodeType(type1);
        return;
    }
    if((type1->isFloat()&&type2->isInt())||
       (type1->isInt()&&type2->isFloat())){
        this->setNodeType(type1->isFloat()?type1:type2);
        return;
    }
    fprintf(stderr, "type %s and %s mismatch in line xx\n",type1->toStr().c_str(), type2->toStr().c_str());
    exit(EXIT_FAILURE);
}

void Ast::genCode(Unit *unit)
{
    IRBuilder *builder = new IRBuilder(unit);
    Node::setIRBuilder(builder);
    root->genCode();
}

void FunctionDef::genCode()
{
    Unit *unit = builder->getUnit();
    Function *func = new Function(unit, se);
    BasicBlock *entry = func->getEntry();
    // set the insert point to the entry basicblock of this function.
    builder->setInsertBB(entry);

    if(nullptr!=decl){
        decl->genCode();
    }

    stmt->genCode();

    /**
     * Construct control flow graph. You need do set successors and predecessors for each basic block.
    */

    for (auto bb = func->begin(); bb != func->end(); bb++){
        // get the last instruction of current block
        Instruction *last = (*bb)->rbegin();
        if (last->isCond()){
            BasicBlock *trueBranch = ((CondBrInstruction *)last)->getTrueBranch();
            BasicBlock *falseBranch = ((CondBrInstruction *)last)->getFalseBranch();
            (*bb)->addSucc(trueBranch);
            (*bb)->addSucc(falseBranch);
            trueBranch->addPred(*bb);
            falseBranch->addPred(*bb);
        }
        else if (last->isUncond()){
            BasicBlock *branch = ((UncondBrInstruction *)last)->getBranch();
            (*bb)->addSucc(branch);
            branch->addPred(*bb);
        }
        else if (!last->isRet()){
            // last instruction is not ret and doesn't have predecessors
            // this means current function returns void or current function is main() function
            if (((FunctionType *)func->getSymPtr()->getType())->getRetType() == TypeSystem::intType){
                new RetInstruction(new Operand(new ConstantSymbolEntry(TypeSystem::intType, 0)), (*bb));
            }
            else if (((FunctionType *)func->getSymPtr()->getType())->getRetType() == TypeSystem::voidType){
                new RetInstruction(nullptr, (*bb));
            }
        }
    }
   
}

void BinaryExpr::genCode()
{
    BasicBlock *bb = builder->getInsertBB();
    Function *func = bb->getParent();
    if (op == AND)
    {
        BasicBlock *trueBB = new BasicBlock(func);  // if the result of lhs is true, jump to the trueBB.
        expr1->genCode();
        backPatch(expr1->trueList(), trueBB);
        builder->setInsertBB(trueBB);               // set the insert point to the trueBB so that intructions generated by expr2 will be inserted into it.
        expr2->genCode();
        true_list = expr2->trueList();
        false_list = merge(expr1->falseList(), expr2->falseList());
    }
    else if(op == OR)
    {
        // Todo
        BasicBlock* trueBB = new BasicBlock(func);
        expr1->genCode();
        backPatch(expr1->falseList(), trueBB);
        builder->setInsertBB(trueBB);
        expr2->genCode();
        true_list = merge(expr1->trueList(), expr2->trueList());
        false_list = expr2->falseList();
    }
    else if(op >= LESS && op <= GREATER)
    {
        // Todo
    }
    else if(op >= ADD && op <= MOD)
    {
        expr1->genCode();
        expr2->genCode();
        Operand *src1 = expr1->getOperand();
        Operand *src2 = expr2->getOperand();
        int opcode;
        switch (op)
        {
        case ADD:
            opcode = BinaryInstruction::ADD;
            break;
        case SUB:
            opcode = BinaryInstruction::SUB;
            break;
        case MUL:
            opcode = BinaryInstruction::MUL;
            break;
        case DIV:
            opcode = BinaryInstruction::DIV;
            break;
        case MOD:
            opcode = BinaryInstruction::MOD;
            break;
        }
        new BinaryInstruction(opcode, dst, src1, src2, bb);
    }
}

void Constant::genCode()
{
    // we don't need to generate code.
}

void Id::genCode()
{
    BasicBlock *bb = builder->getInsertBB();
    Operand *addr = dynamic_cast<IdentifierSymbolEntry*>(symbolEntry)->getAddr();
    new LoadInstruction(dst, addr, bb);
}

void IfStmt::genCode()
{
    Function *func;
    BasicBlock *then_bb, *end_bb;

    func = builder->getInsertBB()->getParent();
    then_bb = new BasicBlock(func);
    end_bb = new BasicBlock(func);

    cond->genCode();
    backPatch(cond->trueList(), then_bb);
    backPatch(cond->falseList(), end_bb);

    builder->setInsertBB(then_bb);
    thenStmt->genCode();
    then_bb = builder->getInsertBB();
    new UncondBrInstruction(end_bb, then_bb);

    builder->setInsertBB(end_bb);
}

void IfElseStmt::genCode()
{
    Function* func;
    BasicBlock *then_bb, *else_bb, *end_bb;

    func = builder->getInsertBB()->getParent();
    then_bb = new BasicBlock(func);
    else_bb = new BasicBlock(func);
    end_bb = new BasicBlock(func);

    cond->genCode();
    backPatch(cond->trueList(), then_bb);
    backPatch(cond->falseList(), else_bb);

    builder->setInsertBB(then_bb);
    thenStmt->genCode();
    then_bb = builder->getInsertBB();
    new UncondBrInstruction(end_bb, then_bb);

    builder->setInsertBB(else_bb);
    elseStmt->genCode();
    else_bb = builder->getInsertBB();
    new UncondBrInstruction(end_bb, else_bb);

    builder->setInsertBB(end_bb);
}

void CompoundStmt::genCode()
{
    if (stmt!= nullptr)
        stmt->genCode();
}

void SeqNode::genCode()
{
    stmt1->genCode();
    stmt2->genCode();
}

void DeclStmt::genCode()
{
    IdentifierSymbolEntry *se = dynamic_cast<IdentifierSymbolEntry *>(id->getSymPtr());
    if(se->isGlobal()){
        Operand *addr;
        SymbolEntry *addr_se;
        addr_se = new IdentifierSymbolEntry(*se);
        addr_se->setType(new PointerType(se->getType()));
        addr = new Operand(addr_se);
        se->setAddr(addr);
    }
    else if(se->isLocal()||se->isParam()){
        Function *func = builder->getInsertBB()->getParent();
        BasicBlock *entry = func->getEntry();
        Instruction *alloca;
        Operand *addr;
        SymbolEntry *addr_se;
        Type *type;
        type = new PointerType(se->getType());
        addr_se = new TemporarySymbolEntry(type, SymbolTable::getLabel());
        addr = new Operand(addr_se);
        alloca = new AllocaInstruction(addr, se);                   // allocate space for local id in function stack.
        entry->insertFront(alloca);                                 // allocate instructions should be inserted into the begin of the entry block.

        if (se->isParam()){
            BasicBlock* bb = builder->getInsertBB();
            new StoreInstruction(addr, se->getAddr(), bb);
        }

        se->setAddr(addr);                                          // set the addr operand in symbol entry so that we can use it in subsequent code generation.

        if (nullptr!=expr){
            expr->genCode();
            BasicBlock* bb = builder->getInsertBB();
            new StoreInstruction(addr, expr->getOperand(), bb);
        }
    }
}

void ReturnStmt::genCode()
{
    BasicBlock *bb = builder->getInsertBB();
    Operand* src = nullptr;
    if (nullptr!=retValue) {
        retValue->genCode();
        src = retValue->getOperand();
    }
    new RetInstruction(src, bb);
}

void AssignStmt::genCode()
{
    BasicBlock *bb = builder->getInsertBB();
    expr->genCode();
    Operand *addr = dynamic_cast<IdentifierSymbolEntry*>(lval->getSymPtr())->getAddr();
    Operand *src = expr->getOperand();
    /***
     * We haven't implemented array yet, the lval can only be ID. So we just store the result of the `expr` to the addr of the id.
     * If you want to implement array, you have to caculate the address first and then store the result into it.
     */
    new StoreInstruction(addr, src, bb);
}

void UnaryExpr::genCode() {
    //Todo
    expr->genCode();
}

void DeclStmts::genCode() {
    for (long unsigned int i = 0; i < declStmts.size(); ++i) {
        StmtNode *declStmt=declStmts.front();
        declStmts.pop();
        dynamic_cast<DeclStmt*>(declStmt)->genCode();
        declStmts.push(declStmt);
    }
}

void WhileStmt::genCode() {
    Function* func;
    BasicBlock *cond_bb, *while_bb, *end_bb, *bb;

    bb = builder->getInsertBB();
    func = builder->getInsertBB()->getParent();

    cond_bb = new BasicBlock(func);
    while_bb = new BasicBlock(func);
    end_bb = new BasicBlock(func);

    new UncondBrInstruction(cond_bb, bb);

    builder->setInsertBB(cond_bb);
    cond->genCode();
    backPatch(cond->trueList(), while_bb);
    backPatch(cond->falseList(), end_bb);

    builder->setInsertBB(while_bb);
    stmt->genCode();
    while_bb = builder->getInsertBB();
    new UncondBrInstruction(cond_bb, while_bb);

    builder->setInsertBB(end_bb);
}

void FuncRParamExpr::genCode() {
    for(auto iter=params.begin();iter!=params.end();iter++){
        (*iter)->genCode();
    }
}

void CallExpr::genCode() {

}

void ExprStmt::genCode() {
    expr->genCode();
}

void Ast::typeCheck()
{
    if(root != nullptr)
        root->typeCheck();
}

void ExprNode::typeCheck() {
    return;
}

void FunctionDef::typeCheck()
{
    if (nullptr==se){
        fprintf(stderr, "no se in FunctionDef\n");
        exit(EXIT_FAILURE);
    }
    if (nullptr==stmt){
        fprintf(stderr, "no stmt in FunctionDef\n");
        exit(EXIT_FAILURE);
    }
    if (nullptr!=decl){
        decl->typeCheck();
    }

    stmt->typeCheck();

    Type *type1=se->getType();
    Type *type2=stmt->getNodeType();

    if (type1->isFunc()){
        type1=dynamic_cast<FunctionType*>(type1)->getRetType();
    }
    if (type2->isFunc()){
        type2=dynamic_cast<FunctionType*>(type2)->getRetType();
    }
    if (type1->getKind()==type2->getKind()){
        return;
    }
    if((type1->isFloat()&&type2->isInt())||
       (type1->isInt()&&type2->isFloat())){
        return;
    }
    fprintf(stderr, "The return value's type %s and the function %s's type %s do not match\n",
            type2->toStr().c_str(),se->toStr().c_str(), type1->toStr().c_str());
    exit(EXIT_FAILURE);
}

void BinaryExpr::typeCheck()
{
    if (nullptr==expr1){
        fprintf(stderr, "no expr1 in BinaryExpr\n");
        exit(EXIT_FAILURE);
    }
    if (nullptr==expr2){
        fprintf(stderr, "no expr2 in BinaryExpr\n");
        exit(EXIT_FAILURE);
    }
    expr1->typeCheck();
    expr2->typeCheck();

    Type *type1 = expr1->getSymbolEntry()->getType();
    Type *type2 = expr2->getSymbolEntry()->getType();
    exprTypeCheck(type1,type2);
}

void Constant::typeCheck(){
    if (nullptr==symbolEntry){
        fprintf(stderr, "no symbolEntry in Constant\n");
        exit(EXIT_FAILURE);
    }
    return;
}

void Id::typeCheck(){
    if (nullptr==symbolEntry){
        fprintf(stderr, "no symbolEntry in Id\n");
        exit(EXIT_FAILURE);
    }
    return;
}

void IfStmt::typeCheck()
{
    if(!this->cond) {
        fprintf(stderr, "no cond expr in IfStmt\n");
        exit(EXIT_FAILURE);
    }
    if(!this->thenStmt){
        fprintf(stderr, "no then stmt in IfStmt\n");
        exit(EXIT_FAILURE);
    }
    cond->typeCheck();
    Type*condType=cond->getSymbolEntry()->getType();
    if (!condType->isInt()){
        fprintf(stderr, "the result of conditional operation isn't int type in IfStmt\n");
        exit(EXIT_FAILURE);
    }

    thenStmt->typeCheck();
    this->setNodeType(thenStmt->getNodeType());
}

void IfElseStmt::typeCheck(){
    if(!this->cond) {
        fprintf(stderr, "no cond expr in IfElseStmt\n");
        exit(EXIT_FAILURE);
    }
    if(!this->thenStmt){
        fprintf(stderr, "no then stmt in IfElseStmt\n");
        exit(EXIT_FAILURE);
    }
    if(!this->elseStmt){
        fprintf(stderr, "no else stmt in IfElseStmt\n");
        exit(EXIT_FAILURE);
    }
    cond->typeCheck();
    Type*condType=cond->getSymbolEntry()->getType();
    if (!condType->isInt()){
        fprintf(stderr, "the result of conditional operation isn't int type in IfElseStmt\n");
        exit(EXIT_FAILURE);
    }

    thenStmt->typeCheck();
    elseStmt->typeCheck();

    Type*type1=thenStmt->getNodeType();
    Type*type2=elseStmt->getNodeType();

    this->stmtTypeCheck(type1,type2);
}

void CompoundStmt::typeCheck(){
    if(!stmt){
        return;
    }
    stmt->typeCheck();
    this->setNodeType(stmt->getNodeType());
}

void SeqNode::typeCheck()
{
    if(!this->stmt1){
        fprintf(stderr, "no stmt1 in SeqNode\n");
        exit(EXIT_FAILURE);
    }
    if(!this->stmt2){
        fprintf(stderr, "no stmt2 in SeqNode\n");
        exit(EXIT_FAILURE);
    }
    stmt1->typeCheck();
    stmt2->typeCheck();

    if (stmt1->isFunctionDefStmt()&&stmt2->isFunctionDefStmt()){
        return;
    }

    Type*type1=stmt1->getNodeType();
    Type*type2=stmt2->getNodeType();

    this->stmtTypeCheck(type1,type2);
}

void DeclStmt::typeCheck()
{
    if (nullptr==expr){
        id->typeCheck();
        return;
    }
    expr->typeCheck();

    Type*type1=id->getSymbolEntry()->getType();
    Type*type2=expr->getSymbolEntry()->getType();
    exprTypeCheck(type1,type2);
}

void ReturnStmt::typeCheck()
{
    // Todo
    if (nullptr == retValue){
        // The default value of nodeType is VoidType()
        return;
    }
    retValue->typeCheck();
    this->setNodeType(retValue->getSymbolEntry()->getType());
}

void AssignStmt::typeCheck()
{
    // Todo
    if (nullptr == lval){
        fprintf(stderr, "no lval in AssignStmt\n");
        exit(EXIT_FAILURE);
    }
    if (nullptr == expr){
        fprintf(stderr, "no expr in AssignStmt\n");
        exit(EXIT_FAILURE);
    }
    lval->typeCheck();
    expr->typeCheck();

    Type*type1=lval->getSymbolEntry()->getType();
    Type*type2=expr->getSymbolEntry()->getType();
    exprTypeCheck(type1,type2);
}

void UnaryExpr::typeCheck() {
    if (expr== nullptr){
        fprintf(stderr, "no expr in UnaryExpr\n");
        exit(EXIT_FAILURE);
    }
    expr->typeCheck();
    return;
}

void DeclStmts::typeCheck() {
    if(declStmts.empty()){
        fprintf(stderr, "no declStmt in DeclStmts\n");
        exit(EXIT_FAILURE);
    }
    for (long unsigned int i = 0; i < declStmts.size(); ++i) {
        StmtNode *declStmt=declStmts.front();
        declStmts.pop();
        dynamic_cast<DeclStmt*>(declStmt)->typeCheck();
        declStmts.push(declStmt);
    }
}

void WhileStmt::typeCheck() {
    if (cond == nullptr){
        fprintf(stderr, "no cond in WhileStmt\n");
        exit(EXIT_FAILURE);
    }
    cond->typeCheck();
    Type*condType=cond->getSymbolEntry()->getType();
    if (!condType->isInt()){
        fprintf(stderr, "the result of conditional operation isn't int type in WhileStmt\n");
        exit(EXIT_FAILURE);
    }

    if (stmt == nullptr){
        fprintf(stderr, "no stmt in WhileStmt\n");
        exit(EXIT_FAILURE);
    }
    stmt->typeCheck();
    this->setNodeType(stmt->getNodeType());
}

void FuncRParamExpr::typeCheck() {
    for (auto i = 0; i < params.size(); ++i) {
        params[i]->typeCheck();
    }
    return;
}

void CallExpr::typeCheck() {
    FunctionType*functionType=dynamic_cast<FunctionType*>(symbolEntry->getType());
    std::vector<SymbolEntry*>fParams=functionType->getParamsSymbolEntry();

    std::vector<SymbolEntry*>rParams;
    FuncRParamExpr*funcRParamExpr=dynamic_cast<FuncRParamExpr*>(this->rParams);
    std::vector<ExprNode*> exprNodes=funcRParamExpr->getParams();
    for(auto iter=exprNodes.begin();iter!=exprNodes.end();iter++){
        rParams.push_back((*iter)->getSymbolEntry());
    }

    // sysy doesn't support FParams to have default values
    // Such a nice features for developer
    if (rParams.size()!=fParams.size()){
        fprintf(stderr, "The number of RParams and LParams doesn't match, "
                        "RParams is %ld and LParams is %ld.\n",rParams.size(),fParams.size());
        exit(EXIT_FAILURE);
    }
    for (auto i = 0; i < rParams.size(); ++i) {
        Type*type1=rParams[i]->getType();
        Type*type2=fParams[i]->getType();
        if (type1->getKind()==type2->getKind()){
            continue;
        }
        if (type1->isInt()&&type2->isFloat()){
            continue;
        }
        if (type2->isInt()&&type1->isFloat()){
            continue;
        }
        fprintf(stderr, "a rParam doesn't match fParam."
                        "rParam is %s and fParam is %s.\n",type1->toStr().c_str(), type2->toStr().c_str());
        exit(EXIT_FAILURE);
    }
    return;
}

void ExprStmt::typeCheck() {
    return;
}

void BinaryExpr::output(int level)
{
    std::string op_str;
    switch(op)
    {
        case ADD:
            op_str = "add";
            break;
        case SUB:
            op_str = "sub";
            break;
        case AND:
            op_str = "and";
            break;
        case OR:
            op_str = "or";
            break;
        case EQ:
            op_str = "equal";
            break;
        case NEQ:
            op_str = "unequal";
            break;
        case LESS:
            op_str = "less";
            break;
        case LESSEQ:
            op_str = "less equal";
            break;
        case GREATER:
            op_str = "greater";
            break;
        case GREATEREQ:
            op_str = "greater equal";
            break;
        case MUL:
            op_str = "mul";
            break;
        case DIV:
            op_str = "div";
            break;
        case MOD:
            op_str = "mod";
            break;
    }
    fprintf(yyout, "%*cBinaryExpr\top: %s\n", level, ' ', op_str.c_str());
    expr1->output(level + 4);
    expr2->output(level + 4);
}

void Ast::output()
{
    fprintf(yyout, "program\n");
    if(root != nullptr)
        root->output(4);
}

void UnaryExpr::output(int level)
{
    std::string op_str;
    switch(op)
    {
        case ADD:
            op_str = "plus";
            break;
        case SUB:
            op_str = "uminus";
            break;
        case NOT:
            op_str = "not";
            break;
    }
    fprintf(yyout, "%*cUnaryExpr\top: %s\n", level, ' ', op_str.c_str());
    expr->output(level + 4);
}

void Constant::output(int level)
{
    std::string type, value;
    type = symbolEntry->getType()->toStr();
    value = symbolEntry->toStr();
    fprintf(yyout, "%*cIntegerLiteral\tvalue: %s\ttype: %s\n", level, ' ',
            value.c_str(), type.c_str());
}

void Id::output(int level)
{
    std::string name, type;
    int scope;
    name = symbolEntry->toStr();
    type = symbolEntry->getType()->toStr();
    scope = dynamic_cast<IdentifierSymbolEntry*>(symbolEntry)->getScope();
    fprintf(yyout, "%*cId\tname: %s\tscope: %d\ttype: %s\n", level, ' ',
            name.c_str(), scope, type.c_str());
}

void CompoundStmt::output(int level)
{
    fprintf(yyout, "%*cCompoundStmt\n", level, ' ');
    if(nullptr!=stmt)
        stmt->output(level + 4);
}

void SeqNode::output(int level)
{
    if(nullptr!=stmt1)
        stmt1->output(level);
    if(nullptr!=stmt1)
        stmt2->output(level);
}

void DeclStmt::output(int level)
{
    fprintf(yyout, "%*cDeclStmt\n", level, ' ');
    id->output(level + 4);
    if(nullptr!=expr){
        expr->output(level+4);
    }
}

Id *DeclStmt::getId() const{
    return id;
}

void IfStmt::output(int level)
{
    fprintf(yyout, "%*cIfStmt\n", level, ' ');
    if(nullptr!=cond)
        cond->output(level + 4);
    if(nullptr!=thenStmt)
        thenStmt->output(level + 4);
}

void IfElseStmt::output(int level)
{
    fprintf(yyout, "%*cIfElseStmt\n", level, ' ');
    cond->output(level + 4);
    thenStmt->output(level + 4);
    elseStmt->output(level + 4);
}

void ReturnStmt::output(int level)
{
    fprintf(yyout, "%*cReturnStmt\n", level, ' ');
    if (retValue)
        retValue->output(level + 4);
}

void AssignStmt::output(int level)
{
    fprintf(yyout, "%*cAssignStmt\n", level, ' ');
    lval->output(level + 4);
    expr->output(level + 4);
}

void FunctionDef::output(int level)
{
    std::string name, type;
    name = se->toStr();
    type = se->getType()->toStr();
    fprintf(yyout, "%*cFunctionDefine function name: %s, type: %s\n", level, ' ', 
            name.c_str(), type.c_str());
    if (nullptr!=decl)
        decl->output(level + 4);
    stmt->output(level + 4);
}

void DeclStmts::insertDeclStmt(StmtNode *declStmt) {
    declStmts.push(declStmt);
}

void DeclStmts::output(int level) {
    fprintf(yyout, "%*cDeclStmts\n", level, ' ');
    for (long unsigned int i = 0; i < declStmts.size(); ++i) {
        StmtNode *declStmt=declStmts.front();
        declStmts.pop();
        dynamic_cast<DeclStmt*>(declStmt)->output(level+4);
        declStmts.push(declStmt);
    }
}

std::vector<SymbolEntry *> DeclStmts::getId() {
    std::vector<SymbolEntry *> symbolEntry;
    if(declStmts.empty()){
        return symbolEntry;
    }
    for (long unsigned int i = 0; i < declStmts.size(); ++i) {
        StmtNode *declStmt=declStmts.front();
        declStmts.pop();
        symbolEntry.push_back(dynamic_cast<DeclStmt*>(declStmt)->
                getId()->getSymbolEntry());
        declStmts.push(declStmt);
    }
    return symbolEntry;
}

void WhileStmt::output(int level) {
    fprintf(yyout, "%*cWhileStmt\n", level, ' ');
    cond->output(level + 4);
    stmt->output(level + 4);
}

SymbolEntry *ExprNode::getSymbolEntry() const {
    return symbolEntry;
}

void FuncRParamExpr::output(int level) {
    fprintf(yyout, "%*cFuncRParamExpr\n", level, ' ');
    for (long unsigned int i = 0; i < params.size(); ++i) {
        ExprNode* param=params[i];
        param->output(level + 4);
    }
}

void FuncRParamExpr::insertParam(ExprNode *Exp) {
    params.push_back(Exp);
}

void CallExpr::output(int level) {
    std::string name, type;
    int scope;
    name = symbolEntry->toStr();
    type = symbolEntry->getType()->toStr();
    scope = dynamic_cast<IdentifierSymbolEntry*>(symbolEntry)->getScope();
    fprintf(yyout, "%*cCallExpr\tname: %s\tscope: %d\ttype: %s\n", level, ' ',
            name.c_str(), scope, type.c_str());
    if (nullptr != rParams)
        rParams->output(level + 4);
}

void ExprStmt::output(int level) {
    expr->output(level);
}
