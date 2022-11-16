%code top{
    #include <iostream>
    #include <assert.h>
    #include "parser.h"
    extern Ast ast;
    int yylex();
    int yyerror( char const * );

    Type* curType; //this varible is used to solve Tye invisible problems while declaring idlist
}

%code requires {
    #include "Ast.h"
    #include "SymbolTable.h"
    #include "Type.h"
}

%union {
    int itype;
    float ftype;
    char* strtype;
    StmtNode* stmttype;
    ExprNode* exprtype;
    Type* type;
}

%start Program
%token <strtype> ID 
%token <itype> INTEGER
%token <ftype> FLOATING
%token CONST
%token IF ELSE
%token WHILE CONTINUE BREAK
%token INT VOID FLOAT
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE SEMICOLON COMMA
%token ASSIGN ADD SUB MUL DIV MOD
%token OR AND NOT
%token EQ NEQ GREATER GREATEREQ LESS LESSEQ
%token RETURN
%token LINECOMMENT BLOCKCOMMENT

%nterm <stmttype> Stmts Stmt AssignStmt BlockStmt IfStmt ReturnStmt DeclStmt FuncDef WhileStmt ExprStmt
%nterm <stmttype> ConstDeclStmt ConstDefList ConstDef
%nterm <stmttype> VarDeclStmt VarDefList VarDef
%nterm <stmttype> FuncFParams FuncFParam

%nterm <exprtype> Exp MulExp AddExp PrimaryExp LVal NUMBER UnaryExp
%nterm <exprtype> ConstInitVal ConstExp InitVal
%nterm <exprtype> LOrExp LAndExp Cond
%nterm <exprtype> EqExp RelExp
%nterm <exprtype> FuncRParams
%nterm <type> Type

%precedence THEN
%precedence ELSE
%%

Program
    : Stmts {
        ast.setRoot($1);
    }
    ;
Stmts
    : Stmt {$$=$1;}
    | Stmts Stmt{
        $$ = new SeqNode($1, $2);
    }
    ;
Stmt
    : AssignStmt {$$=$1;}
    | BlockStmt {$$=$1;}
    | IfStmt {$$=$1;}
    | ReturnStmt {$$=$1;}
    | DeclStmt {$$=$1;}
    | FuncDef {$$=$1;}
    | WhileStmt {$$=$1;}
    | SEMICOLON {$$=nullptr;} // deal with empty stmt
    | ExprStmt {$$=$1;}
    ;
// TODO
// LVal -> Ident[Exp]
LVal
    : ID {
        SymbolEntry *se;
        se = identifiers->lookup($1);
        if(se == nullptr)
        {
            fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
            delete [](char*)$1;
            assert(se != nullptr);
        }

        $$ = new Id(se);
        delete []$1;
    }
    ;
AssignStmt
    :
    LVal ASSIGN Exp SEMICOLON {
        $$ = new AssignStmt($1, $3);
    }
    ;
BlockStmt
    :
    LBRACE
    {identifiers = new SymbolTable(identifiers);}
    Stmts RBRACE
    {
        $$ = new CompoundStmt($3);
        SymbolTable *top = identifiers;
        identifiers = identifiers->getPrev();
        delete top;
    }
    |LBRACE RBRACE {
        $$ = new CompoundStmt(nullptr);
    }
    ;
IfStmt
    : IF LPAREN Cond RPAREN Stmt %prec THEN {
        $$ = new IfStmt($3, $5);
    }
    | IF LPAREN Cond RPAREN Stmt ELSE Stmt {
        $$ = new IfElseStmt($3, $5, $7);
    }
    ;

WhileStmt
    : WHILE LPAREN Cond RPAREN Stmt{
        $$ = new WhileStmt($3,$5);
    }

ReturnStmt
    :
    RETURN Exp SEMICOLON{
        $$ = new ReturnStmt($2);
    }
    ;
Exp
    :
    AddExp {$$ = $1;}
    ;
Cond
    :
    LOrExp {$$ = $1;}
    ;
PrimaryExp
    :
    LPAREN Exp RPAREN{$$=$2;}
    |
    LVal {$$ = $1;}
    |
    NUMBER{$$=$1;}
    ;

NUMBER
    :
    INTEGER {
        SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::intType, $1);
        $$ = new Constant(se);
    }
    |
    FLOATING{}
    ;

UnaryExp
    :
    PrimaryExp{$$=$1;}
    |
    ADD UnaryExp{
        SymbolEntry *se=new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new UnaryExpr(se,UnaryExpr::ADD,$2);
    }
    |
    SUB UnaryExp{
        SymbolEntry *se=new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new UnaryExpr(se,UnaryExpr::SUB,$2);
    }
    |
    NOT UnaryExp{
        SymbolEntry *se=new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new UnaryExpr(se,UnaryExpr::NOT,$2);
    }
    |
    ID LPAREN FuncRParams RPAREN{
        SymbolEntry* se;
        se = identifiers->lookup($1);
        // TODO
        // check if function has been defined
        $$ = new CallExpr(se, $3);
    }
    ;

FuncRParams
    :
    FuncRParams COMMA Exp{
        $$=$1;
        FuncRParamExpr*temp=dynamic_cast<FuncRParamExpr*>($$);
        temp->insertParam($3);
    }
    |
    Exp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
    	$$=new FuncRParamExpr(se);
    	FuncRParamExpr*temp=dynamic_cast<FuncRParamExpr*>($$);
        temp->insertParam($1);
    }
    |
    %empty{$$=nullptr;}
    ;

AddExp
    :
    MulExp{$$=$1;}
    |
    AddExp ADD MulExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::ADD, $1, $3);
    }
    |
    AddExp SUB MulExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::SUB, $1, $3);
    }
    ;

MulExp
    :
    UnaryExp{$$=$1;}
    |
    MulExp MUL UnaryExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::MUL, $1, $3);
    }
    |
    MulExp DIV UnaryExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::DIV, $1, $3);
    }
    |
    MulExp MOD UnaryExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::MOD, $1, $3);
    }
    ;

RelExp
    :
    AddExp {$$ = $1;}
    |
    RelExp LESS AddExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::LESS, $1, $3);
    }
    |
    RelExp LESSEQ AddExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::LESSEQ, $1, $3);
    }
    |
    RelExp GREATER AddExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::GREATER, $1, $3);
    }
    |
    RelExp GREATEREQ AddExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::GREATEREQ, $1, $3);
    }
    ;
EqExp
    :
    RelExp {$$ = $1;}
    |
    EqExp EQ RelExp {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::EQ, $1, $3);
    }
    |
    EqExp NEQ RelExp {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::NEQ, $1, $3);
    }
    ;

LAndExp
    :
    EqExp {$$ = $1;}
    |
    LAndExp AND EqExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::AND, $1, $3);
    }
    ;
LOrExp
    :
    LAndExp {$$ = $1;}
    |
    LOrExp OR LAndExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::OR, $1, $3);
    }
    ;
ExprStmt
    : Exp SEMICOLON {
        $$ = new ExprStmt($1);
    }
    ;
Type
    : INT {
        $$ = TypeSystem::intType;
        curType = TypeSystem::intType;
    }
    | VOID {
        $$ = TypeSystem::voidType;
    }
    | FLOAT {
    	$$ = TypeSystem::floatType;
    	curType = TypeSystem::floatType;
    }
    ;
DeclStmt
    :
    ConstDeclStmt {$$=$1;}
    |
    VarDeclStmt {$$=$1;}
    ;

ConstDeclStmt
    :
    CONST Type ConstDefList SEMICOLON{$$=$3;}
    ;

ConstDefList
    :
    ConstDefList COMMA ConstDef {
        $$=$1;
        DeclStmts*temp=dynamic_cast<DeclStmts*>($$);
        if(temp!=nullptr){
            temp->insertDeclStmt($3);
        }
    }
    |
    ConstDef {
        $$=new DeclStmts();
        DeclStmts*temp=dynamic_cast<DeclStmts*>($$);
        if(nullptr!=temp){
            temp->insertDeclStmt($1);
        }
    }
    ;

ConstDef
    :
    ID ASSIGN ConstInitVal{
        SymbolEntry *se;
        se = new IdentifierSymbolEntry(curType, $1, identifiers->getLevel());

        // TODO
        // add try catch block to check if id had already been declared

        identifiers->install($1, se);

	// TODO
	// store init value into symbol table


        $$ = new DeclStmt(new Id(se),$3);
        delete []$1;
    }
    |
    ID BracketList ASSIGN ConstInitVal{}
    ;

BracketList
    :
    BracketList Bracket{}
    |
    Bracket{}
    ;

Bracket
    :
    LBRACKET ConstExp RBRACKET{}
    ;

ConstExp :
    AddExp{$$=$1;}

ConstInitVal
    :
    ConstExp{$$=$1;}
    |
    LBRACE RBRACE {}
    |
    LBRACE ConstInitValList RBRACE {}

ConstInitValList
    :
    ConstInitValList COMMA ConstInitVal {}
    |
    ConstInitVal{}
    ;


VarDeclStmt
    :
    Type VarDefList SEMICOLON{
        // why not use "CONST Type IdList SEMICOLON?"
        // If not distinguish const id-list and normal id-list
        // the statement "const int a[5]" will not be considered illegal
        $$=$2;
    }
    ;

VarDefList
    :
    VarDefList COMMA VarDef {
    // VarDef's property is StmtNode*,so the idea of changing Id*
    // to vector<Id*> in class DeclStmt is illegal.
    // VarDef belongs to DeclStmt,whose parent node is SeqNode.
    // However,SeqNode only has two children.If I make SeqNode has more children,
    // it will break the structure in CFG Stmts->Stmts Stmt|Stmt

    // Referring to CFG "FuncFParams->FuncFParam{','FuncFParam}
    // create a new class called DeclStmts whose member is queue<DeclStmt> might be a solution.
    // (use queue rather than vector is to keep the sequence of variable)
        $$=$1;
        DeclStmts *temp=dynamic_cast<DeclStmts*>($$);
        if(nullptr!=temp){
            temp->insertDeclStmt($3);
        }
    }
    |
    VarDef {
        $$=new DeclStmts();
        DeclStmts*temp=dynamic_cast<DeclStmts*>($$);
        if(nullptr!=temp){
            temp->insertDeclStmt($1);
        }
    }
    ;

VarDef
    :
    ID{
        SymbolEntry *se;
        se = new IdentifierSymbolEntry(curType, $1, identifiers->getLevel());
        identifiers->install($1, se);
        $$ = new DeclStmt(new Id(se));
        delete []$1;
    }
    |
    ID BracketList {
        SymbolEntry *se;
        se = new IdentifierSymbolEntry(curType, $1, identifiers->getLevel());
        identifiers->install($1, se);
        $$ = new DeclStmt(new Id(se));
        delete []$1;
    }
    |
    ID ASSIGN InitVal{
        SymbolEntry *se;
        se = new IdentifierSymbolEntry(curType, $1, identifiers->getLevel());

        // std::cout<<"ID ASSIGN InitVal"<<std::endl;
        // TODO
        // add try catch block to check if id had already been declared

        identifiers->install($1, se);

	// TODO
	// store init value into symbol table


        $$ = new DeclStmt(new Id(se),$3);
        delete []$1;
    }
    |
    ID BracketList ASSIGN InitVal{}
    ;

InitVal
    :
    Exp{$$=$1;}
    |
    LBRACE InitValList RBRACE {}
    ;

InitValList
    :
    InitValList COMMA InitVal {}
    |
    InitVal{}
    ;


// sysy dosen't have function declaration

FuncDef
    :
    Type ID {

        // this symble table is used to store params

        identifiers = new SymbolTable(identifiers);
    }
    LPAREN FuncFParams{
        Type *funcType;
        std::vector<SymbolEntry*> paramsSymbolEntry;

        DeclStmts *temp=dynamic_cast<DeclStmts*>($5);
        if(nullptr!=temp){
            paramsSymbolEntry=temp->getId();
        }
        funcType = new FunctionType($1, paramsSymbolEntry);
        SymbolEntry* se = new IdentifierSymbolEntry(
                    funcType, $2, identifiers->getPrev()->getLevel());
        identifiers->getPrev()->install($2, se);
    } RPAREN
    BlockStmt
    {
        SymbolEntry *se;
        se = identifiers->lookup($2);
        assert(se != nullptr);
        $$ = new FunctionDef(se, $5, $8);
        SymbolTable *top = identifiers;
        identifiers = identifiers->getPrev();
        delete top;
        delete []$2;
    }
    ;

FuncFParams
    :
    FuncFParams COMMA FuncFParam{
        $$=$1;
        DeclStmts *temp=dynamic_cast<DeclStmts*>($$);
        if(nullptr!=temp){
            temp->insertDeclStmt($3);
        }
    }
    |
    FuncFParam{
        $$=new DeclStmts();
        DeclStmts*temp=dynamic_cast<DeclStmts*>($$);
        if(nullptr!=temp){
            temp->insertDeclStmt($1);
        }
    }
    | %empty { $$ = nullptr; }
    ;

FuncFParam
    :
    Type ID {
      	SymbolEntry *se;
      	se = new IdentifierSymbolEntry($1, $2, identifiers->getLevel());
        identifiers->install($2, se);
        $$ = new DeclStmt(new Id(se));
        delete []$2;
    }
    |
    Type ID FuncBracketList{}
    ;


FuncBracketList
    :
    LBRACKET RBRACKET{}
    |
    FuncBracketList LBRACKET Exp RBRACKET{}
    ;
%%

int yyerror(char const* message)
{
    std::cerr<<message<<std::endl;
    return -1;
}
