===================
Eponymous templates
===================

The term **eponymous templates** refers to a symbol with the same name as its enclosing `template` block.

```
template HasUniqueElements(int[] arr)
{
    import std.algorithm : sort, uniq;
    import std.array : array;
    enum bool HasUniqueElements = arr.sort().uniq.array.length == arr.length;
}

static assert(HasUniqueElements!( [5, 2, 4] ));
static assert(!HasUniqueElements!( [1, 2, 3, 2] ));
```

In symbol resolution, the template instantiation is replaced by the enclosed declaration with the same name. In a way, this is like [`alias this`](#Extending-a-struct-with-alias-this), but for templates.


Bill Baxter came up with the eponymous name in [this thread](http://forum.dlang.org/post/gpb2vd$18uf$1@digitalmars.com).