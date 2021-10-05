import 'dart:io';

import 'package:flutter_versio_frigidus/core/fvf_core.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    final File f = File(FvfCore.fvfFile);
    if (f.existsSync()) f.deleteSync();
    expect(f.existsSync(), isFalse);
  });

  setUpAll(() {
    expect(File(FvfCore.fvfFile).existsSync(), isFalse);
  });

  tearDownAll(() {
    final File f = File(FvfCore.fvfFile);
    if (f.existsSync()) f.deleteSync();
    expect(f.existsSync(), isFalse);
  });

  group('freeze', () {
    test('should create a file with current Flutter version', () {
      final bool success = FvfCore.freeze();
      expect(success, isTrue);

      final File f = File(FvfCore.fvfFile);
      expect(f.existsSync(), isTrue);
    });
  });

  group('freezeRevision', () {
    test('should create a file with current Flutter revision', () {
      final bool success = FvfCore.freezeRevision();
      expect(success, isTrue);

      final File f = File(FvfCore.fvfFile);
      expect(f.existsSync(), isTrue);
    });
  });

  group('restore', () {
    test(
      'should restore a Flutter version to version specified in ${FvfCore.fvfFile}',
      () {
        final File f = File(FvfCore.fvfFile);
        f.writeAsStringSync('2.5.2');
        expect(f.existsSync(), isTrue);

        final bool success = FvfCore.restore();
        expect(success, isTrue);

        expect(f.existsSync(), isTrue);
      },
    );
  });
}
