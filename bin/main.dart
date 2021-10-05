import 'package:flutter_versio_frigidus/flutter_versio_frigidus.dart';

void main(List<String> args) {
  print('');

  final options = Cli.parseCliArguments(args);

  if ((options[CliOpts.freeze] && options[CliOpts.restore]) ||
      (options[CliOpts.freezeRevision] && options[CliOpts.restore]) ||
      (options[CliOpts.freeze] && options[CliOpts.freezeRevision])) {
    print('Freeze or restore? Can\'t do both, pal!');
    return;
  }

  if (!options[CliOpts.freeze] &&
      !options[CliOpts.freezeRevision] &&
      !options[CliOpts.restore]) {
    print('You gotta ask yourself one question, freeze or restore?\n');
    Cli.showUsage();
    return;
  }

  Cli.printWelcomeMessage();

  bool successful = false;
  if (options[CliOpts.freeze]) {
    successful = FvfCore.freeze();
  } else if (options[CliOpts.freezeRevision]) {
    successful = FvfCore.freezeRevision();
  } else {
    successful = FvfCore.restore();
  }

  if (successful) {
    Cli.showDoneMessage();
  } else {
    print('');
  }
}
