==========================
Type qualifiers and slices
==========================

When a slice is created with `new` and a type qualifier, the qualifier applies to _pointed elements_ 
instead of the whole slice as would be expected.


```
import std.stdio;

void main(string[] args)
{
    // Output: "const(int)[]"
    writeln(typeof(new const(int[4])).stringof);
    
    // Output: "immutable(int)[]"
    writeln(typeof(new immutable(int[4])).stringof);
    
    // Output: "shared(int)[]"
    writeln(typeof(new shared(int[4])).stringof);
}
```

**Note:** this syntax [doesn't return pointers to static arrays](#One-does-not-simply-call-new-for-static-arrays) but indeed return a slice.

_This peculiarity was emphasized at DConf 2018 by Andrei Alexandrescu._