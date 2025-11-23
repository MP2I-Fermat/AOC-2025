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

  final StreamController<OutputLine> _linesController = StreamController();
  Stream<OutputLine> get lines => _linesController.stream;

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
        .transform(const LineSplitter())
        .listen(
          (line) => _linesController.add(
            OutputLine(stream: OutputStream.stderr, line: line),
          ),
        );

    final stdoutSubscription = process.stdout
        .transform(const Utf8Decoder())
        .transform(const LineSplitter())
        .listen(
          (line) => _linesController.add(
            OutputLine(stream: OutputStream.stdout, line: line),
          ),
        );

    final exitCode = process.exitCode.then((exitCode) {
      if (exitCode != 0) {
        _linesController.add(
          OutputLine(
            stream: OutputStream.stderr,
            line: 'Process exited with code $exitCode',
          ),
        );
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
      _linesController.add(OutputLine(stream: OutputStream.stdin, line: line));
    }
  }

  Future<void> cancel() async {
    process.kill();
    return _linesController.done;
  }
}
