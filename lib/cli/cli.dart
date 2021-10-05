import 'package:args/args.dart';
import 'package:flutter_versio_frigidus/cli/cli_opts.dart';

/// Auxiliary functions for command-line interaction.
abstract class Cli {
  /// Parses command line [args].
  static ArgResults parseCliArguments(List<String> args) {
    final ArgParser parser = ArgParser()
      ..addFlag(CliOpts.freeze)
      ..addFlag(CliOpts.freezeRevision)
      ..addFlag(CliOpts.restore);

    return parser.parse(args);
  }

  /// Prints welcome message.
  static void printWelcomeMessage() {
    print('=========================================================');
    print('  Welcome to Flutter Versio Frigidus, a simple Flutter');
    print('  version manager that allows you to have a specific');
    print('  Flutter version for each of your projects! By Stelynx');
    print('=========================================================');
    print('');
  }

  /// Prints help to the command line.
  static void showUsage() {
    printWelcomeMessage();
    print('Usage:');
    print('\t--freeze\t\tSave current Flutter version');
    print('\t--freeze-revision\tSave current Flutter revision');
    print('\t--restore\t\tCheckout freezed Flutter version / revision');
    print('');
    print(
        'Open-source software costs valuable time not spent with family and friends. Consider supporting Stelynx developers');
    print('');
    print('=========================================================');
  }

  /// Prints thanks message after successful operation.
  static void showDoneMessage() {
    print('Thanks for using Flutter Versio Frigidus.\n');
  }
}
