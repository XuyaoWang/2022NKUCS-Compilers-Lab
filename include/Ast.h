#ifndef __AST_H__
#define __AST_H__

#include <fstream>
#include <queue>
#include <iostream>

class SymbolEntry;

class Node
{
private:
    // static variable counter is used to record how many Nodes are created
    static int counter;

    // seq is used to record the sequence that was created
    int seq;
public:
    Node();
    int getSeq() const {return seq;};

    // level is used to control the form of output,
    // which determines how may space will be printed on outfile
    virtual void output(int level) = 0;
};

class ExprNode : public Node
{
protected:
    SymbolEntry *symbolEntry;
public:
    ExprNode(SymbolEntry *symbolEntry) : symbolEntry(symbolEntry){};

    SymbolEntry *getSymbolEntry() const;
};

class BinaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr1, *expr2;
public:
    enum {ADD, SUB, AND, OR, EQ, NEQ,LESS, LESSEQ , GREATER, GREATEREQ,MUL, DIV, MOD};
    BinaryExpr(SymbolEntry *se, int op, ExprNode*expr1, ExprNode*expr2) : ExprNode(se), op(op), expr1(expr1), expr2(expr2){};
    void output(int level);
};

class UnaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr;
public:
    enum {ADD, SUB, NOT};
    UnaryExpr(SymbolEntry *se, int op, ExprNode*expr) : ExprNode(se), op(op), expr(expr){};
    void output(int level);
};

class CallExpr : public ExprNode{
private:
    ExprNode* params;

public:
    CallExpr(SymbolEntry* se,
             ExprNode* params= nullptr):
             ExprNode(se),params(params){};
    void output(int level);
};

class FuncRParamExpr : public ExprNode{
private:
    std::vector<ExprNode*> params;
public:
    FuncRParamExpr(SymbolEntry *se) : ExprNode(se) {};
    void insertParam(ExprNode *Exp);
    void output(int level);
};

class Constant : public ExprNode
{
public:
    Constant(SymbolEntry *se) : ExprNode(se){};
    void output(int level);
};

// class Id is the identifier of a variable or a constant
class Id : public ExprNode
{
public:
    Id(SymbolEntry *se) : ExprNode(se){};
    void output(int level);

};

class StmtNode : public Node
{};

class CompoundStmt : public StmtNode
{
private:
    StmtNode *stmt;
public:
    CompoundStmt(StmtNode *stmt) : stmt(stmt) {};
    void output(int level);
};

class SeqNode : public StmtNode
{
private:
    StmtNode *stmt1, *stmt2;
public:
    SeqNode(StmtNode *stmt1, StmtNode *stmt2) : stmt1(stmt1), stmt2(stmt2){};
    void output(int level);
};

class DeclStmt : public StmtNode
{
private:
    Id *id;
    ExprNode* expr;
public:
    DeclStmt(Id *id,ExprNode* expr = nullptr) : id(id),expr(expr){};
    void output(int level);

    Id *getId() const;
};

class DeclStmts:public StmtNode{
private:
    std::queue<StmtNode*> declStmts;
public:
    DeclStmts(){};
    void insertDeclStmt(StmtNode*declStmt);
    void output(int level);
    std::vector<SymbolEntry*>getId();
};

class IfStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
public:
    IfStmt(ExprNode *cond, StmtNode *thenStmt) : cond(cond), thenStmt(thenStmt){};
    void output(int level);
};

class IfElseStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
    StmtNode *elseStmt;
public:
    IfElseStmt(ExprNode *cond, StmtNode *thenStmt, StmtNode *elseStmt) : cond(cond), thenStmt(thenStmt), elseStmt(elseStmt) {};
    void output(int level);
};

class ReturnStmt : public StmtNode
{
private:
    ExprNode *retValue;
public:
    ReturnStmt(ExprNode*retValue) : retValue(retValue) {};
    void output(int level);
};

class WhileStmt:public StmtNode{
private:
    ExprNode* cond;
    StmtNode* stmt;
public:
    WhileStmt(ExprNode*cond,StmtNode*stmt):cond(cond),stmt(stmt){}
    void output(int level);
};

class AssignStmt : public StmtNode
{
private:
    ExprNode *lval;
    ExprNode *expr;
public:
    AssignStmt(ExprNode *lval, ExprNode *expr) : lval(lval), expr(expr) {};
    void output(int level);
};

class ExprStmt : public StmtNode {
private:
    ExprNode* expr;

public:
    ExprStmt(ExprNode* expr) : expr(expr){};
    void output(int level);
};

class FunctionDef : public StmtNode
{
private:
    SymbolEntry *se;
    StmtNode* decl;
    StmtNode *stmt;
public:
    FunctionDef(SymbolEntry *se,StmtNode* decl, StmtNode *stmt) : se(se), decl(decl),stmt(stmt){};
    void output(int level);
};

class Ast
{
private:
    Node* root;
public:
    Ast() {root = nullptr;}
    void setRoot(Node*n) {root = n;}
    void output();
};

#endif
