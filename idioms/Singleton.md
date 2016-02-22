
========================
Fast and threadsafe singleton 
========================

taken from this [Talk](http://dconf.org/2013/talks/simcha.html) ( [Youtube Link](https://www.youtube.com/watch?v=yMNMV9JlkcQ)) by David Simcha.

The idea here is that since D has thread local storage variables it is only
necessairy to call the (expensive) synchronized method once per thread.


```
class MySingleton
{
    private this()
    {

    }

    private static bool instantiated_;
    private __gshared MySingleton instance_;

    static MySingleton get()
    {
        if (!instanciated_)
        {
            synchronized (MySingleton.classinfo)
            {
                if (!instance_)
                {
                    instance_ = new MySingleton();
                }
                instantiated_ = true;
            }
            return instance_;
        }
    }

}
```