String interpolation as a library
=================================

D doesn't have [string interpolation](https://en.wikipedia.org/wiki/String_interpolation) built in the language like PHP, Perl or Python.
Yet you can get a similar feature using the `scriptlike` library from Nick Sabalausky.

```
import scriptlike;
int num = 21;
writeln( mixin(interp!"The number ${num} doubled is ${num * 2}.") ); // Output: The number 21 doubled is 42.
```

## Is `interp` difficult to implement?

It turns out `interp` is a [pretty simple function](https://github.com/Abscissa/scriptlike/blob/4350eb745531720764861c82e0c4e689861bb17e/src/scriptlike/core.d#L114), forced to execute at compile-time through CTFE by the use of `mixin`.



`scriptlike` also provides many more useful features for quick programs.
Homepage: [https://github.com/Abscissa/scriptlike](https://github.com/Abscissa/scriptlike)