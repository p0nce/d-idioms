===========
Phobos Gems
===========

## Check recoverable errors with `std.exception.enforce`

It is good practice to check for unrecoverable errors with `assert`, and recoverable errors with `enforce`.
Which means you should [learn the difference](#Unrecoverable-vs-recoverable-errors) between those two types of errors.

See: [http://dlang.org/phobos/std_exception.html#.enforce](http://dlang.org/phobos/std_exception.html#.enforce)

## Allocate a class object on stack with `std.typecons.scoped`

`scoped` replaces `new` and put a `class` object on the stack, with the double benefit of avoiding GC and performing deterministic destruction.

```
import std.typecons;
auto myClass = scoped!MyClass(); // no need for 'new', and automatic destructor call at scope exit.
```

See: [http://dlang.org/phobos/std_typecons.html#.scoped](http://dlang.org/phobos/std_typecons.html#.scoped)

## Remove type qualifiers with `std.traits.Unqual`

`Unqual` enables to write template and instantiate them with `const(T)`, `immutable(T)`, `shared(T)`&hellip;

See: [http://dlang.org/phobos/std_traits.html#.Unqual](http://dlang.org/phobos/std_traits.html#.Unqual)

## Convert a range to a dynamic array with `std.array.array`

`array` is usually used to convert a range computation to a dynamic array.

See: [http://dlang.org/phobos/std_array.html#.array](http://dlang.org/phobos/std_array.html#.array)
