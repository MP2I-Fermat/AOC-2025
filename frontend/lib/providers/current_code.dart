import 'package:jaspr_riverpod/jaspr_riverpod.dart';

final codeProvider = NotifierProvider(CodeProvider.new);

class CodeProvider extends Notifier<String> {
  @override
  String build() {
    return '''
# Some test code
if [ -d some_directory ]; then
  echo "Test!"
  exit 1
fi
''';
  }

  void setCode(String code) => state = code;
}
