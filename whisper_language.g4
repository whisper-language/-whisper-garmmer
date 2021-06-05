grammar whisper_language;

parse
 : (block|statement) EOF
 ;

block
 : ( statement | functionDecl )* ( Return expression ';' )?
 ;

statement
 : assignment ';'
 | functionCall ';'
 | ifStatement
 | forStatement
 | whileStatement
 ;

assignment
 : Identifier indexes? '=' expression
 ;

functionCall
 : BuildIdentifier '(' exprList? ')' #buildInIdentifierFunctionCall
 | Identifier '(' exprList? ')' #identifierFunctionCall
 | Println '(' expression? ')'  #printlnFunctionCall
 | Print '(' expression ')'     #printFunctionCall
 | Assert '(' expression ')'    #assertFunctionCall
 | Size '(' expression ')'      #sizeFunctionCall
 ;

ifStatement
 : ifStat elseIfStat* elseStat?
 ;

ifStat
 : If expression OBrace block CBrace
 ;

elseIfStat
 : Else If expression OBrace block CBrace
 ;

elseStat
 : Else OBrace block  CBrace
 ;

functionDecl
 : Def Identifier '(' idList? ')'  OBrace block CBrace
 ;

forStatement
 : For Identifier '=' expression To expression OBrace block CBrace
 ;

whileStatement
 : While expression OBrace block CBrace
 ;

idList
 : Identifier ( ',' Identifier )*
 ;

exprList
 : expression ( ',' expression )*
 ;

expression
 : '-' expression                                       #unaryMinusExpression
 | '!' expression                                       #notExpression
 | <assoc=right> expression '^' expression              #powerExpression
 | expression op=( '*' | '/' | '%' ) expression         #multExpression
 | expression op=( '+' | '-' ) expression               #addExpression
 | expression op=( '>=' | '<=' | '>' | '<' ) expression #compExpression
 | expression op=( '==' | '!=' ) expression             #eqExpression
 | expression '&&' expression                           #andExpression
 | expression '||' expression                           #orExpression
 | expression '?' expression ':' expression             #ternaryExpression
 | expression In expression                             #inExpression
 | Number                                               #numberExpression
 | Bool                                                 #boolExpression
 | Null                                                 #nullExpression
 | functionCall indexes?                                #functionCallExpression
 | list_Alias indexes?                                  #listExpression
 | Identifier indexes?                                  #identifierExpression
 | String_Alias indexes?                                #stringExpression
 | '(' expression ')' indexes?                          #expressionExpression
 | Input '(' String_Alias? ')'                          #inputExpression
 ;

list_Alias
 : '[' exprList? ']'
 ;

indexes
 : ( '[' expression ']' )+
 ;

Println  : 'println';
Print    : 'print';
Input    : 'input';
Assert   : 'assert';
Size     : 'size';
Def      : 'func';
If       : 'if';
Else     : 'else';
Return   : 'return';
For      : 'for';
While    : 'while';
To       : 'to';
Do       : 'do';
End      : 'end';
In       : 'in';
Null     : 'null';

//------------------ 位操作运算符
LABEL_Alias         :   'label';
GOTO_Alias          :   'goto';
JUMP_Alias          :   'jump';
IMPORT_Alias        :   'import';
INCLUDE_Alias       :   'include';
Modulus_Alias       :   'modulue';
Class_Alias         :   'class';
INTERFACE_Alias     :   'interface';
EXTEND_Alias        :   'extend';
//------------------


//------------------ 位操作运算符
BitwiseAnd                  :  '&';
BitwiseOr                   :  '|';
BitwiseNot                  :  '^';
//按位取反
BitwiseNegationOperator     :  '~';
LeftShiftOperator           :  '>>';
RightShiftOperator          :  '<<';
//------------------



Or       : '||';
And      : '&&';
Equals   : '==';
NEquals  : '!=';
GTEquals : '>=';
LTEquals : '<=';
Excl     : '!';
GT       : '>';
LT       : '<';
Add      : '+';
Subtract : '-';
Multiply : '*';
Divide   : '/';
Modulus  : '%';
OBrace   : '{';
CBrace   : '}';
OBracket : '[';
CBracket : ']';
OParen   : '(';
CParen   : ')';
SColon   : ';';
Assign   : '=';
Comma    : ',';
QMark    : '?';
Colon    : ':';

Bool
 : 'true' 
 | 'false'
 ;

Number
 : Int ( '.' Digit* )?
 ;

BuildIdentifier
 : [@] [a-zA-Z_0-9]*
 ;

Identifier
 : [a-zA-Z_] [a-zA-Z_0-9]*
 ;

String_Alias
 : ["] ( ~["\r\n\\] | '\\' ~[\r\n] )* ["]
 | ['] ( ~['\r\n\\] | '\\' ~[\r\n] )* [']
 ;

Comment
 : ( '//' ~[\r\n]* | '/*' .*? '*/' ) -> skip
 ;

Space
 : [ \t\r\n\u000C] -> skip
 ;

fragment Int
 : [1-9] Digit*
 | '0'
 ;
  
fragment Digit 
 : [0-9]
 ;