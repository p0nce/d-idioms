# DIID #9 - Parse command-line arguments

**Solution:** Use `std.getopt` from Phobos.

## `dub.json`

```json
{
    "name": "cmdline-args",
    "dependencies": {   
    }
}
```

## `source/main.d`

```d
import std.getopt;

int main(string[] args)
{
    string data = null;
    int length = 24;
    bool verbose;
    enum Color { no, yes }
    Color color;
    auto helpInformation = getopt(
                                  args,
                                  "length",  &length,    // numeric
                                  "file",    &data,      // string
                                  "verbose", &verbose,   // flag
                                  "color", "Information about this color", &color);    // enum

    // std.getopt always add an option for --help|-h
    if (helpInformation.helpWanted || data is null) 
    {

        defaultGetoptPrinter("Usage:", helpInformation.options);
        return 1;
    }

    // do things...

    return 0;
}
``` 

Get `std.getopt` documentation [here](https://dlang.org/phobos/std_getopt.html).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).