import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClassicScreen', () {
    testWidgets('if loading, shows spinner', (tester) async {});
    testWidgets('if error, shows error and refresh button', (tester) async {});
    testWidgets('if has no information, shows placeholder', (tester) async {});
    testWidgets('if people list is empty, shows add button', (tester) async {});
    testWidgets('if list has people, shows person tiles', (tester) async {});
  });
}
