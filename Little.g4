/**
 * COP4620 
 * Little Grammar
 * Step 2
 */
grammar Little;

//Operators := + - * / = != < > ( ) ; , <= >=
ASSIGN_OP : ':=' ;
PLUS_OP : '+' ;
MINUS_OP : '-' ;
MULTIPLY_OP : '*' ;
DIVIDE_OP : '/' ;
EQ : '=' ;
NEQ: '!=' ;
LT : '<' ;
GT : '>' ;
LTE: '<=' ;
GTE: '>=' ;
LPAREN : '(' ;
RPAREN : ')' ;
SEMICOLON : ';' ;
COMMA : ',' ;


//Keywords PROGRAM,BEGIN,END,FUNCTION,READ,WRITE, IF,ELSE,ENDIF,WHILE,ENDWHILE,CONTINUE,BREAK, 
PROGRAM: 'PROGRAM';
BEGIN: 'BEGIN';
END: 'END';
FUNCTION: 'FUNCTION';
READ: 'READ';
WRITE: 'WRITE';
IF: 'IF';
ELSE: 'ELSE';
ENDIF: 'ENDIF';
WHILE: 'WHILE';
ENDWHILE: 'ENDWHILE';
CONTINUE: 'CONTINUE';
BREAK: 'BREAK';
RETURN: 'RETURN';
INT: 'INT';
VOID: 'VOID';
STRING: 'STRING';
FLOAT: 'FLOAT';

// RETURN,INT,VOID,STRING,FLOAT*/
/*KEYWORD	 : 'PROGRAM' */
			/*| 'BEGIN' */
         /*| 'END' */
      /*| 'FUNCTION'*/
        /*| 'READ'*/
       /*| 'WRITE'*/
        /*| 'IF' */
			/*| 'ELSE' */
         /*| 'ENDIF'*/
			/*| 'WHILE'*/
      /*| 'ENDWHILE'*/
      /*| 'CONTINUE'*/
       /*| 'BREAK'*/
        /*| 'RETURN'*/
		 /*| 'INT'*/
        /*| 'VOID'*/
        /*| 'STRING'*/
       /*| 'FLOAT'*/
         /*;*/
       
//an IDENTIFIER token will begin with a letter, and be followed by any
//number of letters and numbers.
//IDENTIFIERS are case sensitive*/
IDENTIFIER  : ('a'..'z'|'A'..'Z')('a'..'z'|'A'..'Z'|'0'..'9')* ;

// INTLITERAL: integer number ex) 0, 123, 678
INTLITERAL  : ('0'..'9')+ ;

// fLOATLITERAL: floating point number available in two different format yyyy.xxxxxx or .xxxxxxxex) 3.141592 , .1414 , .0001 , 456.98
FLOATLITERAL : ('0'..'9')+ '.' ('0'..'9')*
		|		 '.' ('0'..'9')+
		;
		
// STRINGLITERAL: any sequence of characters except '"'between '"' and '"'ex) "Hello world!" , "***********" , "this is a string"
STRINGLITERAL  : '"' (ESC | . )*? '"' ;
fragment ESC : '\\' [btnr"\\] ; // \b, \t, \n etc...

//COMMENT: 
//Starts with "--" and lasts till the end of line
//ex) -- this is a comment
//ex) -- any thing after the "--" is ignored
LINE_COMMENT : '--' .*? '\r'? '\n' -> skip ;

// Match whitespace and throw it out
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

program : PROGRAM id BEGIN pgm_body END;
id : IDENTIFIER;
pgm_body : decl func_declarations ;
decl : string_decl decl | var_decl decl |  ;
string_decl : STRING id ASSIGN_OP str SEMICOLON;
str : STRINGLITERAL ;
var_decl : var_type id_list SEMICOLON ;
var_type : FLOAT | INT;
any_type : var_type | VOID ;
id_list : id id_tail ;
id_tail : COMMA id id_tail  | ;
param_decl_list : param_decl param_decl_tail |  ;
param_decl : var_type id ;
param_decl_tail : COMMA param_decl param_decl_tail |  ;
func_declarations : func_decl func_declarations | ;
func_decl : FUNCTION any_type id LPAREN param_decl_list RPAREN BEGIN func_body END ;
func_body : decl stmt_list ;

stmt_list : stmt stmt_list  | ;
stmt : base_stmt | if_stmt | while_stmt ;
base_stmt : assign_stmt | read_stmt | write_stmt | return_stmt ;

assign_stmt : assign_expr SEMICOLON ;
assign_expr : id ASSIGN_OP expr ;
read_stmt : READ LPAREN id_list RPAREN SEMICOLON ;
write_stmt : WRITE LPAREN id_list RPAREN SEMICOLON ;
return_stmt : RETURN expr SEMICOLON ;

expr : expr_prefix factor ;
expr_prefix : expr_prefix factor addop | ;
factor : factor_prefix postfix_expr ;
factor_prefix : factor_prefix postfix_expr mulop | ;
postfix_expr : primary | call_expr ;
call_expr : id LPAREN expr_list RPAREN ;
expr_list : expr expr_list_tail | ;
expr_list_tail : COMMA expr expr_list_tail | ;
primary : LPAREN expr RPAREN | id | INTLITERAL | FLOATLITERAL ;
addop : PLUS_OP | MINUS_OP ;
mulop : MULTIPLY_OP | DIVIDE_OP ;

if_stmt : IF LPAREN cond RPAREN decl stmt_list else_part ENDIF ;
else_part : ELSE decl stmt_list | ;
cond : expr compop expr ;
compop : LT | GT | EQ | NEQ | LTE | GTE ;

while_stmt : WHILE LPAREN cond RPAREN decl stmt_list ENDWHILE ;
