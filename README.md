# Flutter Versio Frigidus

_Did you ever continue to work on an old Flutter project that just did not work
with the newer Flutter version? Did you struggle to find that one correct version
where all the framework classes and functions actually worked and nothing was broken?
If so, then read on! If not, you might still be convinced to use this tool._

_Flutter Versio Frigidus (latin for Flutter Version Freeze) helps developers working on multiple Flutter projects that
were created using different Flutter versions to easily switch between Flutter
versions based on their projects._ 🥳

[![Pub Version](https://img.shields.io/pub/v/flutter_versio_frigidus?color=%233dc6fd&logo=flutter&logoColor=%233dc6fd)](https://pub.dev/packages/flutter_versio_frigidus)
![Lint & Test](https://github.com/stelynx/flutter_versio_frigidus/workflows/Lint%20&%20Test/badge.svg)
[![codecov.io](https://codecov.io/gh/stelynx/flutter_versio_frigidus/branch/master/graphs/badge.svg)](https://codecov.io/gh/stelynx/flutter_versio_frigidus/branch/master)
![GitHub Repo stars](https://img.shields.io/github/stars/stelynx/flutter_versio_frigidus?color=gold&logo=github)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/stelynx/flutter_versio_frigidus)
[![GitHub](https://img.shields.io/github/license/stelynx/flutter_versio_frigidus)](LICENSE)

## Features

There are two main features of Flutter Versio Frigidus. The first one is the
extraction of current Flutter framework version or revision and saving it to the
project root directory. The second one is setting the current Flutter version to
the one needed for given project.

## Getting started

This tool can be installed in two different ways, globally and per project, however
since this tool is meant to be used across projects, we strongly encourage everyone
to install it globally.

### Global installation

Simply run

```shell_script
pub global activate flutter_versio_frigidus
```

and Flutter Versio Frigidus can now be run from anywhere on your machine (however it
only makes sense to run it from project root).

### Per-project installation

Require this package in your application's `pubspec.yaml` in `dev_dependencies` like

```yaml
dev_dependencies:
  flutter_versio_frigidus: ^1.1.0
```

## Usage

Flutter Versio Frigidus exposes two commands that are completely equivalent, one is more verbose
(`flutter_versio_frigidus`) and the shorter version (`fvf`). Running this tool depends on how you
installed it. For global installation, you can simply run

```shell_script
fvf  # or flutter_versio_frigidus
```

and for per-project installation (in this case you have to be in the project root directory, however
you should be there also in the global installation case)

```shell_script
pub run fvf  # or pub run flutter_versio_frigidus
```

### Flags

This tool is always meant to be run with **exactly one flag**. Running the tool without any flags
will print help to the console, listing all available flags.

Available flags are presented in the following table.

<table>
  <tr>
    <th>Flag</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>--freeze</code></td>
    <td>Save current Flutter version</td>
  </tr>
  <tr>
    <td><code>--freeze-revision</code></td>
    <td>Save current Flutter revision</td>
  </tr>
  <tr>
    <td><code>--restore</code></td>
    <td>Checkout freezed Flutter version / revision</td>
  </tr>
</table>

## Contributing

This tool is pretty self-content, although if you have any problems, questions,
further enhancement ideas, please fill free to file an issue or even a pull request.
