# Dconf subjective report Day 1 (01/08/2022):

_It is my 3rd DConf, a cherished part of the year._

_But right now I'm in a pretty bad mood. Slept only 3 hours after a day in transport. Airplane ticket reseller apparently scammed me and I was 
denied the flight, had to get to London in Eurostar. All this trip is already more expensive than I wish it was._

_DConf location is super nice with good food like always. Food is a huge reason to come to DConf. Air conditionning is efficient, it's much colder than in southern France but it turns out you can put your Dconf tshirt as an additional layer against the cold._



_Speaking to Weka:_
- _Weka is recruiting, if you want to work on a very fast distributed, compressed file-system. Big meta-programming users, R&D is expanding, new protocols to implement, not just maintenance at all from what I gather._
- _apparently they all know this very website `d-idioms`, to them I'm the `d-idioms` guy and they suggest I write their own tip. I say to contribute their tips._



## Walter's talk:
- says template syntax being able to make literal is emergent (the eponymous template thing), 
  so no use for language support
- D had binary and octal literals, removed in favor of template literals
- present again his small buffer stack optimization, this time with a delegate to avoid alloca
  * 2 liner instead of 4 without the delegate, interesting. I could certainly use it.
  * Walter prefers to encapsulate the logic that way
- Walter can concatenates strings with lazy ranges voldemort instead of appending.
  * example of concatenating literals in a single allocation
  * std.path uses that to allocate less memory
- praise invalid values (like NaN or empty string) as alternative to exceptions and error codes
  * example of poisonned values (error nodes) in DMDFE
- bad Unicode data should be replaced by replacement char, not halt everything.
  * so a bit of a Markdown situation
  * if I'm being precise, this reasoning applies to Unicode that will be displayed only 
    (eg: file name => doesn't work)
- Guard bit vs Sticky bit vs Hidden bit in float implementation: it's complicated and noone 
  explains that.
  * encourages Max for the 80-bit "easy" topic (I tried it and recoiled in horror)
- the tired old CTFE array initialization
- example of bitfield generation mixin
- emergent features of ImportC
  - `__import`
  - ImportC can use templates D function as long as the type parameters are implicit
  - also overloading


>Personal takeaway: a talk that I found a bit lacking in new stuff, would have loved to hear more 
about the mentionned floating-point details, or to expand on the Unicode case._

_Speaking to Manu: he was trapped in Australia during COVID, and created an Autralian ISP. An endeavour that is made extra difficult by the upside-down nature of Australia._

## John Colvin's talk:
 - also works for Symmetry now, Jan too. I'm literally surrounded by people that actually 
   want to make money.
 - John says to make your code easy to change rather than predict the future (mostly "YAGNI")
 - small > decoupled and composable
 - we should be afraid of code, but not of changing code
   * but that's not free
   * easiest to do that is keep code small
   * not easy either, since we again want to predict the future
 - be "adaptable", prepare for anything by being able to change, rather than
   being "flexible" and predict the future
 - more D praise. It turns out D is good.
 - uses template to reduce coupling between different parts of the files
   * do not overdo it, because it's clever
 - D culture being "isolated" because people barely communicate so you get a defensive style,
   not breaking people code, exagerated decoupling, few reports. Versus product companies that 
   have more cohesive codebase and downstream provides feedback => hence monorepos.
   I don't think that's new, product companies have monorepos because of the higher control on 
   the end result. If I'm being extra snarky, "all the code can be modified by me" may lead to
   ill-defined interfaces, and even in my solo biz I need superbly defined interfaces.
   To me, small interfaces (that exist) is the one thing that leads to easy-to-change code.
   I think it rejoin the "framework" problematic when you want a consistent codebase and in the end
   have to maintain everything, not just bolt different libraries together.
   Within a big company, codebase must be a framework / easy to learn.
 - Symmetry is recruiting.
 - fun question: "how do you stop your team to create more repositery?"
   * I don't understand the answer. Everyone speaking better english than me.
 - Phobos and druntime should be one repo
 - monorepos, according to audience, reduce the cost of breaking an interface
   * hence making it more likely to refactor
   * hence easier-to-change

> Personal takeaway: A talk with opinions and even metaphors, that I enjoyed. It's like 
                   using D for a sufficiently long time leads people to think like that, because 
                   I mostly share equivalent feelings about things.

## Mathis's talk: (aka FeepingCreature)
 - works at Funkwerk
 - code at funkwerk uses purity, called "domain-driven design"
 - Unqual on a immutable struct only lifts immutable on the aggregate, leading to an unnamed type
   in the compiler, with immutable fields
 - breaking immutable in normal dlang
 - introduce Rebindable!T, a boxed T type that is a rebindable immutable(T)
 - stored data is mutable with a DeepUnqual, so it doesn't break the type system
 - you cannot observe the value changing
 - some restrictions in copy ctor and stuff, but mostly works
 - used by Funkwerk to have a better Nullable!T
 - nice align(T.sizeof) pattern for the wrapper type
 - Mathis says that rvalue are even stricter than immutable

> Personal takeaway: Super cool talk a bit hard to follow, sleep would help.
                    It's reassuring that there are way to bend immutable and don't break the type
                    system. People seemed to realy like that talk.

_Speaking to more Symmetry people at lunch. They came in great numbers, perhaps 25.
   I need to speak more about `gamut`._

## Ali's talk:
  - D is pragmatic, refactorable, fun, sane, emergent, moldable, etc. let's get this out of the way
  - explain the iota signatures in great details, including is(typeof(stuff))
  - show std.parallel and notably, explains how it works in great detail
  - Note: there is threadsafe single-init function in std.concurrency named initOnce!T
  - shows a full range chain that support random access by DbI, super cool slide
    * actual DbI example with forwarding of being random-access
  - Walter: people weren't supposed to use `__traits` directly but `std.traits`

> Personal takeaway: This accessible talk is useful to point people that have trouble with Phobos 
  signatures. I particularly liked the `.parallel` deep explanation.

## Mathias Lang's talk:
  - Go didn't go so well at BPFK
  - BPFK D usage began as Mathias skunkworks
  - D C++ interop supports a lot (two ways exceptions for example, classes, structs, v-table...)
  - "It is D code: follow D rules"
  - helpful tips for actually binding to C++
  - recommends not attempting to bind to lifetime things, such as ctor, dtor, move ctor, copy ctor
  - introduce ways to test that layout, size of types match between D and C++
  - more advice: instantiate C++ templates explicitely, so that the linker get the definitions
  - Manu contributed a lot to that. The speaker thank me but I don't remember doing anything in
    that direction.
  - core.stdcpp will be separated from druntime, to not tie with a specific C++ runtime
  - apparently this is coming to a D compiler near you
  - you can convert C++ to D using that, gradually
  - they avoid some extern(C++) bugs by avoiding DMD, perhaps fixed nowadays
  - Walter asks for Mathias to also rewrite the 15yo documentation on the site, this video now
    being the best reference

> Personal takeaway: A talk about a relatively niche, but important, part of D.  
                   If you plan to use C++ interop, you need to watch this talk. Audience is happy.
                   I'm beginning to feel a bit tired with the D praise today.

## Vijay Nayar's talk:
  - microservices can be synchronous or asynchronous
  - microservices can be implemented in anything, differet codebases (not mandatory), handle 
    failure more reliably, can be built by different teams, forces a clear interface to exist
    => so, a division of work advantage
  - container orchestration like Kubernetes, AWS ECS, OpenShift exist to increase performance of
    microservices
  - because of huge cost, system-level languages have a place in the microservices space
    * a lot of company there are first-to-market, and think about cost later
    * native language best at speed, as we know
  - vibe.d beats a simple Java HTTP server with 2x the throughput, 5% te memory usage, etc.
  - more D praise
  - want more D libraries: database ORMs, rule engines, AWS SQS, SNS, Apacha Kafka, Security 
    (eg: Vault)
  - wants a visual memory debugger
  - -profile=gc agreed to be useful
  - -profile though doesn't work well enough
  - tips for porting to D.
  - Vojay creates a high-performance car hailing system in D (for eg. taxi cab)
  - "using D, small teams can match the productivity of bigger organizations"
    interesting devops tidbits for those of use that don't understand that domain

>Personal takeaway: My favourite talk of the day. Because I learned tons of thing about a
                   particular domain I know nothing about.
                   A real-worldey talk.

## Q & A sessions:
  - people of D should write more blogs.
  - was too tired to write about things.


# Dconf subjective report Day 2 (02/08/2022):


_I finally slept a while 5h so I'm well rested. You can get a bit more sleep if you skip the 
breakfast. Couldn't go to BeerConf the day before. London tube is superb._


_Breakfast with Eyal from Weka is building. I show him Markov things and think the visual markov
description language are maybe easy for children to grasp. Weka doesn't use Image so no `gamut`
 requirements there. He's working on a half-text, half-visual multilingual language inspired by 
D and Haskell.
He has a D "at large" tip for d-idioms which is to run unittests at CTFE to avoid link times(!) 
save lots of time with that tip._



## Robert Ierusalimschy talk (Lua & Pallene)

- Lua is a mature language with lots of small details.
- Pallene is a restricted, system language.
- Lua (10k SLOC) runs almost eveverywhere since based on ANSI C.
  * they are very concerned by smallness of Lua and total complexity.
- everything is a table in lua: modules, records, arrays, objects...
- lots of closures in Lua, for example modules are tables of anonymous functions.
- exceptions are done with _protected calls_, a special way to call a function: `pcall`.
- problems they are having: rewriting slow parts in C is not always easy for Lua users.
- **Pallene** has gradual typing. Goal = act on Lua types directly, be faster.
- Design goal: translating a Lua function to Pallene should not worsen the performance.
    - they even check this with performance graphs that change one function only
- Pallene syntax is roughly Lua with types.
- performance numbers: often same as LuaJIT, 2x to 4 slower than C (instead of much slower in Lua 
  case)
- better to just give the type than to have a JIT. JIT must deoptimize when wrong types are given, 
  super complex.
- Lua is portable C and following all the constraints is incredibly hard
- LuaJIT is very good but a lot more complex than Pallene
- allows unboxing things
- question about 1-based arrays "there are 2 kinds of languages: 1 = languages that index from one". 
  Basing arrays on 1 was more natural for non-programmers. Also FORTRAN, etc. Nobody asked at these
  times.
- The Pallene and Lua compiler are separate, so I guess you pay double the code size.
- the audience remark that Pallene often beat LuaJIT and asks why. Well we won't know.
  * apparently Lua can't use NaN tagging, but LuaJIT can

> Personal takeaway: You can see how Robert exudes simplicity and makes things seem easy when they 
are not. A very topdown talk, helpful lesson for the sometimes detail-oriented D community.


_Speaking with Funkwerk, thanks for the BeerConf! At least 3 of them here._


## Roy's talk

- live-demo of good cache matrix sum, and bad cache matrix sum
- `volatileLoad` can act as optimization barrier
- full sequential consistency is slow than more relaxed modes
- nice explanations of different memory models of atomics
- live-demo of super rare races
- live-demo of an arm-only race, since its memory-model is less strong than acquire-release and x86
  memory model is stronger
- "things before the release happened before the acquire
- any time you deviante from sequential consistency, you are asking for problems
- Roy works on verifying program under weak memory models, a good presenter
- `Rocker`, a tool to check semantics of your atomics program
  * can check Peterson algorithm implementation and break them in one second
  * found bugs in all of them
  * much easier to find race

- https://github.com/rymrg/rocker

> Personal takeaway: Always interesting to learn more about atomics, _especially_ from a memory 
model expert. In these times of ARM64-only bugs, it is always good to know. I love the more complex
 talks, so all positives. Rocker builds on first try. Cool.


## Sebastiaan's talk (Tip: watch this)

- concurrency bugs harder to track down, and hidden a long time, waiting to pop up
- in D, most concurrent API has unclear lifetime, unstructured, lacks cancellation, all have no 
  error handling, and not composable. Similar to unstructured _programming_ of old, in a way.
- the Structured Program Theorem states that 3 composable base statement can build any computable 
  function.
- makes a giant analogy with presumably the content of the talk being like structured programming 
  vs unstructured programming
- at the times it wasn't generally admitted than all programs could be stuctured!
- design goals of Structured Concurrency: propagates errors, allow cancellation (else not 
  composable), all async computations have an owner.
- design: inspired by a C++ proposal:
  - senders, a UFCS voldemort lazy chain thing
- if you wait for both A and B, and A has an error, then you need to _cancel_ B, so cancellation 
  belongs to this monadic contraption => avoid leaky tasks
  * end indeed in Dplug, tasks are just not allowed to fail...
- likes shared, DIP 1000, and @safe, wants more of it!
- question: TLS defeats moving things across threads
- `shared` not creating problems, according to Sebastiaan. Want to use the keyword.

> Personal takeaway: **Futuristic talk, absolute must-see.** Even the type of D used is new and 
  interesting. This is like the talk "std::allocator is to allocation what std::vector is to 
  vexation" except this time with concurrency. Library is here: 
  https://github.com/symmetryinvestments/concurrency


## Mike Shah's talk

- a raytracer can be done in 24 hours.
- you can actually use the math you were taught.
- didn't really followed, since I implemented toy raytracers a few times. Important emails to answer
  to instead.

> Personal takeaway: I should probably read the PBRT book that was so expensive, it is collecting dust on the shelf.


## Dennis Korpel's talk

- he made plenty with D after discovering it
- is it better to have a Big Language or mixed language? Big Language
- I already knew it, but Dennis is a super strong programmer and way younger than I expected
- live-demo of a hacked Super Mario 64 rom that says "D ROCKS", LDC generating the MIPS assembly
- lots of other stuff

> Personal takeaway: Yeah, D is good you can do it all with it.

## Max's talk
- performance is mostly about memory
- specific d-cache and i-cache optimization advices
- memory bandwidth has gone up but memory latency is terrible

> Personal takeaway: Good reminder that the best optimizations are often about memory bandwidth and
 layout. To this day I still remember the boss coming to my desk and congratulating me for a 11% 
 speed-up that only involved memory layout and rearranging things in a single allocation instead of plenty.
 I got a giant pat on the back that day. It was very satisfying as an employee. 
 The Man wanted more such optimizations like that, but there were none I could think of.


## Language design panel

- What a language you really admire but doesn't work on:
  * Scheme, CL, Haskell, Forth gets a mention. Walter prefers PDP Assembly :)

- Are dependent types overhyped?
  * Atila doesn't think it will be widespread.

- Roberto think memory-safety is not considered super crucial by people

- Roberto thinks economics of software quality are pareto-like, and most kind of software must be 
kept in cost, reasonable, not too high-quality. Cost is very low for bad software. Hasn't change
for years. 

- Walter think C ABI will survive and nothing will be implemented in C in the future.
- Walter: GC lets you get it done
- Robert would add desctructuring pattern-patching in Lua if that was possible, but no types
- macros = inevitable doom discourse
- more first class features that comes from annotations? (like unittest). Walter wants examples.
  * I was thinking first class TODO, FIXME, BUG HERE, made first class copyright and the compiler 
    would check that
- Atila: most people that can't afford a GC actually can.
- question: what current best practice are worse practice?
- panel agrees that code using single assignment is easier
- Walter: a lot of the principles are contradictory
- Walter: macro rant, airplane analogies
- Atile: we will find a way [to use macros anyway] 
- everyone pretends not to know Haxe
- Walter really tried to reduce complexity but it's hard
- Roberto sometimes had to sacrifice simplicity
  * first Lua version linearly searched all its members
- Roberto: "I don't think I could change Coq for D"
- Roberto: speaks about his C experience, strange realloc tricky to avoid 
  _I need to check that one later_

> None of the language designer here had a life plan to become language designers. Life just 
happens. Day 2 was super interesting.

_BeerConf happens. I have to explain in great details why I don't like `@safe`, I didn't 
realized before having to explain. Met a HDL Danish engineer doing rightful D._

# Dconf subjective report Day 3 (03/08/2022):

_Some guy came to the conference breakfast but doesn't know D. Works in C++ finance._

## Atila's talk
- Future of D: compilation deamon, more inference
- Proposes to increase rate of adoption of -preview (I agree, as they accumulate)
- enumerates all the DIP
- not sure why community says `shared` is unfinished, and people should use libraries that uses it,
  like `concurrency`. `shared` is just a building block, and an OK one, as stated by Sebastiaan in 
  his talk. 
- wants structured concurrency in Phobos, DIP 1000 is important
- because noone is using `fearless`, inspired by Rust `std::sync::Mutex`
- Phobos won't be on DUB, but some parts maybe?
- move std.experimental.typecons to `std.typecons`
- `std.experimental.logger` is now `std.logger`
- `std.experimental.allocator` causing lots of questions. In particular, they haven't scoped.
Focus should be on high-level API, so that people don't need to care about `malloc`/`free`.
- noone use manual MM in C++ so we shouldn't tell people to use `malloc`/`free`.
- noone works on Phobos v2 (remove auto-decoding) and Atila needs to take ownership of this. 
  Remove support for 3 different types of strings.
- dlang "Editions"? Considering the question. Atila think of this positively.
- Goals: quality, then expand, focus on high-level usage, help needed foxing bugs.

> Personal takeaway: There is a nice continuity from Andrei's talk in 2018 and this one. I'm happy 
the problems in allocators are recognized because frankly they are impossible to use without a 
runtime. I think there is a problem with template-fu that are supposed to be best at something but Direction is clear and well communicated. In Atila's talk there is an implicit admission 
that there will be a separation between library writers and regular D users, and that we don't need
 to fix everything, and I like that development. I loudly complain about TLS for apparently no 
 reason. No talk about WebASM, to my regret. But, structured concurrency from earlier may enter 
 Phobos, and this would be presumably a good thing. Generally I think the leadership style of Atila is more discreet versus the Adnrei style, but I end up agreeing with the decisions more.


## Adela Vais's talk
- Bison modified to output D
- LALR(1) vs GLR parser in input code
- interstingly, Adela implemented a push parser
- show some Bison parser code,
- says M4 code that is indeed challenging
- scope had to be reduced for that SAoC

> Personal takeaway: I wonder if IDEs use push parsers more. And indeed that's what Adela says, in 
UI you'd want to prefer push parsers. I remember that in video processing that distinction was a 
big one. I'm not myself a parser expert so the talk went a bit over my head. People are really 
sharp at Dconf as always.

_I try to submit my checked TODO proposal to Walter, who doesn't seem interested. "Just use grep 
in your Makefile". I'm not using either. I could use a UDA and make a DUB package 
to highlight the point, because what's the thing you grep in your code most often? I think 
mechanically checked TODO annotations has a lot of unrealized value!_


## Lucian Danescu 
- Worked on DMD as a library

> Personal takeaway: I'm not really a D tooling person, more a library writer / industry "dumb D" 
proponent. So DMD internals are really remote to me.


_Had greatest fun at lunch talking to people._


## Lightning talks!

My favourite DConf feature is finally there!
I wish there was more lightning talks.

### Snazzy D Compiler
- an unexpected development in the D world
- SDC lexer is reusable for other language (!), sounds interesting
- development seems to be ongoing again
- needs to be more advanced for Phobos, for now = formatter
- its architecture learned from DMDFE

### How to call C# from D
- .NET DLL are not normal .DLL (static vs dynamic)
- use RGieseck's package to call C# from D (dynamic DLL)
- or use static DLL
- or Derelict + MONO
- describes how to properly marshal things for C#
- looks like JNI very much to me

### Dennis
- Shows a program with only return everywhere
- "that's what DIP1000 does on your brain"

### DUB improvements
- colors, dub select, recursive dub upgrade, performance improvements
- plenty of good stuff
- git dependencies
- use `dub upgrade -s` all the time (was not made default after discussion)

### D Charts
- hilarious chartist view of D number of PRs over time

### Feep 
- showcase of strange behaviour of programs
- talk is too fast for le to understand

### Eyal presents lamdu (!)
- lamdu language, combined IDE + langage
- cool IDE with dyamic code layout, colors, code completion, always-correct AST
  * REPL-like
- language is haskell-like
- actually seems futuristic 
- can translate both keywords and identifiers in one click, demo of switch to right-to-left hebrew code
- written in Haskell + OpenGL
- apparently there is a whole field of "structural/projectional code editors"
- sounds more "organic" than using a normal IDE.

### Caching range elements
- 10M elements appended in a slice => 23 realloc, interesting data point
- input range that buffers when you read front() on an empty range


### Some EDA mini-talk
- described EDA open-source tooling in D they have been doing
- I got the story somehow at BeerConf but this had more technical detail
- their website tagion.org is cool to look at


## Templated hooks in Druntime
- the ongoing project of reducing getting druntime to be more like headers
- do template reduce code size?
- advantage: can help -betterC keep features
- also, some typeinfo lookup is recursive
- also, druntime hooks have the wrong attributes
- also, such lowering happening in the frontend will be is easier
- also, want to reduce realying on TypeInfo. So many upsides!
- now, how much will the compilation time increase?
- already 2 SAoC students attacked that story
- all the changes have to be completely transparent to the users
- so: 4 of the 38 hooks converted already, added 9 more. Ongoing project.
- lowering must preserve number of evaluations, which is tricky.
- benchmarks: array creation benefit, array append only slightly (3 to 5% faster though)
- compile time increase looks quite bad in the numbers... 
- for some hooks => not really beneficial
- find threshold for instantiations count?
- lowerings for immutable as-seen are problematic, says type people
- John Colvin propose to use more type-punning to reduce the instantiations
- this topic is kinda cursed, but necessary

> Personal takeaway: Industry people like me freaking out about instantiations, but I'm sure it's going to be okay.

## Robert's talk (moving from Bugzilla to Phobos)
- a bit of a Phobos gems
- project to move from Bugzilla to Phobos is boring, because Phobos itself is awesome
- 5 traits in std.traits are the most used ones
- std.json works for 99% of use cases,  it's nice
- likes `enforce`
- shows rare `format` features, for example you can format whole arrays with separators
  * `std.format` is an interesting read
- `canFind`
- is for GC for everyone and auto-decoding

> Personal takeaway: Pretty cool. My Phobos-fu has always been a been rusty, compared to what exist in Phobos. I'm not alone, many people avoid the learning of Phobos apparently. I like the talks on the unknown basics.


## Mike's talk

- a helpful reminder of everything that happened before in D
- in early days, everyone was a contributor
- community is everything
- emphasize how huge Kenta Cho was for the D adoption
- announces a community management thing
- we need more contributors to be able to have people that we don't expect to contribute
- wants the ecosystem back and orderly

> Personal takeaway: Mike is the man. Wouldn't be in D without him (and Kenta Cho). Cause he wrote dependable Derelict.

**Conclusion:**
D usage seems slightly augmenting, but contributors are dearly needed.
I'd much prefer if there were 30 corporate sponsors, not 3 sponsors.
3 days of interesting talks and high-intensity thinking takes a toll on me, along with short sleep, and I decide to skip the Hackathon day and go visit London.