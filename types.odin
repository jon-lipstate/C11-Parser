package c11

Line_Pragma :: struct {
	path: string,
}
Parser :: struct {
	tok:           Tokenizer,
	tokens:        [dynamic]Token,
	current_i:     int,
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

Qualifier_Flag :: enum {
	Const,
	Volatile,
	Restrict,
	Atomic,
}
Qualifiers :: bit_set[Qualifier_Flag]

ABI :: enum {
	CDecl, // __attribute__((cdecl)) gcc/clang
	Std_Call, // __stdcall msvc or __attribute__((stdcall)) gcc/clang
	Fast_Call, // __fastcall msvc or __attribute__((fastcall)) gcc/clang
	// This_Call, // cpp...
	// Pascal, // borland compilers only?
	Vector_Call, //__vectorcall msvc
}

// Assume types are signed by default
Base_Type :: enum {
	Unknown,
	Other,
	Void,
	Bool,
	Char,
	// Signed_Char,
	Unsigned_Char,
	Short,
	// Signed_Short,
	Unsigned_Short,
	Int,
	// Signed_Int,
	Unsigned_Int,
	Long,
	// Signed_Long,
	Unsigned_Long,
	Long_Long,
	// Signed_Long_Long,
	Unsigned_Long_Long,
	Float,
	Double,
	Long_Double,

	// Combinations with Int:
	// Short_Int, // -> short
	// Signed_Short_Int, // -> short
	// Unsigned_Short_Int, // -> unsigned_short
	// Long_Int,// -> long
	// Signed_Long_Int,// -> long
	// Unsigned_Long_Int,// -> unsigned_long
	// Long_Long_Int,// -> long_long
	// Signed_Long_Long_Int,// -> long_long
	// Unsigned_Long_Long_Int,// -> unsigned_long_long
}
