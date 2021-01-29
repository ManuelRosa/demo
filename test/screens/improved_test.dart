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
    test('sets loading if state is waiting', () {});
    test('sets error if has error', () {});
    test('sets nothing if has no error and no data', () {});
    test('sets empty if people list is empty', () {});
    test('sets people from model list ', () {});
  });
}
