import 'dart:io';

abstract class FvfCore {
  static const String fvfConfigFile = 'flutter_versio_frigidus';

  static bool freeze() {
    final ProcessResult result = Process.runSync('flutter', ['--version']);
    if (result.exitCode != 0) {
      print(result.stderr);
      return false;
    }

    final RegExp re = RegExp(r'Flutter (.*?) ');
    final String flutterVersion = re.firstMatch(result.stdout).group(1);

    final File configFile = File(fvfConfigFile);
    configFile.writeAsStringSync(flutterVersion, mode: FileMode.write);

    print('Flutter version $flutterVersion saved to $fvfConfigFile');
    return true;
  }

  static bool freezeRevision() {
    final ProcessResult result = Process.runSync('flutter', ['--version']);
    if (result.exitCode != 0) {
      print(result.stderr);
      return false;
    }

    final RegExp re = RegExp(r'revision (.*?) ');
    final String flutterVersion = re.firstMatch(result.stdout).group(1);

    final File configFile = File(fvfConfigFile);
    configFile.writeAsStringSync(flutterVersion, mode: FileMode.write);

    print('Flutter revision $flutterVersion saved to $fvfConfigFile');
    return true;
  }

  static bool restore() {
    final File f = File(fvfConfigFile);
    if (!f.existsSync()) {
      print('$fvfConfigFile missing, cannot restore');
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
