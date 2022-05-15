# DIID #11 - Write current date on a PNG

**Solution:** Use the `dplug:graphics` [package](https://code.dlang.org/packages/dplug%3Agraphics).

## `dub.json`

```json
{
    "name": "write-current-date-on-png",
    "dependencies":
    {
        "dplug:graphics": "~>12.0"      
    }
}
```

## Input image and font file

This program assumes `input.png` and `VeraBd.ttf` in the project directory.


## `source/main.d`

```d
static import std.file;
import std.datetime;
import dplug.graphics;


void main(string[] args)
{
    // Load image.
    auto image = loadOwnedImage( std.file.read("input.png") );

    // Load font.
    auto font = new Font( cast(ubyte[]) std.file.read("VeraBd.ttf") );

    // Write text.
    RGBA red = RGBA(255, 0, 0, 255);
    float textX = 20;
    float textY = 20;
    float fontSize = 16;
    string timeStr = Clock.currTime().toISOExtString();
    image.toRef.fillText(font, timeStr, fontSize, 0.0, red, textX, textY, HorizontalAlignment.left);

    // Save image.
    std.file.write("output.png", image.toRef.convertImageRefToPNG);
}
``` 

Get `dplug:graphics` documentation [here](http://dplug.dpldocs.info/dplug.graphics.html).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).
**Alternative:** [arsd solution](https://forum.dlang.org/post/khfkwerastkiijdrslzt@forum.dlang.org).