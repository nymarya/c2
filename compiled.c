 #include<stdio.h>
 #include<stdlib.h>
 #include<math.h>
 typedef enum { false = 0, true = 1} bool;
 int main ( ) { int * v ; v = malloc ( 8 * 3 ) ; v [ 0 ] = 1 ; v [ 1 ] = 2 ; v [ 2 ] = 3 ; int i ; i = 0 ; b0:; { if ( i == 3 ) goto e0 ; printf ( "%d\n" , v [ i ] ) ; i = i + 1 ; } goto b0 ; e0: ; return 0 ; }