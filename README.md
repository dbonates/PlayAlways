#PlayAlways CLI
###a Playground creation commandline tool

This apps was inpired on an great tool called [PlayNow](https://github.com/marcboquet/PlayNow) by Marc, which consist of an app that reduces your steps to just one click away to get a Playground up and running. For people like me, heavy user of Playgrounds, it really saves us from this tedious tasks like thinking where we should save them, or even their names!

Using it for a while, I was trapped into the darkness because of just one simple and important detail: It saves the playground on a temporary folder, so, "without warning" I loose a lot of code when restarted my Mac. It happened twice, and made me sad. I know, the readme says something about it, but anyway, I needed something more flexible. So, instead of looking into modify the original source, in Ruby, I've decided to write it using Swift. Then, I opened the terminal and typed:

```
$ mkdir PlayAlways && cd PlayAlways
$ swift package init --type executable

```
Sublimed into it, and coded the first version as a commandline tool, with some cool options:

- `./PlayAlways` creates and open a Playground on current dir
- `./PlayAlways -mac [playground_name] [destination]` creates and open a Playground on current dir using given information. Worths mention that `-mac` option will generate a Playground for Mac. The others should be obvious.

## Requirements

Of course, Swift must be present on the system, either from Xcode instalation or via Swift packages from [Swift.org](Swift.org).

## Installation

Just clone this repo. Since it is just a simple app, no dependecies needed.

then inside project dir:

- `swift build` will generate a **debug** version in _.build/debug/PlayAlways_
- `wift build -c release` will generate a **release** version in _.build/release/PlayAlways_

## How to use it?

both of them can be executed using:

- `./.build/debug/PlayAlways` or
- `./.build/release/PlayAlways`

copying the executable to `/usr/bin` will make it available everywhere, always detecting current dir from where is being called. No worries :wink:

## The future

**The future has come too fast!** While I was writing this README.md, a friend called [@insidegui](https://github.com/insidegui) just boosted this idea to a real and elegant Mac app, which resides on top bar, with handy shortcuts! Check it out:

[PlayAlways App](https://github.com/insidegui/PlayAlways)

![PlayAlways](https://github.com/insidegui/PlayAlways/raw/master/screenshot.png)

Thanks [@insidegui](https://github.com/insidegui), glad to see it :wink:


