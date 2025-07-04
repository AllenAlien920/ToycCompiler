grammar Toyc;

startRule : compUnit EOF;

compUnit : funcDef+;

funcDef : (INT | VOID) ID LPAREN (param (COMMA param)*)? RPAREN block;

param : INT ID;

block : LBRACE stmt* RBRACE;

stmt : block
     | SEMI
     | expr SEMI
     | ID ASSIGN expr SEMI
     | INT ID ASSIGN expr SEMI
     | IF LPAREN expr RPAREN stmt (ELSE stmt)?
     | WHILE LPAREN expr RPAREN stmt
     | BREAK SEMI
     | CONTINUE SEMI
     | RETURN expr? SEMI
;

expr
    : '(' expr ')'                          # parenExpr
    | ('+'|'-'|'!') expr                    # unaryExpr
    | expr ('*'|'/'|'%') expr               # mulDivExpr
    | expr ('+'|'-') expr                   # addSubExpr
    | expr ('<'|'>'|'<='|'>=') expr         # relExpr
    | expr ('=='|'!=') expr                 # eqExpr
    | expr '&&' expr                        # andExpr
    | expr '||' expr                        # orExpr
    | ID                                    # idExpr
    | NUMBER                                # numExpr
    | ID LPAREN (expr (COMMA expr)*)? RPAREN # callExpr
;

// Lexer rules
NUMBER : ('-')? DIGIT+;
ID : [a-zA-Z_][a-zA-Z0-9_]*;

// Keywords
INT : 'int';
VOID : 'void';
IF : 'if';
ELSE : 'else';
WHILE : 'while';
BREAK : 'break';
CONTINUE : 'continue';
RETURN : 'return';

// Operators and punctuation
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
COMMA : ',';
SEMI : ';';
ASSIGN : '=';
PLUS : '+';
MINUS : '-';
TIMES : '*';
DIV : '/';
MOD : '%';
NOT : '!';
EQ : '==';
NE : '!=';
LT : '<';
LE : '<=';
GT : '>';
GE : '>=';
OR : '||';
AND : '&&';

// Comments and whitespace
LINE_COMMENT : '//' .*? '\n' -> skip;
BLOCK_COMMENT : '/*' .*? '*/' -> skip;
WS : [ \t\r\n]+ -> skip;

fragment DIGIT : [0-9];
