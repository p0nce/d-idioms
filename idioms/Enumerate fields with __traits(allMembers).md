============================================
Enumerate fields with `__traits(allMembers)`
============================================

Using `__traits(allMembers, X)` allows to iterate on fields of a `struct` or `class` X.


Some uses:
- implement generic serialization/deserialization
- implement a generic comparison, `.dup`, copy, &hellip; for any aggregate
- describe an OpenGL vertex format from the structure


Here is how [DUB](https://github.com/D-Programming-Language/dub) implement a `.dup` with `__traits(allMembers)`:

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

Now if new members are added to BuildSettings, this generic `.dup` will still duplicate them.
