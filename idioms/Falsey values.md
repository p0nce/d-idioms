Falsey values
=============

In an `if(expr)` condition, `expr` does not need to have boolean type.

Falsey value in D are:
- the integer 0
- the floating point values +0.0 and -0.0 (NaNs and infinities are truthy)
- the `null` pointer / `null` delegate / `null` class reference
- the boolean `false`
- enum members equal to 0
- slices with a null `.ptr` data pointer (length of slice is irrelevant)

Thus, the empty string `""` points to a single `\0` char (string literals are zero-terminated for C compatibility reasons), and is **truthy** despite having length 0.


```

ubyte* p = cast(ubyte*)("".ptr);
assert(p != null);
assert(*p == 0);

```

[See this article for more...](http://minas-mina.com/2015/11/17/if-statement/)