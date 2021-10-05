import 'dart:io';

import 'package:args/args.dart';

import 'package:flutter_versio_frigidus/cli/cli_opts.dart';

abstract class Cli {
  static ArgResults parseCliArguments(List<String> args) {
    final ArgParser parser = ArgParser()
      ..addFlag(CliOpts.freeze)
      ..addFlag(CliOpts.freezeRevision)
      ..addFlag(CliOpts.restore);

    return parser.parse(args);
  }

  static void printWelcomeMessage() {
    stdout.writeln('=========================================================');
    stdout.writeln('  Welcome to Flutter Versio Frigidus, a simple Flutter');
    stdout.writeln('  version manager that allows you to have a specific');
    stdout.writeln('  Flutter version for each of your projects! By Stelynx');
    stdout.writeln('=========================================================');
    stdout.writeln();
  }

  static void showUsage() {
    printWelcomeMessage();
    stdout.writeln('Usage:');
    stdout.writeln('\t--freeze\t\tSave current Flutter version');
    stdout.writeln('\t--freeze-revision\tSave current Flutter revision');
    stdout
        .writeln('\t--restore\t\tCheckout freezed Flutter version / revision');
    stdout.writeln();
    stdout.writeln(
        'Open-source software costs valuable time not spent with family and friends. Consider supporting Stelynx developers');
    stdout.writeln();
    stdout.writeln('=========================================================');
  }

  static void showDoneMessage() {
    stdout.writeln('Thanks for using Flutter Versio Frigidus.\n');
  }
}
