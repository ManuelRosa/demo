import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ImprovedScreen (UI)', () {
    testWidgets('if loading, shows spinner', (tester) async {});
    testWidgets('if error, shows error and refresh button', (tester) async {});
    testWidgets('if has no information, shows placeholder', (tester) async {});
    testWidgets('if people list is empty, shows add button', (tester) async {});
    testWidgets('if list has people, shows person tiles', (tester) async {});
  });

  group('ImprovedScreenModel (Business Logic)', () {
    testWidgets('sets loading if state is waiting', (tester) async {});
    testWidgets('sets error if has error', (tester) async {});
    testWidgets('sets nothing if has no error and no data', (tester) async {});
    testWidgets('sets empty if people list is empty', (tester) async {});
    testWidgets('sets people from model list ', (tester) async {});
  });
}
