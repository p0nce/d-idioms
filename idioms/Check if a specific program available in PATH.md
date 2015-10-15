=================================
Check if a specific program available in PATH
=================================

Check system `PATH` variable if a specific program (shell command) is available.
```
import std.stdio;
import std.process;   // environment
import std.algorithm; // splitter
import std.file;      // exists
import std.path;      // separator

//analogue of unix tool `which`, that shows full path of commands
string which(string executableName) 
{
    string res = "";
    auto path = environment["PATH"];
	//pathSeparator Windows use ";" separator, POSIX use ":"
    auto dirs = splitter(path, pathSeparator);
    foreach (dir; dirs) 
	{
        auto tmpPath = dir ~ dirSeparator ~ executableName;
        if (exists(tmpPath)) 
		{
            return tmpPath;
        }
    }
    return res;
}

void main(string[] args) 
{
	version(Windows)
	{
		writeln(which("wget.exe")); // output: C:\wget
		writeln(which("non-existent")); // output: 
	}
	version(posix)
	{
		writeln(which("wget")); // output: /usr/bin/wget
		writeln(which("non-existent")); // output: 
	}
}
```
If command not avaliable return null.


