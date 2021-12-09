# DIID #1 - Parse a XML file

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
    IAudioSource music = mixer.createSourceFromFile("music.mp3");
    mixer.play(music);    
    writeln("Press ENTER to exit...");
    readln();
    mixerDestroy(mixer);
}
``` 

Obviously you will need a `music.mp3` file in the working directory.