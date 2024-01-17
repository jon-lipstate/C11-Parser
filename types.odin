package c11

Line_Pragma :: struct {
	path: string,
}
Parser :: struct {
	//file: ^File,
	tok:           Tokenizer,
	tokens:        ^Token,
	history:       [dynamic]^Token, // todo remove this
	//
	contents:      map[Line_Pragma][dynamic]^Statement,
	//
	current_file:  Line_Pragma,
	current_stmts: [dynamic]^Statement,
}

Attribute_Flag :: enum {
	Static,
	Typedef,
	Inline,
	Extern,
	TLS,
}
Attributes :: bit_set[Attribute_Flag]

Base_Type :: enum {
	Unknown,
	Void,
	Bool,
	Char,
	Short,
	Int,
	Long,
	Float,
	Double,
	// Other,
	Signed,
	Unsigned,
}
