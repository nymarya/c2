// g++ -lfl mlex.c -o test.bin
// ./test.bin ../examples/ex.c2 main.lex


#include "lex.yy.c"
/*
enum bool{
    false=0,
    true
}BOOL;
*/
bool program();
bool program_element();
bool program2();

bool program(){
    bool a = program_element();
    //bool b = program2();

    //return (a==true && b==true);
    return (a==true);
}

bool program_element(){
    next_token();
    printf("cur_id %d  struct_id %d\n", cur_token.t, STRUCT);
    switch(cur_token.t){
        case STRUCT:
            next_token();
            printf("x_orig %d  id %d\n", cur_token.t, ID);
            if (cur_token.t == ID){
                return true;
            } else {
                return false;
            }
            break;
        default:
            return false;
    }
}

bool program2(){
    bool a = program();
    if (a == false)
        return true;
    return true;
}
/*
bool opt_parameters(){
    bool r = parameters();
    if (r == false){
        if (cur_token.t == CLOSE_PARENTHESIS)
            return true;
        else
            return false;
    }
}

bool parameters(){
    bool a = parameter();
    bool b = opt_parameter();

    return (a==true && b==true);
}

bool parameter(){
    next_token();
    if (cur_token.t == PRIMITIVE_TYPE){
        next_token();
        if (cur_token.t == ID){
            return true;
        }
    }
    return false;
}

bool opt_parameter(){
    next_token();
    if (cur_token.t == COMMA){
        return parameters();
    } else if (cur_token.t == CLOSE_PARENTHESIS){
        return true;
    } else {
        return false;
    }
}
*/
int main(int argc, char *argv[]){
    FILE *arquivo = fopen(argv[1],"r");
    if (!arquivo) {
      cout << "Arquivo inexistente" << endl;
      return -1;
    }
    yyin = arquivo;
    out = fopen(argv[2],"w");

    //next_token();
    bool x = program();

    printf("RESULT : %d \n",x);
    
    
    return 0;
}