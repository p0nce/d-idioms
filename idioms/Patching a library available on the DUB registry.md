================================================
Patching a library available on the DUB registry
================================================

How to patch a [DUB](http://code.dlang.org/) library with minimal hassle for users?

  1. Commit your hopefully working fix.
  2. Test it. `dub add-local` or `dub test` can help to do it without hassle.
  3. Make a git tag. **Please try to respect** [SemVer](http://semver.org/) with respect to breaking changes, else you could break an unknown number of already released software. Also don't name your tag `1.0.0` instead of `v1.0.0`, else the registry won't take it.
  4. Push the changes online. I would advise `git push` then `git push --tags` but to be honest I don't really know why it's better in this order. At this point the fix is online. This is not finished yet!
  5. Login on [http://code.dlang.org](http://code.dlang.org) and click on `Trigger manual update` button. This will acknowledge the new version and allow downstream to update to the new tag as soon as possible. **Do not skip this step if you want a timely fix.**
  6. If downstream doesn't actually download the latest tag, consider using `dub clean-caches` to update the list of available packages.
  7. Your users are now delighted. Enjoy the endorphin rush.
