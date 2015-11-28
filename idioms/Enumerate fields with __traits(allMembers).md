============================================
Enumerate fields with `__traits(allMembers)`
============================================

Using `__traits(allMembers, X)` allows us to iterate on the fields of a `struct` or `class`.


This can be useful when:
- implementing generic serialization/deserialization
- implementing a generic comparison, `.dup`, copy, &hellip; for any aggregate
- describing an OpenGL vertex format from the structure
- ...

Here's how [DUB](https://github.com/D-Programming-Language/dub) implements a `.dup` with `__traits(allMembers)`:

    BuildSettings dup() const
    {
        BuildSettings ret;
        foreach (m; __traits(allMembers, BuildSettings)) // this foreach is a special "static" foreach
        {
            static if (is(typeof(__traits(getMember, ret, m) = __traits(getMember, this, m).dup)))
                __traits(getMember, ret, m) = __traits(getMember, this, m).dup;
            else static if (is(typeof(__traits(getMember, ret, m) = __traits(getMember, this, m))))
                __traits(getMember, ret, m) = __traits(getMember, this, m);
        }
        return ret;
    }

When new members are added to BuildSettings, this generic `.dup` will still duplicate them.
