import 'package:test/test.dart';

import 'package:flutter_versio_frigidus/flutter_versio_frigidus.dart';

void main() {
  test('should export cli/cli_opts.dart', () {
    expect(CliOpts.freeze, isA<String>());
  });

  test('should export cli/cli.dart', () {
    expect(Cli.showDoneMessage, isA<void Function()>());
  });

  test('should export core/fvf_core.dart', () {
    expect(FvfCore.freeze, isA<bool Function()>());
  });
}
