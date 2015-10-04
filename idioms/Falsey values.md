=============
Falsey values
=============

In an `if(expr)` condition, `expr` does not need to have boolean type.

Falsey value in D are:
- the integer 0
- the floating point value +0.0 and -0.0
- the `null` pointer / `null` delegate / `null` class reference
- the boolean `false`
- enum members equal to 0
- slices with both length 0 and a null data pointer

Thus, the empty string `""` points to a single `\0` char (string literals are zero-terminated for C compatibility reasons), and is **truthy** despite having length 0.


```

ubyte* p = cast(ubyte*)("".ptr);
assert(p != null);
assert(*p == 0);

```