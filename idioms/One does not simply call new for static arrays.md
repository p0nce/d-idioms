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

But this can't be with static arrays, despite them being [value types](#Static-arrays-are-value-types). Doesn't that sound like an inconsistency? Something that would have to be **explained.**

## Why?

The reasoning for `new` and static arrays was probably that you rarely really want to allocate a static array on the heap; it could just as well be a slice.

**So there is no syntax to do this**.
When you do write `new int[4]` this will instead return an `int[]` _slice_ with a length of 4, which adds the benefits of holding a length.

```
writeln(typeof(new int[4]).stringof); // output: "int[]"

auto arr = new int[4];
writeln(arr.length); // output: "4"
arr ~= 42;
writeln(arr.length); // output: "5"
```

So far, so good. 

[It gets weirder](#Type-qualifiers-and-slices-creation) whenever `shared`, `const` and `immutable` get introduced...

## Do it anyway

If for some reason you really need a _static_ array allocated on the heap instead of a slice, you can do it anyway by using `std.experimental.allocator` (or its DUB equivalent [stdx-allocator](https://code.dlang.org/packages/stdx-allocator)):

```
import std.experimental.allocator;

void main()
{
    alias T = int[4];

 // T* t = new T;                 // Won't work.
    T* t = theAllocator.make!T;   // Fine!
    assert((*t).length == 4);     // Safe too.

    (*t)[1] = 42;                 // Needs pointer dereference and parentheses before use.
    assert(*t == [0, 42, 0, 0]);  // Features default initialization.
    
 // (*t) ~= 43; // Error: cannot append type int to type int[4]
}
```

_This idiom got some help from Bastiaan Veelo._