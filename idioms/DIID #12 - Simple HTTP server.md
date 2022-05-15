# DIID #12 - Simple HTTP server

**Solution:** Use the `arsd-occicial:cgi` [package](https://code.dlang.org/packages/arsd-official%3Acgi).

## `dub.json`

```json
{
    "name": "simple-HTTP-server",
    "dependencies":
    {
        "arsd-official:cgi": "~>10.0"
    }
}
```

## `index.html`

```html
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <h1>Hello</h1>
    <p>This page brought to you by D.</p>
  </body>
</html>
```


## `source/main.d`

```d
static import std.file;
import arsd.cgi;
import std.format;
import std.stdio;

void myHTTPServer(Cgi cgi) 
{
    string url = cgi.pathInfo;
    writefln("GET %s", url);
    switch(cgi.pathInfo) 
    {
        case "/style.css":
            cgi.setResponseContentType("text/css");
            cgi.write("body { color: red; }");
            break;

        case "/":
            cgi.setResponseContentType("text/html");
            cgi.write(std.file.read("index.html"));
            break;

        default:
            cgi.setResponseStatus(404);
    }
    cgi.close();
}

mixin GenericMain!myHTTPServer;
``` 

Get `cgi.d` documentation [here](https://arsd-official.dpldocs.info/arsd.cgi.html).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).
**Alternatives:** 
  - [vibe.d](https://vibed.org/)
  - [serverino](https://code.dlang.org/packages/serverino)
  - [archttp](https://code.dlang.org/packages/archttp)
  