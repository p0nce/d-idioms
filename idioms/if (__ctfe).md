`if (__ctfe)`
=============

D will run a lot of things through Compile-Time Function Execution (CTFE) if you ask for it.
Sometimes it is useful to branch based on whether the function is executing at compile-time or runtime.


That's what `__ctfe` is for.

```
import std.stdio;

string AmIInCTFE()
{
    if (__ctfe)
        return "Hello from CTFE!";
    else
        return "Hello from runtime!";
}

void main(string[] args)
{
    writefln(AmIInCTFE());
    pragma(msg, AmIInCTFE());
}
```
