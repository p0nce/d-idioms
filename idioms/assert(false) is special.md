=========================
`assert(false)` is special
==========================

`assert(false)`, `assert(0)`, `assert(null)`…… or any other false expression at compile-time do not produce a regular `assert`.

Instead it is an instruction to crash the program and is **not** removed in `-release` mode.


    string getStuff()
    {
        if(expr)
            return "something";
        assert(1 < 0); // also possible, but "assert(0)" is typically used
        // no return needed, since we just crash
    }


An `assert(false)` form also mean a branch of a function doesn't need to return something since the program will crash.


**It does not mean ** _unreachable code_**, and the compiler will never remove it.**
