# DIID #7 - GET a file from the Internet

**Solution:** Use the `requests` [package](https://github.com/ikod/dlang-requests).

## `dub.json`

```json
{
    "name": "get-file-internet",
    "dependencies":
    {
        "requests": "~>2.0"
    }
}
```

## `source/main.d`

```d
import std.stdio;
import requests;

void main(string[] args)
{
    auto content = getContent("http://httpbin.org/");
    writeln(content);
}
``` 

Get `requests` documentation [here](https://github.com/ikod/dlang-requests).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).