==================
Minimum or maximum
==================

`min` and `max` are found in `std.algorithm`, not `std.math`.


    import std.algorithm : max;
    int a = -5;
    int b = 4;
    double c = 10.0;
    double max_abc = max(a, b, c);
    assert(max_abc == 10.0);

They work with builtin types and any number of arguments.
