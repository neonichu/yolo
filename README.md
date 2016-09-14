# YOLO

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

Swift library and CLI for generating an application bundle for an executable and running
it in the iOS simulator.

## Usage

You can run an executable in the simulator:

```bash
$ ./.build/debug/yolo run myExecutable
```

YOLO will create a temporary application bundle for you automatically and run it in the
simulator. Please make sure that the given executable was compiled for the iOS simulator.

:warning: When using this, keep in mind that there is a lot of truth behind the name - it is
an extreme simplification of building application bundles and only supports a small set of
features.

## Installation

Since `simctl` is broken, we will need to interface with a third-party simulator tool. For
now, `sim` out of [RubyMotion][2] was chosen, as it appears to be the most reliable and
stable of them. Please make sure you have that installed.

YOLO requires Swift 2.2, as it uses the [Swift Package Manager][1]. You can compile
it by just running:

```bash
$ make
```

By default, the CLI tool will be located in `.build/debug/yolo`.

[1]: https://swift.org/package-manager/
[2]: http://www.rubymotion.com
