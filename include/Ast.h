#ifndef __AST_H__
#define __AST_H__

#include <fstream>
#include <queue>
#include <iostream>
#include "Operand.h"
#include "Type.h"
#include "Utils.h"

class SymbolEntry;
class Unit;
class Function;
class BasicBlock;
class Instruction;
class IRBuilder;


// ----------{comment begin for generating intermediate code}--------------
//
// Compared with the last lab(in 2022 compiler lab is lab4), this lab
// add six modules,including BasicBlock,Function,Instruction,IRBuilder,
// Operand and Unit.
// How to understand the usage of these modules?
// The main function is realized by modules except IRBuilder.In my understanding,
// IRBuilder is a handle which simplifies our coding.IRBuilder contains two members
// which are Unit and BasicBlock. The member that is Unit is the entry of generating
// intermediate code and the other member is a pointer pointing to an entity (may not
// be the first entity of BasicBlock), which is used to insert new code block.
// The rest part is the core section to generate intermediate code. I think the relation
// in these module are as follows:
// * Think of all intermediate code as a set,Instruction is the basic element of the set.
// * Instruction is composed of Type and Operand
// * BasicBlock is the set of Instruction,each element is linked by double linked chain,and all
//   elements are pointer to a BasicBlock
// * Function is the set of BasicBlock,the form of elements is similar to set BasicBloc.
//   A single BasicBlock is also seen as a Function.(obviously)
// * Unit is the set of Function,the form is as above.
//
// read main.cpp,the order of this lab is
// 1. lexical analysis
// 2. syntax analysis(optional:generate syntax tree)
// 3. typeCheck
// 4. generate intermediate code(from button to top,from Instruction to BasicBlock to
//    Function to Unit)
// plus:the order of generate is from button to top,but in the process of implementing
//      the function is a recursion.From top check if subtree has generated intermediate
//      code.If yes,backtrace; If no, go more deeply.
//
// ----------{comment end for generating intermediate code}--------------

class Node
{
private:
    // static variable counter is used to record how many Nodes are created
    static int counter;

    // seq is used to record the sequence that was created
    int seq;
protected:
    std::vector<Instruction*> true_list;
    std::vector<Instruction*> false_list;

    // builder is a handle to generate IR
    static IRBuilder *builder;
    void backPatch(std::vector<Instruction*> &list, BasicBlock*bb);
    std::vector<Instruction*> merge(std::vector<Instruction*> &list1, std::vector<Instruction*> &list2);

public:
    Node();
    int getSeq() const {return seq;};

    // level is used to control the form of output,
    // which determines how may space will be printed on outfile
    static void setIRBuilder(IRBuilder*ib) {builder = ib;};
    virtual void output(int level) = 0;
    virtual void typeCheck() = 0;
    virtual void genCode() = 0;
    std::vector<Instruction*>& trueList() {return true_list;}
    std::vector<Instruction*>& falseList() {return false_list;}
};

class ExprNode : public Node
{
protected:
    SymbolEntry *symbolEntry;
    Operand *dst;
    int kind;
    bool isCond= false;
public:
    Operand* getOperand() {return dst;};
    void setOperand(Operand* dst){ this->dst=dst;};

    SymbolEntry * getSymPtr() {return symbolEntry;};
    void setSymPtr(SymbolEntry* symbolEntry){ this->symbolEntry=symbolEntry;};
protected:
    //Todo
    enum{
        CALL,
        BINARY,
        CONSTANT,
        UNARY
    };
public:
    void output(int level) override;
    void genCode() override;
    void typeCheck() override;

public:
    ExprNode(SymbolEntry *symbolEntry,int kind=-1) : symbolEntry(symbolEntry),kind(kind){};

    //Todo
    bool isCondExpr(){return isCond;};
    void setCondExpr(){isCond= true;};
    void unsetCondExpr(){isCond= false;};
    bool isConstantExpr()const{return kind==CONSTANT;};
    bool isBinaryExpr()const{return kind==BINARY;};
    bool isUnaryExpr()const{return kind==UNARY;};
    int getKind(){return kind;};

};

class ImplicitCastExpr : public ExprNode {
private:
    ExprNode* srcExpr;
public:
    ImplicitCastExpr(ExprNode* srcExpr, Type* dstType = TypeSystem::boolType)
            : ExprNode(symbolEntry), srcExpr(srcExpr) {

        symbolEntry = new TemporarySymbolEntry(dstType, SymbolTable::getLabel());
        dst = new Operand(symbolEntry);
    };

    void output(int level) override;
    void genCode() override;
    void typeCheck() override;

    ExprNode* getSrcExpr() { return srcExpr; };
};

class BinaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr1, *expr2;
public:
    enum {ADD, SUB, MUL, DIV, MOD, AND, OR, EQ, NEQ,LESS, LESSEQ , GREATER, GREATEREQ};
    BinaryExpr(SymbolEntry *se, int op, ExprNode*expr1, ExprNode*expr2) : ExprNode(se,ExprNode::BINARY), op(op), expr1(expr1), expr2(expr2){};
    void output(int level);
    void typeCheck();
    void genCode();
    int getOp(){return op;};
    ExprNode *getExpr1(){return expr1;};
    void setExpr1(ExprNode*expr){expr1=expr;};
    ExprNode *getExpr2(){return expr2;};
    void setExpr2(ExprNode*expr){expr2=expr;};
};

class UnaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr;
public:
    enum {ADD, SUB, NOT};
    UnaryExpr(SymbolEntry *se, int op, ExprNode*expr) : ExprNode(se,ExprNode::UNARY), op(op), expr(expr){};
    void output(int level);
    void typeCheck();
    void genCode();
    int getOp(){return op;};
    ExprNode*getExpr(){return expr;};
    void setExpr(ExprNode*exprNode){expr=exprNode;};
};

class CallExpr : public ExprNode{
private:
    ExprNode* rParams;

public:
    CallExpr(SymbolEntry* se,
             ExprNode* params= nullptr);
    void output(int level);
    void typeCheck();
    void genCode();
};

class FuncRParamExpr : public ExprNode{
private:
    std::vector<ExprNode*> params;
public:
    FuncRParamExpr(SymbolEntry *se) : ExprNode(se) {};
    void insertParam(ExprNode *Exp);
    std::vector<ExprNode*> getParams(){return params;};
    std::vector<Operand*> getOperands();
    void output(int level);
    void typeCheck();
    void genCode();
};

class Constant : public ExprNode
{
public:
    Constant(SymbolEntry *se) : ExprNode(se){dst = new Operand(se);};
    void output(int level);
    void typeCheck();
    void genCode();
};

// class Id is the identifier of a variable or a constant
class Id : public ExprNode
{
public:
    Id(SymbolEntry *se) : ExprNode(se){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class StmtNode : public Node
{
private:
    // For exprNode,nodeType is the type of corresponding expression
    // For stmtNode,if it's descendants contain ReturnStmt,it's nodeType is
    // corresponding type.Otherwise, it's type is nullptr
    Type*nodeType;

    int kind;
protected:
    //Todo:complete enum
    enum{
        ASSIGN,
        FUNCDEF,
        COMPOUND};
public:
    bool isAssignStmt() const{return kind==ASSIGN;};
    bool isFunctionDefStmt() const{return kind==FUNCDEF;};
    bool isCompoundStmt() const{return kind==COMPOUND;};

    int getKind() const {return kind;};

    StmtNode(int kind=-1):kind(kind){nodeType=new VoidType();};

    Type*getNodeType();
    void setNodeType(Type* nodeType);
};

class CompoundStmt : public StmtNode
{
private:
    StmtNode *stmt;
public:
    CompoundStmt(StmtNode *stmt) : StmtNode(StmtNode::COMPOUND), stmt(stmt) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class SeqNode : public StmtNode
{
private:
    StmtNode *stmt1, *stmt2;
public:
    SeqNode(StmtNode *stmt1, StmtNode *stmt2) : stmt1(stmt1), stmt2(stmt2){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class DeclStmt : public StmtNode
{
private:
    Id *id;
    ExprNode* expr;
public:
    DeclStmt(Id *id,ExprNode* expr = nullptr) : id(id),expr(expr){};
    void output(int level) override;
    void typeCheck() override;
    void genCode() override;

    Id *getId() const;
};

class DeclStmts:public StmtNode{
private:
    std::queue<StmtNode*> declStmts;
public:
    DeclStmts(){};
    void insertDeclStmt(StmtNode*declStmt);
    void output(int level);
    std::vector<SymbolEntry*>getSymbolEntrys();
    void typeCheck();
    void genCode();
};

class IfStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
public:
    IfStmt(ExprNode *cond, StmtNode *thenStmt) : cond(cond), thenStmt(thenStmt){cond->setCondExpr();};
    void output(int level);
    void typeCheck();
    void genCode();
};

class IfElseStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
    StmtNode *elseStmt;
public:
    IfElseStmt(ExprNode *cond, StmtNode *thenStmt, StmtNode *elseStmt) : cond(cond), thenStmt(thenStmt), elseStmt(elseStmt) {cond->setCondExpr();};
    void output(int level);
    void typeCheck();
    void genCode();
};

class WhileStmt:public StmtNode{
private:
    ExprNode* cond;
    StmtNode* stmt;
public:
    WhileStmt(ExprNode*cond,StmtNode*stmt):cond(cond),stmt(stmt){cond->setCondExpr();};
    void output(int level);
    void typeCheck();
    void genCode();
};

class ReturnStmt : public StmtNode
{
private:
    ExprNode *retValue;
public:
    ReturnStmt(ExprNode*retValue) : retValue(retValue) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class AssignStmt : public StmtNode
{
private:
    ExprNode *lval;
    ExprNode *expr;
public:
    AssignStmt(ExprNode *lval, ExprNode *expr) : lval(lval), expr(expr) {

    };
    void output(int level);
    void typeCheck();
    void genCode();
};

class ExprStmt : public StmtNode {
private:
    ExprNode* expr;

public:
    ExprStmt(ExprNode* expr) : expr(expr){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class FunctionDef : public StmtNode
{
private:
    SymbolEntry *se;
    StmtNode* decl;
    StmtNode *stmt;
public:
    FunctionDef(SymbolEntry *se,StmtNode* decl, StmtNode *stmt) :StmtNode(StmtNode::FUNCDEF), se(se), decl(decl),stmt(stmt){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class Ast
{
private:
    Node* root;
public:
    Ast() {root = nullptr;}
    void setRoot(Node*n) {root = n;}
    void output();
    void typeCheck();
    void genCode(Unit *unit);
};

#endif
