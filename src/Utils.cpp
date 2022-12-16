//
// Created by yao on 12/16/22.
//

#include "Utils.h"
#include "../include/Utils.h"


void Utils::exprTypeCheck(Type *fType1, Type *fType2){
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

void Utils::stmtTypeCheck(Type *fType1, Type *fType2, StmtNode*stmtNode) {
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
        stmtNode->setNodeType(type2);
        return;
    }
    if (type2->isVoid()){
        stmtNode->setNodeType(type1);
        return;
    }

    if (type1->getKind()==type2->getKind()){
        stmtNode->setNodeType(type1);
        return;
    }
    if((type1->isFloat()&&type2->isInt())||
       (type1->isInt()&&type2->isFloat())){
        stmtNode->setNodeType(type1->isFloat()?type1:type2);
        return;
    }
    fprintf(stderr, "type %s and %s mismatch in line xx\n",type1->toStr().c_str(), type2->toStr().c_str());
    exit(EXIT_FAILURE);
}


void Utils::ImplicitCast(Type *dstType, ExprNode *srcNode, ExprNode *dstNode) {
    SymbolEntry*symbolEntry;
    Operand*dst;
    symbolEntry=new TemporarySymbolEntry(dstType,SymbolTable::getLabel());
    dst=new Operand(symbolEntry);
    dstNode=new ExprNode(symbolEntry,srcNode->getKind());
    dstNode->setOperand(dst);
}
