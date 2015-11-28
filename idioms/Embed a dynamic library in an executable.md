========================================
Embed a dynamic library in an executable
========================================

Let's say we want to distribute a standalone executable that doesn't need any installation.
Here we'll see how to embed SDL.dll into an executable.

```D
import std.uuid;
import std.file;
import std.path;
import std.string;

ubyte[] sdlBytes = cast(ubyte[]) import("SDL2.dll");   // SDL2.dll contents

void main(string[] args)
{
    string uuid = randomUUID().toString();
    string filename = format("SDL2-%s.dll", uuid);     // Making an unique file name.
    string depacked = buildPath(tempDir(), filename);
    
    std.file.write(depacked, sdlBytes);                // Writing the library to a temporary file.
    
    DerelictSDL2.load(depacked);                       // Use the depacked library and load its symbols.
}
```

A similar trick can be used for embedding fonts, images, etc. without having to deal with a resource compiler.

