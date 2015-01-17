===========
Phobos Gems
===========

## Check recoverable errors with `std.exception.enforce`

It is good practice to check for unrecoverable errors with `assert`, and recoverable errors with `enforce`.
Which means you should learn the difference between those two types of errors.

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


## Closed sum type with `std.variant.Algebraic`

Never write a tagged union by hand again! `Algebraic` solves this nicely.

```
import std.variant, std.typecons;
alias Symbol = Typedef!string;
alias Builtin = Atom delegate(Atom[] args);
alias Atom = Algebraic!(string, double, bool, Symbol, This[]); // an Atom is one of these things

Atom atom;
if (bool* b = atom.peek!bool()) // is atom a bool?
{
    // here *b is a bool
}

```
Recursive data-types are supported despite the documentation saying it's not.

See: [http://dlang.org/phobos/std_variant.html#.Algebraic](http://dlang.org/phobos/std_variant.html#.Algebraic)


