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
void expr();
void expr_opt();
void p1();
void p1_opt();
void p2();
void p3();
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
void opt_arguments();
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
            eat(ASSIGN_OP);
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

void expr()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case READ_FUNCTION:
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
            error();
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
        case COLON:
            break;
        case OR_OP:
            eat(OR_OP);
            p1(); 
            expr_opt();
            break;
        default:
            error();
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
        case READ_FUNCTION:
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
            error();
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
        case COLON:
            break;
        case AND_OP:
            eat(AND_OP);
            p2();
            p1_opt();
            break;
        default:
            error();
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
        case READ_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case BOOL:
        case FLOAT:
        case DIF_OP:
            p3();
            break;
        case NOT_OP:
            eat(DIF_OP);
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

void p3()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case READ_FUNCTION:
        case PRINT_FUNCTION:
        case ID:
        case INT:
        case FLOAT:
        case BOOL:
        case DIF_OP:
            p4();
            op3();
            p4();
            break;
        default:
            error();
            break;
    }
}

void op3()
{
    switch(cur_sym)
    {
        case DIFF_OP:
            eat(DIFF_OP);
            break;
        case EQUAL_OP:
            eat(EQUAL_OP);
            break;
        default:
            error();
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
        case READ_FUNCTION:
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
            error();
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
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COLON:
            break;
        case SUM_OP:
        case DIF_OP:
            op4();
            p5();
            p4_opt();
            break;
        default:
            error();
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

void p5()
{
    switch(cur_sym)
    {
        case MULTI_OP:
        case LEFT_PARENTHESIS:
        case POW_FUNCTION:
        case FREE_FUNCTION:
        case MALLOC_FUNCTION:
        case READ_FUNCTION:
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
            error();
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
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COLON:
            break; 
        case MULTI_OP:
        case MOD_OP:
        case DIV_OP:
            op5();
            p6();
            p5_opt();
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
            error();
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
        case READ_FUNCTION:
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
            error();
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
        case READ_FUNCTION:
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
            error();
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
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COLON:
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
            eat(ID)
            lval();
            break;
        default:
            error();
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
        case READ_FUNCTION:
            eat(READ_FUNCTION);
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
            error();
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
        case DIFF_OP:
        case EQUAL_OP:
        case AND_OP:
        case OR_OP:
        case COLON:
            lval();
            break;
        case LEFT_PARENTHESIS:
            eat(LEFT_PARENTHESIS);
            opt_arguments();
            eat(RIGHT_PARENTHESIS);
            eat(SEMICOLON);
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