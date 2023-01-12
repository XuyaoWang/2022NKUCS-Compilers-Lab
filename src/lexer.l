%option noyywrap
%{
    #define YY_NO_UNPUT
    #define YY_NO_INPUT

    #include "parser.h"
    #include <ostream>
    #include <fstream>
    using namespace std;

    extern FILE *yyin; 
    extern FILE *yyout;
    extern bool dump_tokens;

    void DEBUG_FOR_LAB4(std::string s){
        std::string DEBUG_INFO = "[DEBUG LAB4]: \t" + s + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }
%}

OCTAL (0[0-7]+)
DECIMIAL ([1-9][0-9]*|0)
HEXADECIMAL (0[Xx][0-9A-Fa-f]+)
FLOAT ([0-9]+[.][0-9]+)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
LINECOMMENT \/\/[^\n]*
BLOCKCOMMENT \/\*[^*]*\*+([^\/*][^*]*\*+)*\/
%x BLOCKCOMMENT

%%

"int" {
    /*
    * Questions: 
    *   Q1: Why we need to return INT in further labs?
    *   Q2: What is "INT" actually?
    */
    if(dump_tokens)
        DEBUG_FOR_LAB4("INT\tint");
    return INT;
}

"float" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("FLOAT\tfloat");
    return FLOAT;
}

"void" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("VOID\tvoid");
    return VOID;
}
"if" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("IF\tif");
    return IF;
};
"else" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ELSE\telse");
    return ELSE;
};

"while" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("WHILE\twhile");
    return WHILE;
}

"break" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("BREAK\tbreak");
    return BREAK;
}

"continue" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("CONTINUE\tcontinue");
    return CONTINUE;
}

"const" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("CONST\tconst");
    return CONST;
}

"return" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RETURN\treturn");
    return RETURN;
}

"=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ASSIGN\t=");
    return ASSIGN;
}

"==" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("EQ\t==");
    return EQ;
}

"!=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("NEQ\t!=");
    return NEQ;
}

">" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("GREATER\t>");
    return GREATER;
}

"<" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LESS\t<");
    return LESS;
}

">=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("GREATEREQ\t>=");
    return GREATEREQ;
}

"<=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LESSEQ\t<=");
    return LESSEQ;
}

"!" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("NOT\t!");
    return NOT;
}

"&&" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("AND\t&&");
    return AND;
}

"||" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("OR\t||");
    return OR;
}

"+" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ADD\t+");
    return ADD;
}

"-" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("SUB\t-");
    return SUB;
}

"*" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("MUL\t*");
    return MUL;
}

"/" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("DIV\t/");
    return DIV;
}

"%" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("MOD\t%");
    return MOD;
}

"," {
    if(dump_tokens)
        DEBUG_FOR_LAB4("COMMA\t;");
    return COMMA;
}

";" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("SEMICOLON\t;");
    return SEMICOLON;
}
"(" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LPAREN\t(");
    return LPAREN;
}
")" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RPAREN\t)");
    return RPAREN;
}

"[" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LBRACKET\t(");
    return LBRACKET;
}

"]" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RBRACKET\t)");
    return RBRACKET;
}

"{" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LBRACE\t{");
    return LBRACE;
}
"}" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RBRACE\t}");
    return RBRACE;
}

{OCTAL} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    yylval.itype = strtol(yytext,NULL,8);
    return INTEGER;
}

{DECIMIAL} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    yylval.itype = atoi(yytext);
    return INTEGER;
}

{HEXADECIMAL} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    yylval.itype = strtol(yytext,NULL,16);
    return INTEGER;
}

{FLOAT} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    yylval.ftype = atof(yytext);
    return FLOATING;
}

{LINECOMMENT} {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LINECOMMENT\t");
    continue;
}

{BLOCKCOMMENT} {
    if(dump_tokens)
        DEBUG_FOR_LAB4("BLOCKCOMMENT\t");
    continue;
}

"putint" {
    char *lexeme;
    lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    if(identifiers->lookup(yytext)!=nullptr){
        return ID;
    }

    Type *funcType;
    std::vector<SymbolEntry*> paramsSymbolEntry;
    paramsSymbolEntry.push_back(new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel()));
    funcType = new FunctionType(TypeSystem::voidType, paramsSymbolEntry);

    SymbolTable* cur = identifiers;
    while(cur->getPrev())
        cur = cur->getPrev();
    SymbolEntry* se = new IdentifierSymbolEntry(
        funcType, yytext, cur->getLevel());
    cur->install(yytext, se);
    return ID;
}

"getint" {
    char *lexeme;
    lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    if(identifiers->lookup(yytext)!=nullptr){
        return ID;
    }

    Type *funcType;
    std::vector<SymbolEntry*> paramsSymbolEntry;
    funcType = new FunctionType(TypeSystem::intType, paramsSymbolEntry);

    SymbolTable* cur = identifiers;
    while(cur->getPrev())
        cur = cur->getPrev();
    SymbolEntry* se = new IdentifierSymbolEntry(
        funcType, yytext, cur->getLevel());
    cur->install(yytext, se);
    return ID;
}

"putch" {
    char *lexeme;
    lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    if(identifiers->lookup(yytext)!=nullptr){
        return ID;
    }

    Type *funcType;
    std::vector<SymbolEntry*> paramsSymbolEntry;
    paramsSymbolEntry.push_back(new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel()));
    funcType = new FunctionType(TypeSystem::voidType, paramsSymbolEntry);

    SymbolTable* cur = identifiers;
    while(cur->getPrev())
        cur = cur->getPrev();
    SymbolEntry* se = new IdentifierSymbolEntry(
        funcType, yytext, cur->getLevel());
    cur->install(yytext, se);
    return ID;
}

"getch" {
    char *lexeme;
    lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    if(identifiers->lookup(yytext)!=nullptr){
        return ID;
    }

    Type *funcType;
    std::vector<SymbolEntry*> paramsSymbolEntry;
    funcType = new FunctionType(TypeSystem::intType, paramsSymbolEntry);

    SymbolTable* cur = identifiers;
    while(cur->getPrev())
        cur = cur->getPrev();
    SymbolEntry* se = new IdentifierSymbolEntry(
        funcType, yytext, cur->getLevel());
    cur->install(yytext, se);
    return ID;
}

"putfloat" {
    return ID;
}

"getfloat" {
    return ID;
}

"putarray" {
    return ID;
}

"getarray" {
    return ID;
}

"putfarray" {
    return ID;
}

"getfarray" {
    return ID;
}

"putf" {
    return ID;
}

{ID} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    char *lexeme;
    lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    return ID;
}

{EOL} yylineno++;
{WHITE}
%%
