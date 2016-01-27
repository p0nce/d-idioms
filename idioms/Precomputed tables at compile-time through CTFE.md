===============================================
Precomputed tables at compile-time through CTFE
===============================================

D compilers provides extensive [Compile-Time Function Execution](https://en.wikipedia.org/wiki/Compile_time_function_execution).
This feature allows to easily compute almost anything at compile-time, without using an external program.

Here is an example of a precomputed array from the [GFM](https://github.com/d-gamedev-team/gfm) library.

```
static immutable ushort[64] offsettable =
    (){
        ushort[64] t;
        t[] = 1024;        // Fills the table with 1024
        t[0] = t[32] = 0;
        return t;
    }();
```

**What is happening there?**

- `(){   /* body */   }` is short syntax for a `delegate` literal returning `auto` with no argument.

- So, `(){   /* body */   }()` means that we call that `delegate` immediately.

- the literal is executed at compile-time, as enforced by `static immutable`.

But why not use `enum` for this purpose?


## If you must remember one rule from this article

**For large constants, prefer using** `static immutable` **over** `enum`**.**

It's important that `static immutable` is used in the previous example instead of just `enum`. This will create a constant with an address.

`enum` ** creates a compile-time only construct.**
`static immutable` ** actually puts it in the static data segment.**

```
// This example highlights the difference between "enum" and "static immutable" for constants.
import std.stdio;

bool amIInCTFE()
{
    return __ctfe;
}

void main()
{
    bool                  a = amIInCTFE(); // regular runtime initialization
    enum bool             b = amIInCTFE(); // forces compile-time evaluation with enum
    static immutable bool c = amIInCTFE(); // forces compile-time evaluation with static immutable

    writeln(a, " ", &a);   // Prints: "false <address of a>"
    //writeln(b, " ", &b); // Error: enum declarations have no address
    writeln(c, " ", &c);   // Prints: "true <address of c>"
}
```

Using `enum` would duplicate the constant at each call-site, which is inefficient for arrays and may even lead to allocations on use point in the same way than array literals allocate!

This pre-computed fibonacci example fails to compile:
```
enum int[] fibTable =
    (){
        int[] t;
        t ~= 1;
        t ~= 1;
        int precomputedValues = 128;
        foreach(i; 2..precomputedValues)
            t ~= t[i - 1] + t[i - 2];
        return t;
    }();


int fibonacci(int n) pure @nogc
{
    if (n < fibTable.length)  // Error: array literal in @nogc function fibonacci may cause GC allocation
        return fibTable[n];
    else
        return fibonacci(n - 1) + fibonacci(n - 2);
}
```

For all the other uses of `static`, read [this article](#Four-ways-to-use-the-static-keyword-you-may-not-know-about).