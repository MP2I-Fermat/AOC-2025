import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:common/protocol.dart';

class Evaluation {
  static const huitrLocation = String.fromEnvironment(
    'HUITR_LOCATION',
    defaultValue: '/opt/huitr',
  );

  static const useNsJail = bool.fromEnvironment(
    'USE_NSJAIL',
    defaultValue: true,
  );

  static final absoluteHuitrLocation = Directory(huitrLocation).absolute.path;

  final Process process;
  final Directory tmpDir;

  final outputLines = <OutputLine>[];
  int? currentStderrLine;
  int? currentStdoutLine;

  final StreamController<List<OutputLine>> _linesController =
      StreamController();
  Stream<List<OutputLine>> get onOutputChange => _linesController.stream;

  static Future<Evaluation> start(String code) async {
    final tmpDir = await Directory.systemTemp.createTemp('huitr-eval-');

    try {
      final codeFile = File.fromUri(tmpDir.uri.resolve('code.8tr'));
      await codeFile.writeAsString(code);

      final process = useNsJail
          ? await Process.start('nsjail', [
              '--really_quiet',
              '--chroot=${tmpDir.absolute.path}',
              '--user=1000',
              '--group=1000',
              '--time_limit=120',
              '--max_cpus=1',
              '--bindmount_ro=/usr',
              '--bindmount_ro=/lib64',
              '--bindmount_ro=/lib',
              '--bindmount_ro=$absoluteHuitrLocation:/opt/huitr',
              '--cgroup_mem_max=128000000',
              '--cgroup_pids_max=4',
              // '--cgroup_cpu_ms_per_sec=100',
              '--use_cgroupv2',
              '--',
              '/opt/huitr/huitr',
              'code.8tr',
            ])
          : await Process.start(
              workingDirectory: tmpDir.path,
              Directory(
                absoluteHuitrLocation,
              ).uri.resolve('huitr').toFilePath(),
              ['code.8tr'],
            );

      return Evaluation(process, tmpDir);
    } catch (_) {
      await tmpDir.delete();
      rethrow;
    }
  }

  Evaluation(this.process, this.tmpDir) {
    final stderrSubscription = process.stderr
        .transform(const Utf8Decoder())
        .listen((chars) {
          if (currentStderrLine == null) {
            currentStderrLine = outputLines.length;
            outputLines.add(OutputLine(stream: OutputStream.stderr, line: ''));
          }

          final splitLines = chars.split('\n');

          outputLines[currentStderrLine!] = OutputLine(
            stream: OutputStream.stderr,
            line: outputLines[currentStderrLine!].line + splitLines[0],
          );

          for (int i = 1; i < splitLines.length; i++) {
            currentStderrLine = outputLines.length;
            outputLines.add(
              OutputLine(stream: OutputStream.stderr, line: splitLines[i]),
            );
          }

          _linesController.add(outputLines);
        });

    final stdoutSubscription = process.stdout
        .transform(const Utf8Decoder())
        .listen((chars) {
          if (currentStdoutLine == null) {
            currentStdoutLine = outputLines.length;
            outputLines.add(OutputLine(stream: OutputStream.stdout, line: ''));
          }

          final splitLines = chars.split('\n');

          outputLines[currentStdoutLine!] = OutputLine(
            stream: OutputStream.stdout,
            line: outputLines[currentStdoutLine!].line + splitLines[0],
          );

          for (int i = 1; i < splitLines.length; i++) {
            currentStdoutLine = outputLines.length;
            outputLines.add(
              OutputLine(stream: OutputStream.stdout, line: splitLines[i]),
            );
          }

          _linesController.add(outputLines);
        });

    final exitCode = process.exitCode.then((exitCode) {
      if (exitCode != 0) {
        outputLines.add(
          OutputLine(
            stream: OutputStream.stderr,
            line: 'Process exited with code $exitCode',
          ),
        );
        _linesController.add(outputLines);
      }
    });

    exitCode.then((_) async {
      await tmpDir.delete(recursive: true);
      stdoutSubscription.cancel();
      stderrSubscription.cancel();
      await _linesController.close();
    });
  }

  void input(String line) {
    if (!_linesController.isClosed) {
      process.stdin.writeln(line);
      outputLines.add(OutputLine(stream: OutputStream.stdin, line: line));
      _linesController.add(outputLines);

      currentStderrLine = null;
      currentStdoutLine = null;
    }
  }

  Future<void> cancel() async {
    process.kill();
    return _linesController.done;
  }
}
