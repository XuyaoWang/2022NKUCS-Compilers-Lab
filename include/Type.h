#ifndef __TYPE_H__
#define __TYPE_H__
#include <vector>
#include <string>

class SymbolEntry;

class Type
{
private:
    int kind;
protected:
    enum {INT, VOID, FUNC, FLOAT, PTR};
    int size;
public:
    Type(int kind,int size=0) : kind(kind),size(size) {};
    virtual ~Type() {};
    virtual std::string toStr() = 0;
    bool isInt() const {return kind == INT;};
    bool isVoid() const {return kind == VOID;};
    bool isFunc() const {return kind == FUNC;};
    bool isFloat() const {return kind == FLOAT;};
    bool isPtr() const {return kind==PTR;};

    int getKind() const {return kind;};
    int getSize() const {return size;};

    static int getInt() {return INT;};
    static int getVoid() {return VOID;};
    static int getFunc() {return FUNC;};
    static int getFloat() {return FLOAT;};
};

class IntType : public Type
{
public:
    IntType(int size) : Type(Type::INT,size){};
    std::string toStr();
};

class FloatType : public Type
{
public:
    FloatType(int size) : Type(Type::FLOAT,size){};
    std::string toStr();
};

class VoidType : public Type
{
public:
    VoidType() : Type(Type::VOID){};
    std::string toStr();
};

class FunctionType : public Type
{
private:
    Type *returnType;
    std::vector<SymbolEntry*> paramsSymbolEntry;
public:
    FunctionType(Type* returnType, std::vector<SymbolEntry*> paramsSymbolEntry) :
    Type(Type::FUNC), returnType(returnType), paramsSymbolEntry(paramsSymbolEntry){};
    Type* getRetType() {return returnType;};
    std::vector<SymbolEntry*>getParamsSymbolEntry(){return paramsSymbolEntry;};
    std::string toStr();
};

class PointerType : public Type
{
private:
    Type *valueType;
public:
    PointerType(Type* valueType) : Type(Type::PTR) {this->valueType = valueType;};
    std::string toStr();
};


class TypeSystem
{
private:
    static IntType commonInt;
    static FloatType commonFloat;
    static IntType commonBool;
    static VoidType commonVoid;
public:
    static Type *intType;
    static Type *floatType;
    static Type *voidType;
    static Type *boolType;
};
#endif
