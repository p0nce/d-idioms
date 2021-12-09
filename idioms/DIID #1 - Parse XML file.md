# DIID #1 - Parse a XML file

**Solution:** Use the `arsd-official:dom` package.

## `dub.json`

```d
{
    "name": "parse-xml-file",
    "dependencies":
    {
        "arsd-official:dom": "~>10.0"
    }
}
```

## `inventory.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<inventory>   
    <stuff count="5">
        <name>melons</name> 
    </stuff>

    <stuff count="8">
        <name>lemons</name> 
    </stuff>
</inventory>
```

## `source/main.d`

```d
import std.file;
import std.conv;
import std.string;
import std.stdio;
import arsd.dom;

struct Stuff
{
    string name;
    int count;
}

void main()
{
    Stuff[] allStuff = parseStuff("inventory.xml");
 
    // Do things with stuff
    foreach(s; allStuff)
    {
        writefln("%s %s", s.count, s.name);
    }
}

Stuff[] parseStuff(string xmlpath)
{
    Stuff[] result;
    string content = cast(string)(std.file.read(xmlpath));
    auto doc = new Document();
    bool caseSensitive = true, strict = true;
    doc.parseUtf8(content, caseSensitive, strict);

    foreach (e; doc.getElementsByTagName("stuff"))
    {
        Stuff s;

        // Parse a mandatory attribute (throw if not there)
        s.count = e.getAttribute("count").to!int;

        // Parse sub-tags <name>
        foreach (e2; e.getElementsByTagName("name"))
        {
            s.name = e2.innerText.strip; // strip spaces inside <name>  myname </name>
        }

        result ~= s;
    }

    return result;
}
``` 
Get the source code for all DIID example [here](https://github.com/p0nce/DIID).