Compile-time RNG
================

In January 2016, an anonymous programmer [posted on the D forums](http://forum.dlang.org/post/suswwamqwdszocvkvjbc@forum.dlang.org) a Proof-of-Concept for a devious compile-time Random Number Generator.

```
/+ CTRNG
    Proof-Of-Concept Compile-Time Random Number Generator.
    Please never actually use this or anything like it.

    While doing some metaprogramming tomfoolery, I stumbled into an
    interesting scenario. It occurred to me that with some work, I could
    probably turn what I had into a functioning compile-time random
    number generator, despite D's restrictions on metaprogramming intended
    to keep things deterministic. Some of this may be obvious to you,
    some of it may be interesting. Whether or not any of this is a bug, I do
    not know. It probably isn't useful unless trying to sabotage a codebase.

    Note: This is specifically developed with minimal dependence on other
    modules (even standard ones), so some things are implemented in
    non-idiomatic (read: strange) ways.
+/

/+
    Step 1
    We need something useable as a seed. Luckily, D has __TIMESTAMP__, which
    reports time of build as a string in roughly the following format:

        Wed Jan 20 18:04:41 2016

    Specific contents of this function don't matter. All that matters is
    timestamp goes in, largish unsigned integers come out. Feel free to skip
    the implementation, it is not important. All that matters is that with
    this, we will be able to get a psuedo-random seed at compile-time.
    We *could* parse the timestamp accurately, but the rest of this is
    hackish, so why not make this hackish as well?
+/
ulong timestampToUlong(string stamp)
{
    ulong result;

    foreach_reverse(c; stamp)
    {
        result += c;
        result *= 10;
    }

    return result;
}

/+
    Step 2
    Next, we'll need the ability to track some sort of state. D is designed
    with the intention that compile-time constructs cannot have a useful
    permanent state, so this'll take some doing.

    For starters, we need something we can query that can give different
    results different times we call it (as in, impure). For this, we
    have the following templated enum. It is manifest constant giving
    the number of top-level members in the current module. However,
    this number can change as other templates and mixins are resolved.

    Technically, each instantiation is different, but because the dirty
    details are hidden inside the default parameter value, it can be used
    as if it should always be the same value.
+/
enum counter(size_t x = [__traits(allMembers, mixin(__MODULE__))].length)=x;

/+
    Step 3
    For step 2 to work, we also need the ability to add members in between
    uses of `counter`. These need to be uniquely named, so we will
    need a way to generate names. Step 2 already gave us a source of
    increasing numbers, so we can trivially generate names based on
    the value of `counter`. So, we define a method to yeild a string
    containing a new unique declaration that we can `mixin()`.
+/
char[] member(ulong x)
{
    char[] buf = "void[0] _X0000000000000000;".dup;
    enum mapping = "0123456789abcdef";
    foreach_reverse(i; buf.length-17 .. buf.length-1)
    {
        buf[i] = mapping[x & 0xf];
        x >>= 4;
    }
    return buf;
}

/+
    Step 4
    This is just a simple wrapper combining `member` and `counter` under
    a single name, making it slightly easier to increment the counter.
+/
mixin template next()
{
    mixin(member(counter!()));
}

/+
    Step 5
    Finally, we define a simple XorShift64* RNG. We don't really
    have arbitrary mutable state (yet?), so this depends on the D
    compiler caching previous template instantiations.
    The first is a specialization introducing our seed.
    The second is how all subsequent xorShift instantiations are
    handled, again taking advantage of changing default parameters.
+/
template xorShift(size_t x = counter!())
{
    static if(x == 0)
    {
        enum xorShift = timestampToUlong(__TIMESTAMP__);
    }
    else
    {
        // Name previous result to reduce syntax noise.
        enum y = xorShift!(x-1);
        enum xorShift = 0x2545_f491_4f6c_dd1dUL
            * (((y ^ (y >> 12)) ^ ((y ^ (y >> 12)) << 25))
            ^ (((y ^ (y >> 12)) ^ ((y ^ (y >> 12)) << 25)) >> 27));
    }
}

/+
    Now, let's use it!
+/
// Two instantiantions of xorShift result in the same value
static assert(xorShift!() == xorShift!());

// However, we can save one value,
enum a = xorShift!();

// ... update the counter,
mixin next;

// ... and save another value,
enum b = xorShift!();

// ... and they will not be the same.
static assert(a != b);

/+ What's more, because we have a time based seed, they will
all be different every time you compile this code. +/
pragma(msg, a);
pragma(msg, b);

mixin next;

mixin template headsOrTails(size_t x)
{
    static if(x % 2 == 0)
    {
        pragma(msg, "Heads!");
    }
    else
    {
        pragma(msg, "Tails!");
    }
}

mixin headsOrTails!(xorShift!());

/+
    Conclusion
    This is a really simple proof of concept. A "better" version
    could use a recursively scanning counter implementation that
    looked for symbols tagged with a certain User-Defined attribute
    to allow advancing the RNG state inside structs and such.
    More complicated RNGs could be implemented in a similar way.
    There may be value in mixing in template specializations.

    But then again, all this code is evil and I won't be doing
    anything more with it.
+/
void main()
{
    // Don't do anything at runtime. Just make dpaste's linker happy.
}
```

[See source code on DPaste...](http://dpaste.dzfl.pl/668646ce6d71).