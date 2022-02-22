`if` embedded declaration
=========================

It's legal to declare a variable inside an `if` condition.

    // AA lookup shortcut
    if (auto found = key in AA)
    {
        // found only defined in this scope
        doStuff(*found);
    }

The branch is taken if the right expression evaluates to a truthy value.

    // Equivalent for Java's instanceof
    if (auto derived = cast(Derived)obj)
    {
        // derived only defined in this scope
        doStuff(derived);
    }
