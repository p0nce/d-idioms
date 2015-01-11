======================
Porting from C gotchas
======================

## `long` and `unsigned long`

C's `long` and `unsigned long` have variable size, no builtin type is equivalent in D!

The recommended way is to use `c_long` and `c_ulong` from module `core.stdc.config`.


    // A C function declaration
    unsigned long countBeans(const long* n)

    // Equivalent D function declaration
    import core.stdc.config;
    c_ulong countBeans(const(c_long)* n);

`c_int` and `c_uint` also exist to replace `int` and `unsigned int`, but because they are 32-bits in most architectures, it's usually simply translated with D's `int` and `uint` instead.


## Multi-dimensional arrays declarations

    // A C array declaration
    int myMatrix[4][2] = { { 1, 2}, { 3, 4}, { 5, 6}, { 7, 8} };

    // Equivalent D array declaration
    int[2][4] myMatrix = [ [ 1, 2], [ 3, 4], [ 5, 6], [ 7, 8] ];


## Enum values without enum namespace

    // A C enum declaration
    typedef enum
    {
        STRATEGY_RANDOM,
        STRATEGY_IMMEDIATE,
        STRATEGY_SEARCH
    } strategy_t;

    // Equivalent D enum declaration
    alias strategy_t = int;
    enum : strategy_t
    {
        STRATEGY_RANDOM,
        STRATEGY_IMMEDIATE,
        STRATEGY_SEARCH
    }

This avoids having to write `strategy_t.STRATEGY_IMMEDIATE` instead of `STRATEGY_IMMEDIATE` when porting C code.


