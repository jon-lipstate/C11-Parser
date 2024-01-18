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
parse_decl :: proc(p: ^Parser) -> bool {
	attrs: Attributes
	base := Base_Type.Unknown
	qual: Qualifiers
	align := 0
	decl_start := p.current_i
	token := p.tokens[p.current_i]
	for {
		parse_base_type(p, &base)

		if true do unimplemented("Was working on decl-parsing")

		// storage-class specifiers
		#partial switch token.kind {
		case .Keyword_typedef:
			attrs |= {.Typedef}
		case .Keyword_extern:
			attrs |= {.Extern}
		case .Keyword_static:
			attrs |= {.Static}
		case .Keyword_inline:
			attrs |= {.Inline}
		case .Keyword__Thread_local:
			attrs |= {.TLS}
		case .Keyword_auto, .Keyword_register, .Keyword__Noreturn:
			fmt.println("Not Supported: .Keyword_auto, .Keyword_register, .Keyword__Noreturn")
			parse_fail(p)
		}
		//Qualifiers
		#partial switch token.kind {
		case .Keyword_const:
			qual |= {.Const}
		case .Keyword_volatile:
			qual |= {.Volatile}
		}
		//abi
		if token.kind == .Keyword___attribute__ {

		}

		token = advance_token(p)
	}

	return true
}

parse_base_type :: proc(p: ^Parser, base: ^Base_Type) -> (did_parse: bool) {
	start_i := p.current_i
	token := p.tokens[p.current_i]
	explicit_signed := false
	explicit_unsigned := false
	n_consume := 1
	// base-types:
	loop: for {
		#partial switch token.kind {
		case:
			break loop
		// Signs
		case .Keyword_unsigned:
			explicit_unsigned = true
		case .Keyword_signed:
			explicit_signed = true
		// Types
		case .Keyword_void:
			base^ = .Void
		case .Keyword_char:
			base^ = .Char
		case .Keyword__Bool:
			base^ = .Bool
		case .Keyword_short:
			base^ = .Short
		//////
		case .Keyword_int:
			fmt.println("FIXME-out of order decl, use PEEKS instead")
			#partial switch base^ {
			case:
				base^ = .Int
			case .Short:
				base^ = .Short
			case .Long:
				base^ = .Long
			case .Long_Long:
				base^ = .Long_Long
			}
		case .Keyword_long:
			#partial switch base^ {
			case:
				base^ = .Long
			case .Long:
				base^ = .Long_Long
			}
		case .Keyword_float:
			base^ = .Float
		case .Keyword_double:
			#partial switch base^ {
			case:
				base^ = .Double
			case .Long:
				base^ = .Long_Double
			}
		case .Keyword_auto, .Keyword__Imaginary:
			fmt.println("Keyword Not Supported")
			parse_fail(p)
		}
		for i in 0 ..< n_consume {token = advance_token(p)}
	}
	return p.current_i != start_i
}

print_token :: proc(t: Token, newline: bool = false) {
	fmt.printf("%v <%v>%v", t.kind, t.text, newline ? "\n" : "")
}

// parser_init :: proc(path: string) -> Parser {
// 	p := Parser {
// 		tok = Tokenizer{},
// 	}
// 	p.tokens = tokenizer.tokenize_file(&p.tok, path, 1)
// 	return p
// }
advance_token :: proc(p: ^Parser) -> Token {
	t := scan(&p.tok)
	append(&p.tokens, t)
	return t
}
peek_token :: proc(p: ^Parser, lookahead := 1) -> Token {
	tmp_tok := p.tok
	tok: Token
	for i in 0 ..< lookahead {
		if tmp_tok.offset >= len(tmp_tok.src) {
			return Token{pos = get_pos(&tmp_tok), kind = .EOF}
		}
		tok = scan(&tmp_tok)
	}
	return tok
}
expect_token :: proc(p: ^Parser, kind: Token_Kind) -> Token {
	t := advance_token(p)
	fmt.assertf(kind == t.kind, "Expected %v, got %v (Line: %v)", kind, t.kind, t.pos.line)
	return t
}
parse_assert :: proc(p: ^Parser, cond: bool, fmt_str: string, args: ..any, loc := #caller_location) {
	if !cond {
		fmt.printf(fmt_str, ..args)
		parse_fail(p)
	}
}
parse_fail :: proc(p: ^Parser) -> ! {
	fmt.println("Parser Error: Preceding Tokens")
	n := 5
	for i := max(0, p.current_i - n); i < p.current_i; i += 1 {
		print_token(p.tokens[i], true)
	}
	print_token(p.tokens[p.current_i])
	fmt.print(" <-- Current Token\n")
	for i in 0 ..< n {
		tok := advance_token(p)
		print_token(tok, true)
		if advance_token(p).kind == .EOF {break}
	}
	panic("Fatal Parse Error")
}
