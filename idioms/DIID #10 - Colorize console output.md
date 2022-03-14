# DIID #10 - Colorize console output

**Solution:** Use the `colorize` [package](https://code.dlang.org/packages/colorize).

## `dub.json`

```json
{
    "name": "colorize-text-output",
    "dependencies": 
    {
        "colorize": "~>1.0"
    }
}
```

## `source/main.d`

```d
import std.getopt;

import colorize;

void main()
{
    cwriteln("This is light_blue".color(fg.light_blue));
    auto c = "light_red";
    cwritefln("This is %s in this nested coloured text".color("red"), c.color(c));
}
``` 

Get `colorize` documentation [here](https://code.dlang.org/packages/colorize).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).