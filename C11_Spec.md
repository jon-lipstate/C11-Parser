# Annex A: Language syntax summary

[Specification Reference](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf#page=476)

## A.1.1 Lexical elements

```
token ::
    keyword
    identifier
    constant
    string-literal
    punctuator
```

```
preprocessing-token ::
    header-name
    identifier
    pp-number
    character-constant
    string-literal
    punctuator
    each non-white-space character that cannot be one of the above
```

## A.1.2 Keywords

```
keyword: one of
    auto ∗
    break
    case
    char
    const
    continue
    default
    do
    double
    else
    enum
    extern
    float
    for
    goto
    if
    inline
    int
    long
    register
    restrict
    return
    short
    signed
    sizeof
    static
    struct
    switch
    typedef
    union
    unsigned
    void
    volatile
    while
    _Alignas
    _Alignof
    _Atomic
    _Bool
    _Complex
    _Generic
    _Imaginary
    _Noreturn
    _Static_assert
    _Thread_local
```

## A.1.3 Identifiers

```
identifier ::
    identifier-nondigit
    identifier identifier-nondigit
    identifier digit
```

```
identifier-nondigit ::
    nondigit
    universal-character-name
    other implementation-defined characters
```

```
nondigit :: one of
    _abcdefghijklmnopqrstuvwxyz
    ABCDEFGHIJKLMNOPQRSTUVWXYZ
```

```
digit :: one of 0123456789
```

## A.1.4 Universal character names

```
universal-character-name ::
    \u hex-quad
    \U hex-quad hex-quad
```

```
hex-quad ::
    hexadecimal-digit hexadecimal-digit
    hexadecimal-digit hexadecimal-digit
```

## A.1.5 Constants

```
constant ::
    integer-constant
    floating-constant
    enumeration-constant
    character-constant
```

```
integer-constant ::
    decimal-constant integer-suffixopt
    octal-constant integer-suffixopt
    hexadecimal-constant integer-suffixopt
```

```
decimal-constant ::
    nonzero-digit
    decimal-constant digit
```

```
octal-constant ::
    0
    octal-constant octal-digit

```

```
hexadecimal-constant ::
    hexadecimal-prefix hexadecimal-digit
    hexadecimal-constant hexadecimal-digit
```

```
hexadecimal-prefix :: one of
    0x 0X
```

```
nonzero-digit :: one of
    123456789
```

```
octal-digit :: one of
    01234567
```

```
hexadecimal-digit :: one of
    0123456789
    abcdef
    ABCDEF
```

```
integer-suffix ::
    unsigned-suffix long-suffixopt
    unsigned-suffix long-long-suffix
    long-suffix unsigned-suffixopt
    long-long-suffix unsigned-suffixopt
```

```
unsigned-suffix :: one of
    u U
```

```
long-suffix :: one of
    l L
```

```
long-long-suffix :: one of
    ll LL
```

```
floating-constant ::
    decimal-floating-constant
    hexadecimal-floating-constant
```

```
decimal-floating-constant ::
    fractional-constant exponent-partopt floating-suffixopt
    digit-sequence exponent-part floating-suffixopt
```

```
hexadecimal-floating-constant ::
    hexadecimal-prefix hexadecimal-fractional-constant
    binary-exponent-part floating-suffixopt
    hexadecimal-prefix hexadecimal-digit-sequence
    binary-exponent-part floating-suffixopt
```

```
fractional-constant ::
    digit-sequenceopt . digit-sequence
    digit-sequence .
```

```
exponent-part ::
    e signopt digit-sequence
    E signopt digit-sequence
```

```
sign :: one of +, -
```

```
digit-sequence ::
    digit
    digit-sequence digit
```

```
hexadecimal-fractional-constant ::
    hexadecimal-digit-sequenceopt .
    hexadecimal-digit-sequence
    hexadecimal-digit-sequence .
```

```
binary-exponent-part ::
    p signopt digit-sequence
    P signopt digit-sequence
```

```
hexadecimal-digit-sequence ::
    hexadecimal-digit
    hexadecimal-digit-sequence hexadecimal-digit
```

```
floating-suffix :: one of flFL
```

```
enumeration-constant :: identifier
```

```
character-constant ::
    ' c-char-sequence '
    L' c-char-sequence '
    u' c-char-sequence '
    U' c-char-sequence '
```

```
c-char-sequence ::
    c-char
    c-char-sequence c-char
```

```
c-char ::
    any member of the source character set except
    the single-quote ', backslash \, or new-line character
    escape-sequence
```

```
escape-sequence ::
    simple-escape-sequence
    octal-escape-sequence
    hexadecimal-escape-sequence
    universal-character-name
```

```
simple-escape-sequence :: one of
    \' \" \? \\
    \a \b \f \n \r \t \v
```

```
octal-escape-sequence ::
    \ octal-digit
    \ octal-digit octal-digit
    \ octal-digit octal-digit octal-digit
```

```
hexadecimal-escape-sequence ::
\x hexadecimal-digit
hexadecimal-escape-sequence hexadecimal-digit
```

## A.1.6 String literals

```
string-literal ::
    encoding-prefixopt " s-char-sequenceopt "
```

```
encoding-prefix :: u8, u, U, L
```

```
s-char-sequence ::
    s-char
    s-char-sequence s-char
```

```
s-char ::
    any member of the source character set except
    the double-quote ", backslash \, or new-line character
    escape-sequence
```

## A.1.7 Punctuators

```
punctuator :: one of
    [ ] ( ) { } . ->
    ++ -- & * + - ~ !
    / % << >> < > <= >= == != ^ | && ||
    ? : ; ...
    = *= /= %= += -= <<= >>= &= ^= |=
    , # ##
    Digraphs (NOT Supporting) <: :> <% %> %: %:%:
```

## A.1.8 Header names

```
header-name ::
    < h-char-sequence >
    " q-char-sequence "
```

```
h-char-sequence ::
    h-char
    h-char-sequence h-char
```

```
h-char ::
    any member of the source character set except
    the new-line character and >
```

```
q-char-sequence ::
    q-char
    q-char-sequence q-char
```

```
q-char ::
    any member of the source character set except
    the new-line character and "
```

## A.1.9 Preprocessing numbers

```
pp-number ::
    digit
    . digit
    pp-number digit
    pp-number identifier-nondigit
    pp-number e sign
    pp-number E sign
    pp-number p sign
    pp-number P sign
    pp-number .
```

## A.2 Phrase structure grammar

### A.2.1 Expressions

```
primary-expression ::
    identifier
    constant
    string-literal
    ( expression )
    generic-selection
```

```
generic-selection ::
    _Generic ( assignment-expression , generic-assoc-list )
```

```
generic-assoc-list ::
    generic-association
    generic-assoc-list , generic-association
```

```
generic-association ::
    type-name :: assignment-expression
    default :: assignment-expression
```

```
postfix-expression ::
    primary-expression
    postfix-expression [ expression ]
    postfix-expression ( argument-expression-listopt )
    postfix-expression . identifier
    postfix-expression -> identifier
    postfix-expression ++
    postfix-expression --
    ( type-name ) { initializer-list }
    ( type-name ) { initializer-list , }
```

```
argument-expression-list ::
    assignment-expression
    argument-expression-list , assignment-expression
```

```
unary-expression ::
    postfix-expression
    ++ unary-expression
    -- unary-expression
    unary-operator cast-expression
    sizeof unary-expression
    sizeof ( type-name )
    _Alignof ( type-name )
```

```
unary-operator :: one of &\_+-~!
```

```
cast-expression ::
    unary-expression
    ( type-name ) cast-expression
```

```
multiplicative-expression ::
    cast-expression
    multiplicative-expression _ cast-expression
    multiplicative-expression / cast-expression
    multiplicative-expression % cast-expression
```

```
additive-expression ::
    multiplicative-expression
    additive-expression + multiplicative-expression
    additive-expression - multiplicative-expression
```

```
shift-expression ::
    additive-expression
    shift-expression << additive-expression
    shift-expression >> additive-expression
```

```
relational-expression ::
    shift-expression
    relational-expression < shift-expression
    relational-expression > shift-expression
    relational-expression <= shift-expression
    relational-expression >= shift-expression
```

```
equality-expression ::
    relational-expression
    equality-expression == relational-expression
    equality-expression != relational-expression
```

```
AND-expression ::
    equality-expression
    AND-expression & equality-expression
```

```
exclusive-OR-expression ::
    AND-expression
    exclusive-OR-expression ^ AND-expression
```

```
inclusive-OR-expression ::
    exclusive-OR-expression
    inclusive-OR-expression | exclusive-OR-expression
```

```
logical-AND-expression ::
    inclusive-OR-expression
    logical-AND-expression && inclusive-OR-expression
```

```
logical-OR-expression ::
    logical-AND-expression
    logical-OR-expression || logical-AND-expression
```

```
conditional-expression ::
    logical-OR-expression
    logical-OR-expression ? expression :: conditional-expression
```

```
assignment-expression ::
    conditional-expression
    unary-expression assignment-operator assignment-expression
```

```
assignment-operator :: one of = _= /= %= += -= <<= >>= &= ^= |=
```

```
expression ::
    assignment-expression
    expression , assignment-expression
```

```
constant-expression :: conditional-expression
```

## A.2.2 Declarations

```
declaration ::
    declaration-specifiers init-declarator-listopt ;
    static_assert-declaration
```

```
declaration-specifiers ::
    storage-class-specifier declaration-specifiersopt
    type-specifier declaration-specifiersopt
    type-qualifier declaration-specifiersopt
    function-specifier declaration-specifiersopt
    alignment-specifier declaration-specifiersopt
```

```
init-declarator-list ::
    init-declarator
    init-declarator-list , init-declarator
```

```
init-declarator ::
    declarator
    declarator = initializer
```

```
storage-class-specifier ::
    typedef
    extern
    static
    _Thread_local
    auto
    register
```

```
type-specifier ::
    void
    char
    short
    int
    long
    float
    double
    signed
    unsigned
    \_Bool
    \_Complex
    atomic-type-specifier
    struct-or-union-specifier
    enum-specifier
    typedef-name
```

```
struct-or-union-specifier ::
    struct-or-union identifieropt { struct-declaration-list }
    struct-or-union identifier
```

```
struct-or-union ::
    struct
    union
```

```
struct-declaration-list ::
    struct-declaration
    struct-declaration-list struct-declaration
```

```
struct-declaration ::
    specifier-qualifier-list struct-declarator-listopt ;
    static_assert-declaration
```

```
specifier-qualifier-list ::
    type-specifier specifier-qualifier-listopt
    type-qualifier specifier-qualifier-listopt
```

```
struct-declarator-list ::
    struct-declarator
    struct-declarator-list , struct-declarator
```

```
struct-declarator ::
    declarator
    declaratoropt :: constant-expression
```

```
enum-specifier ::
    enum identifieropt { enumerator-list }
    enum identifieropt { enumerator-list , }
    enum identifier
```

```
enumerator-list ::
    enumerator
    enumerator-list , enumerator
```

```
enumerator ::
    enumeration-constant
    enumeration-constant = constant-expression
```

```
atomic-type-specifier ::
    _Atomic ( type-name )
```

```
type-qualifier ::
    const
    restrict
    volatile
    _Atomic
```

```
function-specifier ::
    inline
    _Noreturn
```

```
alignment-specifier ::
    _Alignas ( type-name )
    _Alignas ( constant-expression )
```

```
declarator ::
    pointer_opt direct-declarator
```

```
direct-declarator ::
    identifier
    ( declarator )
    direct-declarator [ type-qualifier-listopt assignment-expressionopt ]
    direct-declarator [ static type-qualifier-listopt assignment-expression ]
    direct-declarator [ type-qualifier-list static assignment-expression ]
    direct-declarator [ type-qualifier-listopt _ ]
    direct-declarator ( parameter-type-list )
    direct-declarator ( identifier-listopt )
```

```
pointer ::
    type-qualifier-listopt
    type-qualifier-listopt pointer
```

```
    type-qualifier-list ::
    type-qualifier
    type-qualifier-list type-qualifier
```

```
parameter-type-list ::
    parameter-list
    parameter-list , ...
```

```
parameter-list ::
    parameter-declaration
    parameter-list , parameter-declaration
```

```
parameter-declaration ::
    declaration-specifiers declarator
    declaration-specifiers abstract-declaratoropt
```

```
identifier-list ::
    identifier
    identifier-list , identifier
```

```
type-name ::
    specifier-qualifier-list abstract-declaratoropt
```

```
abstract-declarator ::
    pointer
    pointeropt direct-abstract-declarator
```

```
direct-abstract-declarator ::
    ( abstract-declarator )
    direct-abstract-declaratoropt [ type-qualifier-listopt
    assignment-expressionopt ]
    direct-abstract-declaratoropt [ static type-qualifier-listopt
    assignment-expression ]
    direct-abstract-declaratoropt [ type-qualifier-list static
    assignment-expression ]
    direct-abstract-declaratoropt [*]
    direct-abstract-declaratoropt ( parameter-type-listopt )
```

```
typedef-name ::
    identifier
```

```
initializer ::
    assignment-expression
    { initializer-list }
    { initializer-list , }
```

```
initializer-list ::
    designationopt initializer
    initializer-list , designationopt initializer
```

```
designation ::
    designator-list =
```

```
designator-list ::
    designator
    designator-list designator
```

```
designator ::
    [ constant-expression ]
    . identifier
```

```
static_assert-declaration ::
    _Static_assert ( constant-expression , string-literal ) ;
```

## A.2.3 Statements

```
statement ::
    labeled-statement
    compound-statement
    expression-statement
    selection-statement
    iteration-statement
    jump-statement
```

```
labeled-statement ::
    identifier : statement
    case constant-expression : statement
    default : statement

```

```
compound-statement ::
    { block-item-listopt }
```

```
block-item-list ::
    block-item
    block-item-list block-item
```

```
block-item ::
    declaration
    statement
```

```
expression-statement ::
    expressionopt ;
```

```
selection-statement ::
    if ( expression ) statement
    if ( expression ) statement else statement
    switch ( expression ) statement
```

```
iteration-statement ::
    while ( expression ) statement
    do statement while ( expression ) ;
    for ( expressionopt ; expressionopt ; expressionopt ) statement
    for ( declaration expressionopt ; expressionopt ) statement
```

```
jump-statement ::
    goto identifier ;
    continue ;
    break ;
    return expressionopt ;
```

## A.2.4 External definitions

```
translation-unit ::
    external-declaration
    translation-unit external-declaration
```

```
external-declaration ::
    function-definition
    declaration
```

```
function-definition ::
    declaration-specifiers declarator declaration-listopt compound-statement
```

```
declaration-list ::
    declaration
    declaration-list declaration
```

## A.3 Preprocessing directives

```
preprocessing-file ::
    groupopt
```

```
group ::
    group-part
    group group-part
```

```
group-part ::
    if-section
    control-line
    text-line
    # non-directive
```

```
if-section ::
    if-group elif-groupsopt else-groupopt endif-line
```

```
if-group ::
    # if constant-expression new-line groupopt
    # ifdef identifier new-line groupopt
    # ifndef identifier new-line groupopt
```

```
elif-groups ::
    elif-group
    elif-groups elif-group
```

```
elif-group ::
    # elif constant-expression new-line groupopt
```

```
else-group ::
    # else new-line groupopt
```

```
endif-line ::
    # endif new-line
```

```
control-line ::
    # include pp-tokens new-line
    # define identifier replacement-list new-line
    # define identifier lparen identifier-list_opt )
    replacement-list new-line
    # define identifier lparen ... ) replacement-list new-line
    # define identifier lparen identifier-list , ... )
    replacement-list new-line
    # undef identifier new-line
    # line pp-tokens new-line
    # error pp-tokensopt new-line
    # pragma pp-tokensopt new-line
    # new-line
```

```
text-line ::
    pp-tokensopt new-line
```

```
non-directive ::
    pp-tokens new-line
```

```
lparen ::
    a ( character not immediately preceded by white-space
```

```
replacement-list ::
    pp-tokensopt
```

```
pp-tokens ::
    preprocessing-token
    pp-tokens preprocessing-token
```

```
new-line ::
    the new-line character
```
