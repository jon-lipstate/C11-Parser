#define A_MACRO(a) a

typedef char *Atom;
/* multiline
 comment */
static int FOO; /* inline comment */
// a line comment
typedef struct bar {
  uintptr_t /* why would you do this comment? */ baz;
} bar;