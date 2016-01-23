=======================
Design by Introspection
=======================

## What is Design by Introspection?

Coined and promoted by Andrei Alexandrescu, **Design by Introspection** (also known as "DbI") means something pretty specific: instead of multiplying the number of named concepts in generic code, let's **inspect types at compile-time for capabilities**.

An example is Phobos' input ranges that can be [infinite](http://dlang.org/phobos/std_range_primitives.html#.isInfinite) regardless of the particular compile-time concept they follow.

In the D language, such duck-typing at compile-time seems to unlock most interesting designs.

## Code examples

- `std.range.primitives`: [http://dlang.org/phobos/std_range_primitives.html](http://dlang.org/phobos/std_range_primitives.html)

- `std.experimental.allocator`: [http://dlang.org/phobos/std_experimental_allocator.html](http://dlang.org/phobos/std_experimental_allocator.html)

## Where do I start?

There is currently not much written on this programming technique.

The best resource on the topic is probably this talk by Alexandrescu: [std::allocator Is to Allocation what std::vector is to Vexation](https://www.youtube.com/watch?v=LIb3L4vKZ7U).
