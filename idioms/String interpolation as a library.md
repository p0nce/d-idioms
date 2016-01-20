=================================
String interpolation as a library
=================================

D doesn't have [string interpolation](https://en.wikipedia.org/wiki/String_interpolation) built in the language.
But you can get a similar feature using the `scriptlike` library from Nick Sabalausky.

```
import scriptlike;
int num = 21;
writeln( mixin(interp!"The number ${num} doubled is ${num * 2}.") ); // Output: The number 21 doubled is 42.
```

`scriptlike` also provides many more useful features for quick programs.
Homepage: [https://github.com/Abscissa/scriptlike](https://github.com/Abscissa/scriptlike)