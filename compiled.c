 #include<stdio.h>
 #include<stdlib.h>
 #include<math.h>
 typedef enum { false = 0, true = 1} bool;
 struct user { int a ; } ; int main ( ) { int a ; if(!( a > 9 )) goto  a0; { a = ( 4 + 5 ) * 3 ; } a0:; printf ( "%d\n" , a ) ; if(!( a > 0 )) goto  a1; { } goto b1; a1:; { int b ; } b1:; b2:; { printf ( "%d\n" , a ) ; if ( a < 2 ) goto e2 ; a = a + 1 ; } goto b2 ; e2: ; float b ; b = 1.0 ; return 0 ; }