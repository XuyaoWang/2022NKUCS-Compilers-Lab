//
// Created by yao on 12/16/22.
//

#ifndef INC_2022NKUCS_COMPILERS_LAB_UTILS_H
#define INC_2022NKUCS_COMPILERS_LAB_UTILS_H

#include "Ast.h"
#include <assert.h>

class Node;
class ExprNode;
class StmtNode;
class BinaryExpr;
class UnaryExpr;

class Utils{
private:
    static void unaryTypeCheck(Type* type1, Type* type2, UnaryExpr*unaryExpr);
    static void binaryTypeCheck(Type* type1, Type* type2, BinaryExpr*binaryExpr);
    static void assignTypeCheck(Type* type1, Type* type2);
public:
    // before calling stmtTypeCheck,you must call typeCheck to make sure private member getting its type
    static void stmtTypeCheck(Type* type1, Type* type2, StmtNode*stmtNode);
    static void exprTypeCheck(Type* type1, Type* type2,ExprNode*exprNode= nullptr);
};

extern Utils*utils;

#endif //INC_2022NKUCS_COMPILERS_LAB_UTILS_H
