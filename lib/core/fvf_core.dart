import 'dart:io';

/// Core functionality of Flutter Versio Frigidus.
abstract class FvfCore {
  /// Path to file where version or revision is stored.
  static const String fvfFile = 'flutter_versio_frigidus';

  /// Saves current Flutter version to [fvfFile].
  static bool freeze() {
    final ProcessResult result = Process.runSync('flutter', ['--version']);
    if (result.exitCode != 0) {
      print(result.stderr);
      return false;
    }

    final RegExp re = RegExp(r'Flutter (.*?) ');
    final String flutterVersion = re.firstMatch(result.stdout)!.group(1)!;

    final File configFile = File(fvfFile);
    configFile.writeAsStringSync(flutterVersion, mode: FileMode.write);

    print('Flutter version $flutterVersion saved to $fvfFile');
    return true;
  }

  /// Saves current Flutter revision to [fvfFile].
  static bool freezeRevision() {
    final ProcessResult result = Process.runSync('flutter', ['--version']);
    if (result.exitCode != 0) {
      print(result.stderr);
      return false;
    }

    final RegExp re = RegExp(r'revision (.*?) ');
    final String flutterVersion = re.firstMatch(result.stdout)!.group(1)!;

    final File configFile = File(fvfFile);
    configFile.writeAsStringSync(flutterVersion, mode: FileMode.write);

    print('Flutter revision $flutterVersion saved to $fvfFile');
    return true;
  }

  /// Sets current Flutter version to the one saved in [fvfFile].
  static bool restore() {
    final File f = File(fvfFile);
    if (!f.existsSync()) {
      print('$fvfFile missing, cannot restore');
      return false;
    }
    final String flutterVersion = f.readAsStringSync();

    print(
        'Restoring Flutter to ${flutterVersion.contains('.') ? 'version' : 'revision'} $flutterVersion ...');

    final ProcessResult findResult = Process.runSync(
      Platform.isWindows ? 'where' : 'which',
      ['flutter'],
      runInShell: true,
    );
    if (findResult.exitCode != 0) {
      print(findResult.stderr);
      return false;
    }

    final String output = findResult.stdout;
    final String flutterPath = output.substring(0, output.length - 13);

    final Directory currentDirectory = Directory.current;
    Directory.current = flutterPath;

    final ProcessResult changeVersionResult =
        Process.runSync('git', ['checkout', flutterVersion]);
    if (changeVersionResult.exitCode != 0) {
      print(changeVersionResult.stderr);
      return false;
    }
    print(changeVersionResult.stdout);

    final ProcessResult doctorResult = Process.runSync('flutter', ['doctor']);
    if (doctorResult.exitCode != 0) {
      print(doctorResult.stderr);
      return false;
    }
    print(doctorResult.stdout);

    Directory.current = currentDirectory;
    return true;
  }
}
