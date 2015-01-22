==================================
Getting a method callbacked from C
==================================

Most C callbacks allow to specify a "user data" pointer.
A common trick is to cast `this` into a `void*` pointer back and forth, and use it as user data.

Here is an example with SDL2 logging handler:

```
class MyGame
{
    this()
    {
        // Pass this as user data, since most C callbacks have one.
        SDL_LogSetOutputFunction(&loggingCallbackSDL, cast(void*)this);
    }

    // We'd like this method to get called whenever the SDL callback triggers
    void onMessage(const(char)* message)
    {
        // do stuff
    }
}

extern(C)  // would be extern(System) depending on the library
void loggingCallbackSDL(void* userData, int category, SDL_LogPriority priority, const(char)* message)
{
    // Get back the object reference here
    MyGame game = cast(MyGame)userData;
    game.onMessage(message);
}
```
