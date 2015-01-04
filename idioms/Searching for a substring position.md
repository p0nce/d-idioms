==================================
Searching for a substring position
==================================

The `countUntil` function in `std.algorithm` gives back the index of the first found substring or -1 if missing.

    import std.algorithm : countUntil;
    assert(countUntil("Hello home sweet home", "home") == 6);

See: [http://dlang.org/phobos/std_algorithm.html#.countUntil](http://dlang.org/phobos/std_algorithm.html#.countUntil)
