========================================
Embed a dynamic library in an executable
========================================

Let's say we want to distribute a stand-alone executable that doesn't need any installation.
Here we'll see how to embed SDL.dll into an executable.

    import std.uuid;
    import std.file;
    import std.path;
    import std.string;
    ubyte[] sdlBytes = cast(ubyte[]) import("SDL2.dll");                  // SDL2.dll contents
    void main(string[] args)
    {
        auto uuid = randomUUID();
        string filename = format("SDL2-%s.dll", randomUUID().toString()); // Making an unique file name.
        string depacked = buildPath(tempDir(), filename);
        std.file.write(depacked, sdlBytes);                               // Writing the dynlib to a temporary file.
        DerelictSDL2.load(depacked);                                      // Use the depacked dynlib and load its symbols.
    }

A similar trick can be done for embedding fonts, images, etc... without ever dealing with a resource compiler.
