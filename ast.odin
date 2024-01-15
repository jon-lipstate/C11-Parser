package c11

Statement :: struct {}

Type :: struct {
	kind:  Type_Kind,
	size:  int,
	align: int,
	// flags:?
	// loc:   Pos,
}
Type_Kind :: enum {
	Void,
	Bool,
	Char,
	Short,
	Int,
	Enum,
	Long,
	LLong,
	Float,
	Double,
	Pointer,
	Function,
	Array,
	VLA,
	Struct,
	Union,
	Vector,
	Placeholder,
	Typeof,
}
