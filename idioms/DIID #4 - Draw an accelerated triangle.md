# DIID #4 - Draw an accelerated triangle

**Solution:** Use the `arsd-official:nanovega` package.

## `dub.json`

```d
{
    "name": "accelerated-triangle",
    "dependencies":
    {
        "arsd-official:nanovega": "~>10.0"
    }
}
```

## `source/main.d`

```d
import arsd.nanovega;
import arsd.simpledisplay;

void main () 
{
    auto window = new NVGWindow(800, 600, "NanoVega Simple Sample");

    window.redrawNVGScene = delegate (nvg) 
    {
        auto W = window.width;
        auto H = window.height;
        nvg.beginPath();
        nvg.moveTo(W*0.5, H*0.24);
        nvg.lineTo(W*0.3, H*0.7);
        nvg.lineTo(W*0.7, H*0.7);
        nvg.fillPaint = nvg.linearGradient(W*0.3, H*0.5, W*0.7, H*0.7, 
                                           NVGColor("#f00"), NVGColor.green);
        nvg.fill();
    };

    window.eventLoop(0,
        delegate (KeyEvent event) 
        {
            if (event == "*-Q" || event == "Escape") 
            {
                // quit on Q, Ctrl+Q, and so on
                window.close(); 
                return; 
            }
        },
    );
}
``` 

See Nanovega documentation [here](http://arsd-official.dpldocs.info/arsd.nanovega.html).
Get the source code for all DIID example [here](https://github.com/p0nce/DIID).