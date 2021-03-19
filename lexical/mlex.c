// g++ -lfl mlex.c -o test.bin
// ./test.bin ../examples/ex.c2 main.lex


#include "lex.yy.c"

terminal cur_sym;

void next_symbol(){
    cur_sym = (terminal) yylex();
}

void error(){
    printf("Error at (%d,%d)\n", yylineno, coluna-yyleng);   
}

void error(const char * message){
    printf("Error at (%d,%d)[%s]\n", yylineno, coluna,message);   
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
void statements();
void statement();
void id_stmt();
void opt_arguments();
void arguments();
void opt_argument();
void argument();
void condition_stmt();
void condition_stmt_opt();
void loop_stmt();
void exit_stmt();
void return_stmt();
void expr();
void expr_opt();
void p1();
void p1_opt();
void p2();
void p3();
void p3_opt();
void op3();
void p4();
void p4_opt();
void op4();
void p5();
void p5_opt();
void op5();
void p6();
void p7();
void lval();
void simple_expression();
void simple_expression_id();



void type();
void type_opt();

void program(){
    switch(cur_sym){
        case MULTI_OP:

        case INT_TYPE:
        case FLOAT_TYPE:
        case BOOL_TYPE:
        case VOID_TYPE:

        case ID:

        case STRUCT:
            declaration(); 
            declarations();
            break;
        default:
            error("program");
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
        case VOID_TYPE:
        case ID:
        case STRUCT:
            program();
            break;

        default:
            error("declarations");
            break;
    }
}

void declaration(){
    switch(cur_sym){
        case MULTI_OP:
            eat(MULTI_OP);
            eat(ID);
            lval();
            eat(ASSIGN_OP);
            expr();
            eat(SEMICOLON);
            break;
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
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
            error("declaration");
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
            error("program_element_type");
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
            error("function_or_assign");
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
            error("function_args");
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
            error("function_opt_block");
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
            error("struct_block");
            break;

    }
}

void attributes(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
        case ID:
            attribute();
            eat(SEMICOLON);
            attributes();
            break;
        case RIGHT_BRACE:
            break;
        default:
            error("attributes");
            break;
    }
}

void attribute(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
            type();
            eat(ID);
            break;
        case ID:
            eat(ID);
            type_opt();
            break;
        default:
            error("attribute");
            break;
    }
}

void opt_parameters(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
        case ID:
            parameters();
            break;
        case RIGHT_PARENTHESIS:
            break;
        default:
            error("opt_parameters");
            break;
    }
}

void parameters(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
        case ID:
            parameter();
            opt_parameter();
            break;
        default:
            error("parameters");
            break;
    }
}

void parameter(){
    switch(cur_sym){
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
            type();
            eat(ID);
            break;
        case ID:
            eat(ID);
            type_opt();
            eat(ID);
            break;
        default:
            error("parameter");
            break;
    }
}

void block(){
    switch(cur_sym){
        case LEFT_BRACE: 
            eat(LEFT_BRACE);
            statements();
            eat(RIGHT_BRACE);
            break;
        default:
            error("block");
            break;
    }
}

void statements(){
    switch (cur_sym)
    {
        case MULTI_OP:
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case RETURN:
        case BREAK:
        case LOOP:
        case IF:
        case LEFT_BRACE:
            statement();
            statements();
            break;
        case RIGHT_BRACE:
            break;
        default:
            error("statements");
            break;
    }

}

void statement(){
    switch (cur_sym)
    {
        case MULTI_OP: 
            eat(MULTI_OP);
            eat(ID);
            lval();
            eat(ASSIGN_OP);
            expr();
            eat(SEMICOLON);
            break;
        case INT_TYPE: 
        case FLOAT_TYPE: 
        case BOOL_TYPE:
        case VOID_TYPE:
            type();
            eat(ID);
            eat(SEMICOLON);
            break;
        case POW_FUNCTION:
            eat(POW_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            eat(SEMICOLON);
            break;
        case FREE_FUNCTION:
            eat(FREE_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            eat(SEMICOLON);
            break;
        case MALLOC_FUNCTION:
            eat(MALLOC_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            eat(SEMICOLON);
            break;
        case INPUT_FUNCTION:
            eat(INPUT_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            eat(SEMICOLON);
            break;
        case PRINT_FUNCTION:
            eat(PRINT_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            eat(SEMICOLON);
            break;
        case ID:
            eat(ID);
            id_stmt();
            break;
        case RETURN:
            return_stmt();
            eat(SEMICOLON);
            break;
        case BREAK:
            exit_stmt();
            eat(SEMICOLON);
            break;
        case LOOP:
            loop_stmt();
            break;
        case IF:
            condition_stmt();
            break;
        case LEFT_BRACKET:
            block();
            break;
        default:
            error("statement");
            break;
    }
}

void id_stmt(){
    switch (cur_sym)
    {
    case LEFT_BRACKET:
        lval();
        eat(ASSIGN_OP);
        expr();
        eat(SEMICOLON);
        break;
    case LEFT_PARENTHESIS:
        eat(LEFT_PARENTHESIS);
        opt_arguments();
        eat(RIGHT_PARENTHESIS);
        eat(SEMICOLON);
        break;
    case ID:
        eat(ID);
        eat(SEMICOLON);
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
        error("id_stmt");
        break;
    }
}

void opt_arguments(){
    switch (cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case BOOL:
        case FLOAT:
        case NOT_OP:
            arguments();
            break;
        case RIGHT_PARENTHESIS:
            break;
        default:
            error("opt_arguments");
            break;
    }
}

void arguments(){
    switch (cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case BOOL:
        case FLOAT:
        case NOT_OP:
            argument();
            opt_argument();
            break;
        default:
            error("arguments");
            break;
    }
}

void opt_argument(){
    switch (cur_sym)
    {
        case COMMA:
            eat(COMMA);
            arguments();
            break;
        case RIGHT_PARENTHESIS:
            break;
        default:
            error("opt_argument");
            break;
    }
}

void argument(){
    switch (cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case BOOL:
        case FLOAT:
        case DIF_OP:
        case NOT_OP:
            expr();
            break;
        
        default:
            error("argument");
            break;
    }
}

void condition_stmt(){
    switch (cur_sym)
    {
    case IF:
        eat(IF);
        eat(LEFT_PARENTHESIS);
        expr();
        eat(RIGHT_PARENTHESIS);
        block();
        condition_stmt_opt();
        break;
    default:
        error("condition_stmt");
        break;
    }
}

void condition_stmt_opt(){
    switch (cur_sym)
    {
    case MULTI_OP:
    case INT_TYPE: 
    case FLOAT_TYPE: 
    case BOOL_TYPE:
    case VOID_TYPE:
    case POW_FUNCTION:
    case FREE_FUNCTION:
    case MALLOC_FUNCTION:
    case INPUT_FUNCTION:
    case PRINT_FUNCTION:
    case ID:
    case RETURN:
    case BREAK:
    case LOOP:
    case IF:
    case LEFT_BRACE:
    case RIGHT_BRACE:
        break;
    case ELSE:
        eat(ELSE);
        block();
    default:
        error("condition_stmt_opt");
        break;
    }
}

void loop_stmt(){
    switch (cur_sym)
    {
    case LOOP:
        eat(LOOP);
        block();
        break;
    
    default:
        error("loop_stmt");
        break;
    }
}

void exit_stmt(){
    switch (cur_sym)
    {
    case BREAK:
        eat(BREAK);
        eat(WHEN);
        eat(LEFT_PARENTHESIS);
        expr();
        eat(RIGHT_PARENTHESIS);
        break;
    
    default:
        error("exit_stmt");
        break;
    }
}

void return_stmt(){
    switch (cur_sym)
    {
    case RETURN:
        eat(RETURN);
        expr();
        break;
    
    default:
        error("return_stmt");
        break;
    }
}

void expr()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
        case DIF_OP:
        case NOT_OP:
            p1();
            expr_opt(); 
            break; 
        default:
            error("expr");
            break;      
    }
}

void expr_opt()
{
    switch(cur_sym)
    {
        case RIGHT_BRACKET:
        case SEMICOLON:
        case RIGHT_PARENTHESIS:
        case COMMA:
            break;
        case OR_OP:
            eat(OR_OP);
            p1(); 
            expr_opt();
            break;
        default:
            printf("Token atual: %d\n",cur_sym);
            error("expr_opt");
            break;
    }
}

void p1()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
        case DIF_OP:
        case NOT_OP:
            p2();
            p1_opt();
            break;
        default:
            error("p1");
            break;
    }
}

void p1_opt()
{
    switch(cur_sym)
    {
        case RIGHT_BRACKET:
        case SEMICOLON:
        case RIGHT_PARENTHESIS:
        case OR_OP:
        case COMMA:
            break;
        case AND_OP:
            eat(AND_OP);
            p2();
            p1_opt();
            break;
        default:
            printf("Token atual: %d\n",cur_sym);
            error("p1_opt");
            break;
    }
}

void p2()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case BOOL:
        case FLOAT:
        case DIF_OP:
            p3();
            break;
        case NOT_OP:
            eat(NOT_OP);
            p2();
            break;
        default:
            error("p2");
            break;
    }
}

void opt_parameter(){
    switch(cur_sym){
        case RIGHT_PARENTHESIS: 
            break;
        case COMMA:
            eat(COMMA);
            parameters();
            break;
        default:
            error("opt_parameter");
            break;
    }
}

void p3()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
        case DIF_OP:
            p4();
            p3_opt();
            break;
        default:
            error("p3");
            break;
    }
}

void p3_opt()
{
    switch(cur_sym)
    {
        case LESSER_OP:
        case GREATER_OP:
        case GEQ_OP:
        case LEQ_OP:
        case DIFF_OP:
        case EQUAL_OP:
            op3();
            p4();
            break;
        case RIGHT_BRACKET:
        case SEMICOLON:
        case RIGHT_PARENTHESIS:
        case AND_OP:
        case OR_OP:
        case COMMA:
            break;
        default:
            printf("Token atual: %d\n",cur_sym);
            error("p3_opt");
            break;
    }
}

void op3()
{
    switch(cur_sym)
    {
        case LESSER_OP:
            eat(LESSER_OP);
            break;
        case GREATER_OP:
            eat(GREATER_OP);
            break;
        case GEQ_OP:
            eat(GEQ_OP);
            break;
        case LEQ_OP:
            eat(LEQ_OP);
            break;
        case DIFF_OP:
            eat(DIFF_OP);
            break;
        case EQUAL_OP:
            eat(EQUAL_OP);
            break;
        default:
            error("op3");
            break;
    }
}

void p4()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
        case DIF_OP:
            p5();
            p4_opt();
            break;
        default:
            error("p4");
            break;
    }
}

void p4_opt()
{
    switch(cur_sym)
    {
        case RIGHT_BRACKET:
        case SEMICOLON:
        case RIGHT_PARENTHESIS:
        case LESSER_OP:
        case GREATER_OP:
        case GEQ_OP:
        case LEQ_OP:
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COMMA:
            break;
        case SUM_OP:
        case DIF_OP:
            op4();
            p5();
            p4_opt();
            break;
        default:
            printf("Token atual: %d\n",cur_sym);
            error("p4_opt");
            break;
    }
}

void op4()
{
    switch(cur_sym)
    {
        case SUM_OP:
            eat(SUM_OP);
            break;
        case DIF_OP:
            eat(DIF_OP);
            break;
        default:
            error("op4");
            break;
    }
}

void p5()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
        case DIF_OP:
            p6();
            p5_opt();
            break;
        default:
            error("p5");
            break;
    }
}

void p5_opt()
{
    switch(cur_sym)
    {
        case RIGHT_BRACKET:
        case SEMICOLON:
        case RIGHT_PARENTHESIS:
        case DIF_OP:
        case SUM_OP:
        case LESSER_OP:
        case GREATER_OP:
        case GEQ_OP:
        case LEQ_OP:
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COMMA:
            break; 
        case MULTI_OP:
        case MOD_OP:
        case DIV_OP:
            op5();
            p6();
            p5_opt();
            break;
        default:
            printf("Token encontrado: %d\n", cur_sym);
            error("p5_opt");
            break;
    }
}

void op5()
{
    switch(cur_sym)
    {
        case MULTI_OP:
            eat(MULTI_OP);
            break;
        case MOD_OP:
            eat(MOD_OP);
            break;
        case DIV_OP:
            eat(DIV_OP);
            break;
        default:
            error("op5");
            break;
    }
}

void p6()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
            p7();
            break;
        case DIF_OP:
            eat(DIF_OP);
            p6();
            break;
        default:
            error("p6");
            break;
    }
}

void p7()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case INPUT_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
            simple_expression();
            break;
        case LEFT_PARENTHESIS:
            eat(LEFT_PARENTHESIS);
            expr();
            eat(RIGHT_PARENTHESIS);
            break;
        default:
            error("p7");
            break;
    }
}

void lval()
{
    switch(cur_sym)
    {
        case RIGHT_BRACKET:
        case MULTI_OP:
        case SEMICOLON:
        case RIGHT_PARENTHESIS:
        case DIF_OP:
        case MOD_OP:
        case DIV_OP:
        case SUM_OP:
        case LESSER_OP:
        case GREATER_OP:
        case GEQ_OP:
        case LEQ_OP:
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COMMA:
        case ASSIGN_OP:
            break;
        case LEFT_BRACKET:
            eat(LEFT_BRACKET);
            expr();
            eat(RIGHT_BRACKET);
            lval();
            break;
        case DOT:
            eat(DOT);
            eat(ID);
            lval();
            break;
        default:
            error("lval");
            break; 
    }
}

void simple_expression()
{
    switch(cur_sym)
    {
        case MULTI_OP:
            eat(MULTI_OP);
            eat(ID);
            lval();
            break;
        case POW_FUNCTION:
            eat(POW_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            //eat(SEMICOLON);
            break;
        case FREE_FUNCTION:
            eat(FREE_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            //eat(SEMICOLON);
            break;
        case MALLOC_FUNCTION:
            eat(MALLOC_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            //eat(SEMICOLON);
            break;
        case INPUT_FUNCTION:
            eat(INPUT_FUNCTION);
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            //eat(SEMICOLON);
            break;
        case PRINT_FUNCTION:
            eat(PRINT_FUNCTION); 
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            //eat(SEMICOLON);
            break;
        case ID:
            eat(ID);
            simple_expression_id();
            break;
        case INT:
            eat(INT);
            break;
        case FLOAT:
            eat(FLOAT);
            break;
        case BOOL:
            eat(BOOL);
            break;
        default:
            error("simple_expression");
            break;
    }
}

void simple_expression_id()
{
    switch(cur_sym)
    {
        case LEFT_BRACKET:
        case RIGHT_BRACKET:
        case MULTI_OP:
        case SEMICOLON:
        case RIGHT_PARENTHESIS:
        case DOT:
        case DIF_OP:
        case MOD_OP:
        case DIV_OP:
        case SUM_OP:
        case LESSER_OP:
        case GREATER_OP:
        case GEQ_OP:
        case LEQ_OP:
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COMMA:
            lval();
            break;
        case LEFT_PARENTHESIS:
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            //eat(SEMICOLON);
            break;
        default:
            error("simple_expression_id");
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
        case VOID_TYPE:
            eat(VOID_TYPE);
            break;
        default:
            error("type");
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
            error("type_opt");
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