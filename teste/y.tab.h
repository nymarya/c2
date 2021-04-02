/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    FLOAT = 259,
    STR = 260,
    LEFT_PARENTHESIS = 261,
    RIGHT_PARENTHESIS = 262,
    EQUAL_OP = 263,
    LEQ_OP = 264,
    LESSER_OP = 265,
    GEQ_OP = 266,
    GREATER_OP = 267,
    DIFF_OP = 268,
    ASSIGN_OP = 269,
    NOT_OP = 270,
    SEMICOLON = 271,
    COMMA = 272,
    DOT = 273,
    EOFF = 274,
    BOOL = 275,
    STRING = 276,
    ID = 277,
    OR_OP = 278,
    AND_OP = 279,
    SUM_OP = 280,
    DIF_OP = 281,
    MULTI_OP = 282,
    DIV_OP = 283,
    MOD_OP = 284,
    UMINUS = 285
  };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define STR 260
#define LEFT_PARENTHESIS 261
#define RIGHT_PARENTHESIS 262
#define EQUAL_OP 263
#define LEQ_OP 264
#define LESSER_OP 265
#define GEQ_OP 266
#define GREATER_OP 267
#define DIFF_OP 268
#define ASSIGN_OP 269
#define NOT_OP 270
#define SEMICOLON 271
#define COMMA 272
#define DOT 273
#define EOFF 274
#define BOOL 275
#define STRING 276
#define ID 277
#define OR_OP 278
#define AND_OP 279
#define SUM_OP 280
#define DIF_OP 281
#define MULTI_OP 282
#define DIV_OP 283
#define MOD_OP 284
#define UMINUS 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 9 "calc.yacc"
        /* type of ’yylval’ (stack type) */
  int integer; /* type name is YYSTYPE */
  float real;  /* default #define YYSTYPE int ple type */

#line 122 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
