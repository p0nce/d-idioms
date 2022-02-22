Leveraging TLS for a fast thread-safe singleton
===============================================

In D the declarations you reasonably thought would be globals, are instead put in Thread-Local Storage (TLS) unless marked with `shared` or `__gshared`. Each thread the runtime knows has its own independent copy of TLS things.

```
class A
{
    static int instanceCount = 0; // Caution: one per thread
}

```

## Don't ask what TLS can do for you. Ask what you can do with TLS!

**TLS is useful to avoid locks when accessing global state.**

In this example, we'll show how to leverage TLS to avoid a costly `synchronized` block and still be thread-safe.

```
class FastSingleton
{
private:

    this()
    {
    }

    // TLS flag, each thread has its own
    static bool instantiated_;

    // "True" global
    __gshared FastSingleton instance_;

public:
    static FastSingleton get()
    {
        // Since every thread has its own instantiated_ variable,
        // there is no need for synchronization here.
        if (!instantiated_)
        {
            synchronized (FastSingleton.classinfo)
            {
                if (!instance_)
                {
                    instance_ = new FastSingleton();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

}
```

This singleton implementation was taken from [this talk](https://www.youtube.com/watch?v=yMNMV9JlkcQ) by David Simcha.

If you find any other use for TLS, please send us your discoveries.