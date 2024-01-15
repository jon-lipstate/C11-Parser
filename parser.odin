package c11

import "core:c/frontend/tokenizer"
Token :: tokenizer.Token
Tokenizer :: tokenizer.Tokenizer
Token_Kind :: tokenizer.Token_Kind
import "core:fmt"

main :: proc() {
	p := parser_init("./basic_types0.h")
	for t := p.tokens; t.kind != Token_Kind.EOF; t = t.next {
		fmt.println(t.kind)
	}

}

Parser :: struct {
	//file: ^File,
	tok:     Tokenizer,
	tokens:  ^Token,
	history: [dynamic]^Token, // todo remove this
	stmts:   [dynamic]^Statement,
}

parser_init :: proc(path: string) -> Parser {
	p := Parser {
		tok = Tokenizer{},
	}
	p.tokens = tokenizer.tokenize_file(&p.tok, path, 1)
	return p
}
advance_token :: proc(p: ^Parser) -> ^Token {
	append(&p.history, p.tokens)
	token := p.tokens
	p.tokens = p.tokens.next
	return token
}
