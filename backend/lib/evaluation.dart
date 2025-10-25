import 'dart:io';

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

  static Future<Evaluation> evaluate(String code) async {
    print('Running $code');

    final tmpDir = await Directory.systemTemp.createTemp('huitr-eval-');

    try {
      final codeFile = File.fromUri(tmpDir.uri.resolve('code.8r'));
      await codeFile.create();
      await codeFile.writeAsString(code);

      final process = useNsJail
          ? await Process.start('nsjail', [
              '--quiet',
              '--chroot=${tmpDir.absolute.path}',
              '--user=1000',
              '--group=1000',
              '--time_limit=30',
              '--max_cpus=1',
              '--bindmount_ro=/usr',
              '--bindmount_ro=/lib64',
              '--bindmount_ro=/lib',
              '--bindmount_ro=$absoluteHuitrLocation:/opt/huitr',
              '--cgroup_mem_max=128000000',
              '--cgroup_pids_max=4',
              '--cgroup_cpu_ms_per_sec=100',
              '--use_cgroupv2',
              '--',
              '/opt/huitr/huitr',
              '/code.8r',
            ])
          : await Process.start(
              Directory(
                absoluteHuitrLocation,
              ).uri.resolve('huitr').toFilePath(),
              [tmpDir.uri.resolve('code.8r').toFilePath()],
            );

      process.stdout.listen(stdout.add);
      process.stderr.listen(stderr.add);

      return Evaluation(process);
    } catch (_) {
      await tmpDir.delete();
      rethrow;
    }
  }

  Evaluation(this.process);

  Future<void> cancel() async {}
}
