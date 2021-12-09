# DIID #2 - Play music

**Solution:** Use the `game-mixer` package.

## `dub.json`

```d
{
    "name": "play-music",
    "dependencies":
    {
        "game-mixer": "~>1.0"
    }
}
```

## `source/main.d`

```d
import std.stdio;
import gamemixer;

void main(string[] args)
{
    IMixer mixer = mixerCreate();
    // Obviously you will need a `music.mp3` file in the working directory.
    IAudioSource music = mixer.createSourceFromFile("music.mp3");
    mixer.play(music);    
    writeln("Press ENTER to exit...");
    readln();
    mixerDestroy(mixer);
}
``` 

Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).