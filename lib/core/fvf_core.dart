import 'dart:io';

abstract class FvfCore {
  static const String _fvfConfigFile = 'flutter_versio_frigidus';

  static bool freeze() {
    final ProcessResult result = Process.runSync('flutter', ['--version']);
    if (result.exitCode != 0) {
      stdout.writeln(result.stderr);
      return false;
    }

    final RegExp re = RegExp(r'Flutter (.*?) ');
    final String flutterVersion = re.firstMatch(result.stdout).group(1);

    final File configFile = File(_fvfConfigFile);
    configFile.writeAsStringSync(flutterVersion, mode: FileMode.write);

    stdout.writeln('Flutter version $flutterVersion saved to $_fvfConfigFile');
    return true;
  }

  static bool freezeRevision() {
    final ProcessResult result = Process.runSync('flutter', ['--version']);
    if (result.exitCode != 0) {
      stdout.writeln(result.stderr);
      return false;
    }

    final RegExp re = RegExp(r'revision (.*?) ');
    final String flutterVersion = re.firstMatch(result.stdout).group(1);

    final File configFile = File(_fvfConfigFile);
    configFile.writeAsStringSync(flutterVersion, mode: FileMode.write);

    stdout.writeln('Flutter revision $flutterVersion saved to $_fvfConfigFile');
    return true;
  }

  static bool restore() {
    final File f = File(_fvfConfigFile);
    if (!f.existsSync()) {
      stdout.writeln('$_fvfConfigFile missing, cannot restore');
      return false;
    }
    final String flutterVersion = f.readAsStringSync();

    stdout.writeln(
        'Restoring Flutter to ${flutterVersion.contains('.') ? 'version' : 'revision'} $flutterVersion ...');

    final ProcessResult findResult = Process.runSync(
      Platform.isWindows ? 'where' : 'which',
      ['flutter'],
      runInShell: true,
    );
    if (findResult.exitCode != 0) {
      stdout.writeln(findResult.stderr);
      return false;
    }

    final String output = findResult.stdout;
    final String flutterPath = output.substring(0, output.length - 13);

    Directory.current = flutterPath;

    final ProcessResult changeVersionResult =
        Process.runSync('git', ['checkout', flutterVersion]);
    if (changeVersionResult.exitCode != 0) {
      stdout.writeln(changeVersionResult.stderr);
      return false;
    }
    stdout.writeln(changeVersionResult.stdout);

    final ProcessResult doctorResult = Process.runSync('flutter', ['doctor']);
    if (doctorResult.exitCode != 0) {
      stdout.writeln(doctorResult.stderr);
      return false;
    }
    stdout.writeln(doctorResult.stdout);
    return true;
  }
}
