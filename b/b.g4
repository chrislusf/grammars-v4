/*
BSD License

Copyright (c) 2016, Tom Everett
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of Tom Everett nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

grammar b;

program
   : definition
   ;

definition
   : (name constant? (ival (',' ival)*)* ';')
   | (name '(' (name (',' name)*)* ')' statement)
   ;

ival
   : constant
   | name
   ;

statement
   : externsmt
   | externsmt
   | (name ':' statement)
   | casestmt
   | blockstmt
   | ifstmt
   | whilestmt
   | switchstmt
   | gotostmt
   | returnstmt
   | functionstmmt
   ;

blockstmt
   : '{' statement* '}'
   ;

returnstmt
   : 'return' ('(' expression ')')? ';'
   ;

gotostmt
   : 'goto' expression ';'
   ;

switchstmt
   : 'switch' expression statement
   ;

whilestmt
   : 'while' '(' expression ')' statement
   ;

ifstmt
   : 'if' '(' expression ')' statement ('else' statement)
   ;

casestmt
   : 'case' constant ':' statement
   ;

externsmt
   : 'extrn' name (',' name)* ';' statement
   ;

autosmt
   : 'auto' name constant (',' name constant)* ';' statement
   ;

functionstmmt
   : name expression ';'
   ;

rvalue
   : expression
   | (expression binary expression)
   | (expression '?' expression ':' expression)
   | (expression '(' expression (',' expression)* ')')
   ;

expression
   : ('(' expression ')')
   | name
   | constant
   | (name assign expression)
   | (incdec name)
   | (name incdec)
   | (unary expression)
   | ('&' name)
   ;

assign
   : '=' binary
   ;

incdec
   : '++'
   | '--'
   ;

unary
   : '-'
   | '!'
   ;

binary
   : '|'
   | '&'
   | '=='
   | '!='
   | '<'
   | '<='
   | '>'
   | '>='
   | '<<'
   | '>>'
   | '-'
   | '+'
   | '%'
   | '*'
   | '/'
   |
   ;

lvalue
   : name
   | ('*' rvalue)
   | (rvalue '[' rvalue ']')
   ;

constant
   : INT
   | STRING1
   | STRING2
   ;

name
   : NAME
   ;


NAME
   : [a-zA-Z] [a-zA-Z0-9_]*
   ;


INT
   : [0-9] +
   ;


STRING1
   : '"' ~ ["\r\n]* '"'
   ;


STRING2
   : '\'' ~ [\'\r\n]* '\''
   ;


WS
   : [ \t\r\n] -> skip
   ;
