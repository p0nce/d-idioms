===============
Voldemort types
===============

A _Voldemort type_ is simply a type that can't be named by the user.

## An example from `ae.utils.graphics`:

```
template procedural(alias formula)
{
    alias fun = binaryFun!(formula, "x", "y");
    alias Color = typeof(fun(0, 0));

    // Returning auto is necessary here.
    // Procedural can't be named outside of the procedural function.
    auto procedural()
    {
        struct Procedural
        {
            auto ref Color opIndex(int x, int y)
            {
                return fun(x, y);
            }
        }
        return Procedural();
    }
}
```

Outside of the `procedural` function of this [eponymous template](#Eponymous-templates), there is no way to name `Procedural`. Therefore, **Voldemort types can only be passed around in auto variables or auto returns.**

## Why?

Hiding information about types. Because the user can't name or instantiate Voldemort types at will, expressions in a Voldemort lazy computation chain can change types without changing user code.

Voldemort types were promoted and named by Andrei Alexandrescu. They are typically used in chains of lazy computations, like ranges.

See also: [Voldemort Types in D](http://www.drdobbs.com/cpp/voldemort-types-in-d/232901591)

## Avoidind symbol bloat with the Horcrux Method

Using Voldemort types can lead to excessive executable bloat due to long symbol names. Applying the *Horcrux method* can help solve this.

See: [http://www.schveiguy.com/blog/2016/05/have-your-voldemort-types-and-keep-your-disk-space-too/](http://www.schveiguy.com/blog/2016/05/have-your-voldemort-types-and-keep-your-disk-space-too/)


