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
void function_args();
void function_opt_block();
void struct_block();
void attributes();
void attribute();
void opt_parameters();
void parameters();
void opt_parameter();
void parameter();
void block();
void type();
void type_opt();

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
            break;
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
            break;
    }
}

void declaration(){
    switch(cur_sym){
        case MULTI_OP:
            eat(MULTI_OP);
            eat(ID);
            lval();
            eat(ASSIGN_OP)
            expr();
            eat(SEMICOLON);
            break;
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
            type();
            program_element_type();
            break;
        case ID:
            eat(ID);
            function_or_assign();
            break;
        case STRUCT:
            eat(STRUCT);
            eat(ID);
            struct_block();
            break;

        default:
            error();
            break;
    }
}

void program_element_type(){
    switch(cur_sym){
        case ID:
            eat(ID);
            function_args();
            break;
        default:
            error();
            break;

    }
}

void function_or_assign(){
    switch(cur_sym){
        case LEFT_BRACKET:
            lval();
            eat(ASSIGN_OP);
            expr();
            eat(SEMICOLON);
            break;
        case ID:
            eat(ID);
            function_args();
            break;
        case DOT:
            lval();
            eat(ASSIGN_OP);
            expr();
            eat(SEMICOLON);
            break;
        case ASSIGN_OP:
            lval();
            eat(ASSIGN_OP);
            expr();
            eat(SEMICOLON);
            break;
        default:
            error();
            break;

    }
}

void function_args(){
    switch(cur_sym){
        case LEFT_PARENTHESIS:
            eat(LEFT_PARENTHESIS);
            opt_parameters();
            eat(RIGHT_PARENTHESIS);
            function_opt_block();
            break;
        case ID:
            eat(ID);
            function_args();
            break;
        case DOT:
            lval();
            eat(ASSIGN_OP);
            expr();
            eat(SEMICOLON);
            break;
        case ASSIGN_OP:
            lval();
            eat(ASSIGN_OP);
            expr();
            eat(SEMICOLON);
            break;
        default:
            error();
            break;

    }
}

void function_opt_block(){
    switch(cur_sym){
        case SEMICOLON:
            eat(SEMICOLON);
            break;
        case LEFT_BRACE:
            block();
            break;
        default:
            error();
            break;

    }
}

void struct_block(){
    switch(cur_sym){
        case LEFT_BRACE:
            eat(LEFT_BRACE);
            attributes();
            eat(RIGHT_BRACE);
            break;
        default:
            error();
            break;

    }
}

void attributes(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case ID:
            attribute();
            eat(SEMICOLON);
            attributes();
            break;
        case RIGHT_BRACE:
            break;
        default:
            error();
            break;
    }
}

void attribute(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
            type();
            eat(ID);
            break;
        case ID:
            eat(ID);
            type_opt();
            break;
        default:
            error();
            break;
    }
}

void opt_parameters(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case ID:
            parameters();
            break;
        case RIGHT_PARENTHESIS:
            break;
        default:
            error();
            break;
    }
}

void parameters(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case ID:
            parameter();
            opt_parameter();
            break;
        default:
            error();
            break;
    }
}

void opt_parameter(){
    switch(cur_sym){
        case RIGHT_PARENTHESIS: 
            break;
        case COLON:
            eat(COLON);
            parameters();
            break;
        default:
            error();
            break;
    }
}

void parameter(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
            type();
            eat(ID);
            break;
        case ID:
            eat(ID);
            type_opt();
            eat(ID);
            break;
        default:
            error();
            break;
    }
}

void block(){
    switch(cur_sym){
        case LEFT_BRACE: 
            eat(LEFT_BRACE);
            statements();
            eat(LEFT_BRACE);
            break;
        default:
            error();
            break;
    }
}

void type(){
    switch(cur_sym){
        case INT_TYPE:
            eat(INT_TYPE);
            type_opt();
            break;
        case FLOAT_TYPE:
            eat(FLOAT_TYPE);
            type_opt();
            break;
        case BOOL_TYPE:
            eat(BOOL_TYPE);
            type_opt();
            break;
        default:
            error();
            break;
    }
}

void type_opt(){
    switch(cur_sym){
        case LEFT_BRACKET:
            eat(LEFT_BRACKET);
            eat(RIGHT_BRACKET);
            type_opt();
            break;
        case MULTI_OP:
            eat(MULTI_OP);
            type_opt();
            break;
        case ID:
            break;
        default:
            error();
            break;
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