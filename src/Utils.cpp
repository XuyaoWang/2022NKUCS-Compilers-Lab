//
// Created by yao on 12/16/22.
//

#include "../include/Utils.h"


void Utils::exprTypeCheck(Type *fType1, Type *fType2,ExprNode*exprNode){
    //Todo:check if type in exprNode is legal.Such as in x = a Mod b,b must be a integer
    if (fType1== nullptr||fType2== nullptr){
        fprintf(stderr, "expr type can'fail be nullptr\n");
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
    if (exprNode!= nullptr){
        if(exprNode->isBinaryExpr()){
            binaryTypeCheck(type1,type2,dynamic_cast<BinaryExpr*>(exprNode));
        } else if (exprNode->isUnaryExpr()){
            unaryTypeCheck(type1,type2,dynamic_cast<UnaryExpr*>(exprNode));
        }
    } else{
        assignTypeCheck(type1,type2);
    }
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

void Utils::binaryTypeCheck(Type *type1, Type *type2,BinaryExpr*binaryExpr) {
    int op=binaryExpr->getOp();
    ExprNode*expr1=binaryExpr->getExpr1();
    ExprNode*expr2=binaryExpr->getExpr2();

    if (op>=BinaryExpr::AND && op<=BinaryExpr::OR){
        // Todo:current implicit cast assume two exprs are Integer
        binaryExpr->getSymPtr()->setType(TypeSystem::boolType);
        if (expr1->getSymPtr()->getType()->getSize()!=1){
            ImplicitCastExpr*implicitCastExpr1=new ImplicitCastExpr(expr1,TypeSystem::boolType);
            //binaryExpr->setExpr1(implicitCastExpr1);
        }
        if (expr2->getSymPtr()->getType()->getSize()!=1){
            ImplicitCastExpr*implicitCastExpr2=new ImplicitCastExpr(expr2,TypeSystem::boolType);
            //binaryExpr->setExpr2(implicitCastExpr2);
        }
    }else{
        if (op==BinaryExpr::MOD){
            if (!expr1->getSymPtr()->getType()->isInt()||
                !expr2->getSymPtr()->getType()->isInt()){
                fprintf(stderr, "Operands of `mod` must be both integers");
                exit(EXIT_FAILURE);
            }
        }
        Type*type=binaryExpr->getSymPtr()->getType();
        if (type1->getKind()!=type->getKind()||
            type2->getKind()!=type->getKind()){
            // Todo: more implicit cast in BinaryExpr,like Int <-> Float
        }
        // ImplicitCastExpr*implicitCastExpr=new ImplicitCastExpr(expr1,type);
    }
}

void Utils::assignTypeCheck(Type *type1, Type *type2) {
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

void Utils::unaryTypeCheck(Type *type1, Type *type2, UnaryExpr *unaryExpr) {
    return;
    ExprNode*expr=unaryExpr->getExpr();
    int op=unaryExpr->getOp();
    switch (op) {
        case UnaryExpr::NOT:{
            if (expr->getSymPtr()->getType()->getSize()!=1){
                ImplicitCastExpr*implicitCastExpr=new
                        ImplicitCastExpr(expr,TypeSystem::boolType);
                unaryExpr->setExpr(implicitCastExpr);
            }
        }
    }
}
