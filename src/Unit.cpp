#include "Unit.h"
extern FILE *yyout;

void Unit::insertFunc(Function *f)
{
    func_list.push_back(f);
}

void Unit::removeFunc(Function *func)
{
    func_list.erase(std::find(func_list.begin(), func_list.end(), func));
}

void Unit::output() const
{
    fprintf(yyout, "declare i32 @getint()\n");
    fprintf(yyout, "declare i32 @getch()\n");
    fprintf(yyout, "declare void @putint(i32)\n");
    fprintf(yyout, "declare void @putch(i32)\n");
    for (auto &se:global_var_list){
        if (se->getType()->isInt()) {
            fprintf(yyout, "%s = global %s %d, align 4\n", se->toStr().c_str(),
                    se->getType()->toStr().c_str(),
                    (int)((IdentifierSymbolEntry*)se)->getValue());
        }
    }
    for (auto &func : func_list){
        func->output();
    }
}

Unit::~Unit()
{
    for(auto &func:func_list)
        delete func;
}

void Unit::insertGlobalVar(SymbolEntry *se) {
    global_var_list.push_back(se);
}
