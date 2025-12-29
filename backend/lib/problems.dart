import 'dart:io';

class Problem {
  static const problemsLocation = String.fromEnvironment(
    'PROBLEMS_LOCATION',
    defaultValue: '/opt/backend/problems',
  );

  static final Future<Map<String, Problem>> problems = Problem.loadProblems(
    Uri.file(problemsLocation),
  );

  final String prompt;

  final List<TestCase> testCases;

  Problem({required this.prompt, required this.testCases});

  static Future<Problem> load(Uri sourceDir) async {
    final promptFile = File.fromUri(sourceDir.resolve('problem.md'));
    if (!(await promptFile.exists())) {
      throw Exception(
        'Unable to load problem from $sourceDir: missing problem.md',
      );
    }
    final prompt = await promptFile.readAsString();

    final testDirectory = Directory.fromUri(sourceDir.resolve('tests'));

    final tests = <TestCase>[];

    await for (final test in testDirectory.list()) {
      if (test is! Directory) continue;

      final inputFile = File.fromUri(test.uri.resolve('input'));
      final outputFile = File.fromUri(test.uri.resolve('output'));

      if (!(await inputFile.exists()) || !(await outputFile.exists())) {
        throw Exception(
          'Unable to load test from ${test.uri}: missing input or output',
        );
      }

      final input = await inputFile.readAsString();
      final output = await outputFile.readAsString();

      tests.add(TestCase(input: input, output: output));
    }

    return Problem(prompt: prompt, testCases: tests);
  }

  static Future<Map<String, Problem>> loadProblems(Uri problemsDir) async {
    final problems = <String, Problem>{};
    await for (final problemDir in Directory.fromUri(problemsDir).list()) {
      if (problemDir is! Directory) continue;

      problems[problemDir.uri.pathSegments[problemDir.uri.pathSegments.length -
          2]] = await load(
        problemDir.uri,
      );
    }
    return problems;
  }
}

class TestCase {
  final String input;
  final String output;

  TestCase({required this.input, required this.output});
}
