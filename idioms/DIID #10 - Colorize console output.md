# DIID #10 - Colorize console output

**Solution:** Use the `console-colors` [package](https://code.dlang.org/packages/console-colors).

## `dub.json`

```json
{
    "name": "colorize-text-output",
    "dependencies": 
    {
        "console-colors": "~>1.0"
    }
}
```

## `source/main.d`

```d
import consolecolors;

void main()
{
    cwriteln("This is light blue on orange".lblue.on_orange);    
    cwritefln("This is a <red>%s</red>.", "nested <yellow>color</yellow> string");
}
``` 

Get `console-colors` documentation [here](https://github.com/p0nce/console-colors).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).