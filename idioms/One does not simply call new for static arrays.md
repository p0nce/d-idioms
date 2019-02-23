================================================
One does not simply call `new` for static arrays
================================================

It just happens that in D you can't use `new` to get a pointer to a newly allocated static array.

```
void main()
{
    alias T = int[4];

    // This line does not compile!
    // Error: new can only create structs, dynamic arrays or class objects, not int[4]'s
    auto t = new T; 
}
```

_"You can only call new with structs, dynamic arrays, and class objects"_ says the compiler.

**Unrelated:** actually the compiler is lying a bit, since it is possible to allocate a single (builtin type) value on the heap:

```
void main()
{
    int* p = new int;  // Works
}
```

But this can't be with static arrays, despite them being [value types](#Static-arrays-are-value-types).
Doesn't that sound like an inconsistency? Something that would have to be **explained.**

## Why?

The reasoning for `new` and static arrays was probably that you never really want to allocate a static array on the heap *and then get a raw pointer on that memory*.
It could as well be a slice with little to no speed loss.

**So there is no syntax to do this**.
When you do write `new int[4]` this will instead return a `int[]` _slice_ with a length of 4. 
Like all slices it comes with a length, which is safer.

```
writeln(typeof(new int[4]).stringof); // output: "int[]"
writeln((new int[4]).length); // output: "4"
```

So far, so good. 

[It gets weirder](#Type-qualifiers-and-slices-creation) whenever `shared`, `const` and `immutable` get introduced...