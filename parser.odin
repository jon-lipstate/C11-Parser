package c11

import "core:c/frontend/tokenizer"
// Token :: tokenizer.Token
// Tokenizer :: tokenizer.Tokenizer
// Token_Kind :: tokenizer.Token_Kind
import "core:fmt"
// start: macro-expanded header
// parse file define
// consume symbols into file define until new file
// from target header, selectively import symbols only as required

main :: proc() {
	tokenizer := init_tokenizer("./basic_types0.h")
	for {
		token := scan(&tokenizer)
		fmt.println(token)
		if token.kind == .EOF {break}
	}
	// p := parser_init("./basic_types0.h")
	// for t := p.tokens; t.kind != Token_Kind.EOF; t = t.next {
	// 	print_token(t, true)
	// }
	// fmt.println("START-PARSER")
	// for p.tokens.next != nil {
	// 	// skip null top-level statements
	// 	for p.tokens.kind == .Punct && p.tokens.lit == ";" {
	// 		advance_token(&p)
	// 	}
	// 	if parse_line_pragma(&p) {continue}
	// 	parse_decl(&p)
	// 	break
	// }
	// fmt.println(p.current_file)

}

// // tests if current line is a line-definition, if so flush current statements into the map, set new current path
// parse_line_pragma :: proc(p: ^Parser) -> bool {
// 	if p.tokens.lit != "#" do return false
// 	// FIXME: 
// 	// cl format: #line 14322 "C:\\Program Files\\AMD\\AOCL-Windows\\amd-blis\\include\\ILP64/blis.h"
// 	// clang format: # 27 "/usr/include/x86_64-linux-gnu/bits/types/__locale_t.h" 3 4

// 	expect_token(p, .Punct)
// 	line_no := expect_token(p, .Number)
// 	path := expect_token(p, .String)
// 	for p.tokens.kind == .Number {advance_token(p)}
// 	// flush into the map:
// 	if len(p.current_stmts) > 0 {
// 		p.contents[p.current_file] = p.current_stmts
// 		p.current_stmts = {}
// 		p.current_file = {}
// 	}
// 	p.current_file.path = path.lit[1:len(path.lit) - 1]
// 	return true
// }
// parse_decl :: proc(p: ^Parser) -> bool {
// 	attrs: Attributes
// 	starting_token := p.tokens
// 	align := 0
// 	token := p.tokens
// 	for {
// 		switch token.kind {
// 		case .Punct:
// 		case .Ident:
// 		case .String:
// 		case .Number:
// 		}
// 	}

// 	return true
// }

// print_token :: proc(t: ^Token, newline: bool = false) {
// 	fmt.printf("%v <%v>%v", t.kind, t.lit, newline ? "\n" : "")
// }

// parser_init :: proc(path: string) -> Parser {
// 	p := Parser {
// 		tok = Tokenizer{},
// 	}
// 	p.tokens = tokenizer.tokenize_file(&p.tok, path, 1)
// 	return p
// }
// advance_token :: proc(p: ^Parser) -> ^Token {
// 	append(&p.history, p.tokens)
// 	token := p.tokens
// 	p.tokens = p.tokens.next
// 	return token
// }
// expect_token :: proc(p: ^Parser, kind: Token_Kind) -> ^Token {
// 	t := advance_token(p)
// 	assert(t.kind == kind)
// 	return t
// }
