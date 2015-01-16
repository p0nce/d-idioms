======================
Porting from C gotchas
======================

## Globals must be marked `__gshared`

Variables at global scope are in Thread Local Storage (TLS) unless qualified with `shared` or `__gshared`. You are [probably](#The-truth-about-shared) wanting to use `__gshared`.


    // A C global variable
    int my_global_var;

    // Equivalent D global
    __gshared int myGlobalVar;


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


## Anonymous `struct` and `union`

D provides a limited form of anonymous nested `struct` and `union`, but they can't be used to translate this C anonymous struct:

    // A C anonymous struct
    struct Foo
    {
        struct
        {
            int x;
        } bar;
    };

    // Equivalent D
    struct Foo
    {
        private struct bar_t
        {
            int x;
        }
        bar_t bar;
    }


## Convert array to pointers explicitely

When porting from C you will probably have to spam `.ptr` anywhere an array is implicitely converted to a pointer.

    // In C
    void sum(const int *array, int n);
    int coeff[16];
    sum(coeff, sizeof(coeff) / sizeof(int));

    // In D
    void sum(const(int)* array, int n);
    int[16] coeff;
    sum(coeff.ptr, coeff.sizeof / int.sizeof); // array not implicitely convertible to a pointer



