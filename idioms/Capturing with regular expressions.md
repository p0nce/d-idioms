Capturing with regular expressions
==================================

Regular expressions are found in the `std.regex` Phobos module.

```
import std.regex;
import std.stdio;

void main(string[] args)
{
    auto re = regex(`My name is (\w+)\. I work for ([A-Za-z ]+)\.`);

    string input = "My name is Kobayashi. I work for Keyser Soze.";

    if (auto captures = matchFirst(input, re))
    {
        // There is a trap there, capture[0] is the whole matched string
        writefln("First capture = %s", captures[1]);
        writefln("2nd capture   = %s", captures[2]);
    }
}
```

`ctRegex` instead of `regex` builds the regular expression at compile-time, trading off compile-time speed for runtime speed.

```
auto re = ctRegex!(`My name is (\w+)\. I work for ([A-Za-z ]+)\.`); // automaton built at compile-time
```

See: [http://dlang.org/phobos/std_regex.html](http://dlang.org/phobos/std_regex.html)
