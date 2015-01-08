===================================
Smallest dub.json for an executable
===================================

What DUB options are strictly necessary in a `dub.json` file to build an executable?


It turns out only one is necessary:

    {
        "name": "program_name"
    }

Place the source code in a `source/main.d` file and DUB will find it and guess
you want to build an executable.
