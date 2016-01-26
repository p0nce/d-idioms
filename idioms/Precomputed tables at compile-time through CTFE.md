===============================================
Precomputed tables at compile-time through CTFE
===============================================

D compilers provides extensive [Compile-Time Function Execution](https://en.wikipedia.org/wiki/Compile_time_function_execution).
This feature allows to easily compute tables at compile-time, without using an external program.

Here is an example from the [GFM](https://github.com/d-gamedev-team/gfm) library.

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

- the literal is executed at compile-time, as forced by `static immutable`.

It's important `static immutable` is used here instead of just `enum`.
See the article on the `static` keyword for [more details](#Four-ways-to-use-the-static-keyword-you-may-not-know-about).



