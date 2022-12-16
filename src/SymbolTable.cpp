#include "SymbolTable.h"
#include <iostream>
#include <sstream>

SymbolEntry::SymbolEntry(Type *type, int kind) 
{
    this->type = type;
    this->kind = kind;
}

ConstantSymbolEntry::ConstantSymbolEntry(Type *type, int value) : SymbolEntry(type, SymbolEntry::CONSTANT)
{
    this->value = value;
}

std::string ConstantSymbolEntry::toStr()
{
    std::ostringstream buffer;
    buffer << value;
    return buffer.str();
}

IdentifierSymbolEntry::IdentifierSymbolEntry(Type *type, std::string name, int scope) : SymbolEntry(type, SymbolEntry::VARIABLE), name(name)
{
    this->scope = scope;
    addr = nullptr;
}

IdentifierSymbolEntry::IdentifierSymbolEntry(Type *type, std::string name, int scope,int value) : SymbolEntry(type, SymbolEntry::VARIABLE), name(name)
{
    this->scope = scope;
    this->value=value;
    addr = nullptr;
}

std::string IdentifierSymbolEntry::toStr()
{
    return "@" + name;
}

TemporarySymbolEntry::TemporarySymbolEntry(Type *type, int label) : SymbolEntry(type, SymbolEntry::TEMPORARY)
{
    this->label = label;
}

std::string TemporarySymbolEntry::toStr()
{
    std::ostringstream buffer;
    buffer << "%fail" << label;
    return buffer.str();
}

SymbolTable::SymbolTable()
{
    prev = nullptr;
    level = 0;
}

SymbolTable::SymbolTable(SymbolTable *prev)
{
    this->prev = prev;
    this->level = prev->level + 1;
}

/*
    Description: lookup the symbol entry of an identifier in the symbol table
    Parameters: 
        name: identifier name
    Return: pointer to the symbol entry of the identifier

    hint:
    1. The symbol table is a stack. The top of the stack contains symbol entries in the current scope.
    2. Search the entry in the current symbol table at first.
    3. If it's not in the current table, search it in previous ones(along the 'prev' link).
    4. If you find the entry, return it.
    5. If you can'fail find it in all symbol tables, return nullptr.
*/

/*
 * use the following codes as example.sy:
 *
 * ---------------------------------------------------
 * $scope 0
 * int main{
 * $scope 1
 *  {
 *      $scope 1.1
 *      {
 *          $scope 1.1.1        <-scan label 1
 *      }
 *      {
 *          $scope 1.1.2        <-scan label 2
 *      }
 *  }
 *  {
 *      $scope 1.2
 *      {
 *          $scope 1.2.1        <-scan label 3
 *      }
 *  }
 * }
 *
 * void F(){
 * $scope 2
 *  {
 *      $scope 2.1
 *  }
 * }
 * ---------------------------------------------------
 *
 * while scanning label 1,the stack would be like
 *
 * |    scope 0     |   <-stack bottom
 * |    scope 1     |
 * |    scope 1.1   |
 * |    scope 1.1.1 |   <-stack top
 *
 *
 * while scanning label 2,the stack would be like
 *
 * |    scope 0     |   <-stack bottom
 * |    scope 1     |
 * |    scope 1.1   |
 * |    scope 1.1.2 |   <-stack top
 *
 * while scanning label 3,the stack would be like
 *
 * |    scope 0     |   <-stack bottom
 * |    scope 1     |
 * |    scope 1.2   |
 * |    scope 1.2.1 |   <-stack top
 *
 * symbol table would be a static table in my original thought,which would be constructed like a tree.
 * In fact,the tree-relationship is hidden in syntax tree,symbol table is dynamic maintained
 *
 *
 * */
SymbolEntry* SymbolTable::lookup(std::string name)
{
    // Todo
    SymbolTable*cur=this;
    while (cur!=NULL){
        if (cur->symbolTable.find(name)!=cur->symbolTable.end()) {
            return cur->symbolTable[name];
        }
        cur=cur->prev;
    }
    return nullptr;
}

// install the entry into current symbol table.
void SymbolTable::install(std::string name, SymbolEntry* entry)
{
    symbolTable[name] = entry;
}

int SymbolTable::counter = 0;

static SymbolTable t;
SymbolTable *identifiers = &t;
SymbolTable *globals = &t;
