import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:web/web.dart';

final codeProvider = NotifierProvider(CodeProvider.new);

class CodeProvider extends Notifier<String> {
  static const storageKey = 'aoc_code';

  @override
  String build() {
    if (window.localStorage.getItem(storageKey) case final code?) {
      return code;
    }

    return '''
. A simple fizzbuzz

[
  args, 0 > std::list::nth > n  . stores the current value into n

  . trivial and self-explanatory /s
  > (n, 15 > std::math::mod, 0 > std::comp::eq,
    ["fizzbuzz" > std::io::print],
    [> (n, 5 > std::math::mod, 0 > std::comp::eq,
      ["buzz" > std::io::print],
      [> (n, 3 > std::math::mod, 0 > std::comp::eq,
        ["fizz" > std::io::print],
        [n > std::io::print] > std::tests::if)] > std::tests::if)] > std::tests::if)

  > (n, 100 > std::comp::eq, [()], [n, 1 > std::math::add > fizzbuzz] > std::tests::if)
] > fizzbuzz

1 > fizzbuzz
''';
  }

  void setStoredCode(String code) {
    window.localStorage.setItem(storageKey, code);
    state = code;
  }

  void restoreStoredCode() {
    state = build();
  }

  void setDisplayedCode(String code) {
    state = code;
  }
}
