=========================
Inheriting from Exception
=========================

When in doubt, do it like Phobos!

    class MyOwnException : Exception
    {
        public
        {
            @safe pure nothrow this(string message,
                                    string file =__FILE__,
                                    size_t line = __LINE__,
                                    Throwable next = null)
            {
                super(message, file, line, next);
            }
        }
    }
