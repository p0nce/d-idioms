Unrecoverable vs recoverable errors
===================================

_This item is language-agnostic and perhaps the most widely applicable tip on this page._

## Simply said

Being a D programmer requires knowing the **two fundamental types of errors** in programs.


Similarly to many languages with exceptions, errors are separated in **logic errors** and **runtime errors**. This is embodied in the two-headed exception hierarchy:

- the `Error` class is for _logic errors_ also known as _unrecoverable errors_ also known as&hellip; _bugs_
- the `Exception` class is for _runtime errors_ also known as _recoverable errors_ also known as _input errors_. But it can also be used for hard-to-classify errors.

## Unrecoverable/logic errors

Such errors are basically **bugs**. Logic errors includes but are not limited to:

- divide by zero
- out-of-bounds access
- null dereferences
- invalid floating point operations like `log(-1)` or `arccos(2)`
- out of memory
- failed contract

The recommended way to deal with these is to throw an `Error`, for example by using `assert`. Indeed **the only reasonable option when encountering a logic error is to crash.** This is how highly reliable system are built: let the OS handle the program crash, let a supervisor restart the faulty process.

If you think you should recover from bugs and keep things running anyway, **you are dangerous**.

## Recoverable/input errors

Such errors are basically **not bugs**:

- all kinds of errors with invalid input
- all kinds of I/O failure (eg: failure to read a file)
- failed API calls

The canonical way to deal with these is to throw an `Exception`, for example by using [`enforce`](#Phobos-gems).

Some errors are difficult to classify: what is unrecoverable for a program part might well be recoverable for another. In this case it is recommended to use `Exception`.

## More material

Walter Bright repeatedly explained this item in the D newsgroup:

_I believe this is a misunderstanding of what exceptions are for. "File not found" exceptions, and other errors detected in inputs, are routine and routinely recoverable._

_This discussion has come up repeatedly in the last 30 years. It's root is always the same - conflating handling of input errors, and handling of bugs in the logic of the program._

_The two are COMPLETELY different and dealing with them follow completely different philosophies, goals, and strategies._

_Input errors are not bugs, and vice versa. There is no overlap._

See also: [http://forum.dlang.org/post/m07gf1$18jl$1@digitalmars.com](http://forum.dlang.org/post/m07gf1$18jl$1@digitalmars.com)
