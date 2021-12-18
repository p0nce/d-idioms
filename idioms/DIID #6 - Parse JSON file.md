# DIID #6 - Parse JSON file

**Solution:** Use the `arsd-official:jsvar` [package](https://code.dlang.org/packages/arsd-official).

## `dub.json`

```d
{
    "name": "parse-json-file",
    "dependencies":
    {
        "arsd-official:jsvar": "~>10.0"
    }
}
```

## `inventory.json`

```json
{
    "stuff":
    [
        {
            "name": "melons",
            "count": 5
        },
        {
            "name": "lemons",
            "count": 8
        }
    ]
}
```

## `source/main.d`

```d
import std.file;
import std.stdio;
import arsd.jsvar;

void main(string[] args)
{
    var inventory = var.fromJson( cast(string) std.file.read("inventory.json") );

    foreach(i, v; inventory.stuff)
    {
        writefln("Item %s: name = %s count = %s", i, v.name, v.count);
    }
}
``` 

Get jsvar documentation [here](http://arsd-official.dpldocs.info/arsd.jsvar.html).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).