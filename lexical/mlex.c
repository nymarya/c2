// g++ -lfl mlex.c -o test.bin
// ./test.bin ../examples/ex.c2 main.lex


#include "lex.yy.c"

terminal cur_sym;

void next_symbol(){
    cur_sym = (terminal) yylex();
}

void error(){
    printf("Error at (%d,%d)", yylineno, yycol);   
}

void eat(terminal t){
    if (cur_sym == t){
        next_symbol();
    } else {
        error();
    }
}


void program();
void declarations();
void declaration();
void program_element_type();
void function_or_assign();

void program(){
    switch(cur_sym){
        case MULTI_OP:

        case INT_TYPE:
        case FLOAT_TYPE:
        case BOOL_TYPE:

        case ID:

        case STRUCT:
            declaration(); 
            declarations();
            break;
        default:
            error();
    }
}

void declarations(){
    switch(cur_sym){
        case EOFF:
            break;

        case MULTI_OP:
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case ID:
        case STRUCT:
            program();
            break;

        default:
            error();
    }
}

void declaration(){
    switch(cur_sym){
        case MULTI_OP:
            eat(MULTI_OP);
            eat(ID);
            // ...
            eat(SEMICOLON);
            break;
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case ID:
        case STRUCT:
            error();
            break;

        default:
            error();
    }
}


int main(int argc, char *argv[]){
    FILE *arquivo = fopen(argv[1],"r");
    if (!arquivo) {
      cout << "Arquivo inexistente" << endl;
      return -1;
    }
    yyin = arquivo;
    out = fopen(argv[2],"w");

    //next_token();
    next_symbol();
    program();

    //printf("RESULT : %d \n",x);
    
    
    return 0;
}