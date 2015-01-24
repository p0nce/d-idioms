================================
Recursive Sum Type with matching
================================

Never write a tagged union by hand again! `std.variant.Algebraic` solves this nicely.

**Recursive data-types are supported** despite the documentation saying it's not.


```
import std.variant, std.typecons;
alias Symbol = Typedef!string;

// an Atom is either:
// - a string,
// - a double,
// - a bool,
// - a Symbol,
// - or Atom[]
alias Atom = Algebraic!(string, double, bool, Symbol, This[]); // Use 'This' for recursive ADT

Atom atom;
if (bool* b = atom.peek!bool()) // is atom a bool?
{
    // here *b is a bool
}

```

`Algebraic` can be used with the [`visit`](http://dlang.org/phobos/std_variant.html#.visit) function to do an exhaustive match.

```
// an exhaustive match with this ADT
string toString(Atom atom)
{
    return atom.visit!(
        (Symbol sym) => cast(string)sym,
        (string s) => s,
        (double x) => to!string(x),
        (bool b) => (b ? "#t" : "#f"),
        (Atom[] atoms) => "(" ~ map!toString(atoms).joiner(" ").array.to!string ~ ")"
    );
}
```

See: [http://dlang.org/phobos/std_variant.html#.Algebraic](http://dlang.org/phobos/std_variant.html#.Algebraic)

