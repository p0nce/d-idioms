========================================
Is a specific program available in PATH?
========================================

This functions checks the `PATH` environment variable, looking for a specific program.


```
// Similar to unix tool "which", that shows the full path of an executable
string which(string executableName)
{
    import std.process: environment;
    import std.path: pathSeparator, buildPath;
    import std.file: exists;
    import std.algorithm: splitter;

    // pathSeparator: Windows uses ";" separator, POSIX uses ":"
    foreach (dir; splitter(environment["PATH"], pathSeparator))
    {
        auto path = buildPath(dir, executableName);
        if (exists(path))
            return path;
    }
    throw Exception("Couldn't find " ~ executableName);
}
```

If the command isn't available, this function will throw an `Exception`.


```
which("wget").writeln; // output: /usr/bin/wget
```


