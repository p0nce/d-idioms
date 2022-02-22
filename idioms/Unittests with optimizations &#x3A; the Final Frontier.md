================================================
Unittests with optimizations: the Final Frontier
================================================

DUB is an essential piece of the modern D language experience. **However,** that experience doesn't include _"Running unit tests with optimizations"_ by default.

So, how do you avoid surprises in production? What would Kent Beck do?

**In this post, we unleash the jaleously-guarded secret behind the most successful organizations in the world: running unittests with optimizations ON and OFF.** 

## Changes to `dub.json`

Create a new build type with the proper flags. This is also a good way to get to know the discreet `"buildTypes"`.

```
"buildTypes": 
{
    "unittest-opt": 
    {
        "buildOptions": ["unittests", "optimize", "inline"]
    }
}
```

**Because it doesn't have a** `-release` **flag**, [asserts will still be enabled](#So-what-does--release-do,-exactly?). Hence, the `unittest` content is here.

(Please, don't call this configuration `unittest-release`. Because flag `-release` not being there is the one important thing. This increase the confusion between "release" and "optimizations").


## Run both versions

```
$ dub test 
$ dub test -b unittest-opt
```

You are now listed in Forbes.