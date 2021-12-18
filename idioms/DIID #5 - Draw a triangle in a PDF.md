# DIID #5 - Draw a triangle in a PDF

**Solution:** Use the `printed:canvas` package.

## `dub.json`

```d
{
    "name": "pdf-triangle",
    "dependencies":
    {
        "printed:canvas": "~>1.0"
    }
}
```

## `source/main.d`

```d
import std.stdio;
import std.file;
import printed.canvas;

void main(string[] args)
{
    auto pdfDoc = new PDFDocument();
    IRenderingContext2D renderer = pdfDoc;
    with(renderer)
    {
        // Draw a 50% transparent green triangle
        fillStyle = brush("rgba(0, 255, 0, 0.5)");
        beginPath(80, 70);
        lineTo(180, 70);
        lineTo(105, 140);
        closePath();
        fill();

        fillStyle = brush("black");
        fillText("That was easy.", 20, 20);        
    }
    std.file.write("output.pdf", pdfDoc.bytes);
}
``` 

See the printed API [here](https://github.com/AuburnSounds/printed/blob/master/canvas/printed/canvas/irenderer.d).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).