#include "Ast.h"
#include "SymbolTable.h"
#include <string>
#include "Type.h"

// just use to merge

extern FILE *yyout;
int Node::counter = 0;

Node::Node()
{
    seq = counter++;
}

void Ast::output()
{
    fprintf(yyout, "program\n");
    if(root != nullptr)
        root->output(4);
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
    fprintf(yyout, "%*cSequence\n", level, ' ');
    if(nullptr!=stmt1)
        stmt1->output(level + 4);
    if(nullptr!=stmt2)
        stmt2->output(level + 4);
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
    while (declStmts.size()){
        StmtNode *declStmt=declStmts.front();
        declStmt->output(level + 4);
        declStmts.pop();
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
    if (nullptr!=params)
        params->output(level+4);
}

void ExprStmt::output(int level) {
    expr->output(level);
}
