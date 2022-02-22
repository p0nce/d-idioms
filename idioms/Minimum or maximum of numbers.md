Minimum or maximum of numbers
=============================

`min` and `max` are found in `std.algorithm`, not `std.math`.

    import std.algorithm : max;
    int a = -5;
    int b = 4;
    double c = 10.0;
    double max_abc = max(a, b, c);
    assert(max_abc == 10.0);

They work with builtin types and any number of arguments.

See: [http://dlang.org/phobos/std_algorithm.html#.min](http://dlang.org/phobos/std_algorithm.html#.min)


## Minimum or maximum of a slice


There is no standard function to get the minimum and maximum element of a slice.
But you can use `std.algorithm.reduce()`.

```
import std.algorithm : min, max, reduce;

double[] slice = [3.0, 4.0, -2.0];

double minimum = reduce!min(slice);
double maximum = reduce!max(slice);

assert(minimum == -2.0);
assert(maximum == 4.0);
```
