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
    ELSE = 258,
    IF = 259,
    RETURN = 260,
    LOOP = 261,
    BREAK = 262,
    WHEN = 263,
    STRUCT = 264,
    PRINT_FUNCTION = 265,
    INPUT_FUNCTION = 266,
    MALLOC_FUNCTION = 267,
    POW_FUNCTION = 268,
    FREE_FUNCTION = 269,
    INT_TYPE = 270,
    FLOAT_TYPE = 271,
    CHAR_TYPE = 272,
    VOID_TYPE = 273,
    BOOL_TYPE = 274,
    STRING_TYPE = 275,
    GEQ = 276,
    LEQ = 277,
    EQUAL = 278,
    DIFF = 279,
    AND = 280,
    OR = 281,
    NOT = 282,
    INT = 283,
    FLOAT = 284,
    BOOL = 285,
    STRING = 286,
    ID = 287,
    EOFF = 288,
    UMINUS = 289,
    LOWER_THAN_PROGRAM = 290,
    PROGRAM = 291,
    LOWER_THAN_ELSE = 292,
    LOWER_THAN_X = 293
  };
#endif
/* Tokens.  */
#define ELSE 258
#define IF 259
#define RETURN 260
#define LOOP 261
#define BREAK 262
#define WHEN 263
#define STRUCT 264
#define PRINT_FUNCTION 265
#define INPUT_FUNCTION 266
#define MALLOC_FUNCTION 267
#define POW_FUNCTION 268
#define FREE_FUNCTION 269
#define INT_TYPE 270
#define FLOAT_TYPE 271
#define CHAR_TYPE 272
#define VOID_TYPE 273
#define BOOL_TYPE 274
#define STRING_TYPE 275
#define GEQ 276
#define LEQ 277
#define EQUAL 278
#define DIFF 279
#define AND 280
#define OR 281
#define NOT 282
#define INT 283
#define FLOAT 284
#define BOOL 285
#define STRING 286
#define ID 287
#define EOFF 288
#define UMINUS 289
#define LOWER_THAN_PROGRAM 290
#define PROGRAM 291
#define LOWER_THAN_ELSE 292
#define LOWER_THAN_X 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 90 "bottom_up/calc.yacc"

  char* value;

#line 137 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
