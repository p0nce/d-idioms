=========================
`assert(false)` is special
==========================

`assert(false)`, `assert(0)`, `assert(null)`, or any other falsey expression at compile-time does not produce a regular `assert`.

Instead it is an instruction to crash the program, and is **not** removed in `-release` mode.


    string getStuff()
    {
        if(expr)
            return "something";
        assert(1 < 0); // also possible, but "assert(0)" is typically used
        // no return needed, since we just crashed
    }


`assert(false)` (or an equivalent) also means that the current branch of the function doesn't need to return anything since the program will always crash when the assertion is reached.


**It does not mean ** _unreachable code_**, it means ** _crash now_ ** and the compiler will never remove it.**


## Always-on assertion

Since `assert(false)` never get removed, it can be used to create a persistent assertion.

```
    if (!cond)
        assert(false); // will never be removed by the compiler in -release builds

```

`assert(false)` is fit for finding bugs, [but not for input errors](#Unrecoverable-vs-recoverable-errors). In this case, prefer the use of `std.exception.enforce`.

See: [http://dlang.org/phobos/std_exception.html#.enforce](http://dlang.org/phobos/std_exception.html#.enforce)

