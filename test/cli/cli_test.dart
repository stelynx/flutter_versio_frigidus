import 'package:args/args.dart';
import 'package:flutter_versio_frigidus/cli/cli.dart';
import 'package:flutter_versio_frigidus/cli/cli_opts.dart';
import 'package:test/test.dart';

void main() {
  group('parseCliArguments', () {
    test(
      'should have --freeze, --freeze-revision, and --restore arguments',
      () {
        final ArgResults argResults = Cli.parseCliArguments([]);

        final List<String> options = argResults.options.toList();
        expect(options, contains(CliOpts.freeze));
        expect(options, contains(CliOpts.freezeRevision));
        expect(options, contains(CliOpts.restore));
      },
    );

    test('should correctly parse --freeze', () {
      final ArgResults argResults = Cli.parseCliArguments(['fvf', '--freeze']);

      expect(argResults[CliOpts.freeze], isTrue);
      expect(argResults[CliOpts.freezeRevision], isFalse);
      expect(argResults[CliOpts.restore], isFalse);
    });

    test('should correctly parse --freeze-revision', () {
      final ArgResults argResults =
          Cli.parseCliArguments(['fvf', '--freeze-revision']);

      expect(argResults[CliOpts.freeze], isFalse);
      expect(argResults[CliOpts.freezeRevision], isTrue);
      expect(argResults[CliOpts.restore], isFalse);
    });

    test('should correctly parse --restore', () {
      final ArgResults argResults = Cli.parseCliArguments(['fvf', '--restore']);

      expect(argResults[CliOpts.freeze], isFalse);
      expect(argResults[CliOpts.freezeRevision], isFalse);
      expect(argResults[CliOpts.restore], isTrue);
    });
  });

  group('printWelcomeMessage', () {
    test('should print non-empty string to stdout', () {
      expect(Cli.printWelcomeMessage, prints(anything));
    });
  });

  group('showUsage', () {
    test('should print non-empty string to stdout', () {
      expect(Cli.showUsage, prints(contains('Usage')));
      expect(Cli.showUsage, prints(contains('--freeze')));
      expect(Cli.showUsage, prints(contains('--freeze-revision')));
      expect(Cli.showUsage, prints(contains('--restore')));
    });
  });

  group('showDoneMessage', () {
    test('should print thanks string to stdout', () {
      expect(
        Cli.showDoneMessage,
        prints(contains('Thanks for using Flutter Versio Frigidus.')),
      );
    });
  });
}
