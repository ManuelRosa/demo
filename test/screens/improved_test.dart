import 'package:demo/components/person_tile.dart';
import 'package:demo/models/people.dart';
import 'package:demo/screens/improved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/test_app.dart';
import '../utils/test_data.dart';

void main() {
  group('ImprovedScreen (UI)', () {
    ImprovedScreenModel createViewModel({
      bool isLoading = false,
      bool hasError = false,
      bool hasNothing = false,
      bool isEmpty = false,
      List<Person> people = const [person1],
    }) =>
        ImprovedScreenModel(
          isLoading: isLoading,
          hasError: hasError,
          hasNothing: hasNothing,
          isEmpty: isEmpty,
          people: people,
          reload: () async {},
          addSomePerson: () async {},
          triggerError: () {},
        );

    testWidgets('if loading, shows spinner', (tester) async {
      final model = createViewModel(isLoading: true);
      await tester.pumpWidget(TestApp(ImprovedScreen(model)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('if error, shows error and refresh button', (tester) async {
      final model = createViewModel(hasError: true);
      await tester.pumpWidget(TestApp(ImprovedScreen(model)));

      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('There was an error...'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('if has no information, shows placeholder', (tester) async {
      final model = createViewModel(hasNothing: true);
      await tester.pumpWidget(TestApp(ImprovedScreen(model)));

      expect(find.byType(Placeholder), findsOneWidget);
    });

    testWidgets('if people list is empty, shows add button', (tester) async {
      final model = createViewModel(isEmpty: true);
      await tester.pumpWidget(TestApp(ImprovedScreen(model)));

      expect(find.text('We need some people'), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('if list has people, shows person tiles', (tester) async {
      const peopleData = [person1, person2, person3];
      final model = createViewModel(people: peopleData);
      await tester.pumpWidget(TestApp(ImprovedScreen(model)));

      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.byType(PersonTile), findsNWidgets(peopleData.length));
    });
  });

  group('ImprovedScreenModel (Business Logic)', () {
    const snapNothing = AsyncSnapshot<List<Person>>.nothing();
    const snapWaiting = AsyncSnapshot<List<Person>>.waiting();
    const snapError =
        AsyncSnapshot<List<Person>>.withError(ConnectionState.done, 'Error');
    const snapEmpty =
        AsyncSnapshot<List<Person>>.withData(ConnectionState.done, <Person>[]);

    test('sets loading if state is waiting', () {
      final peopleModel = PeopleModel()..people = snapWaiting;
      final viewModel = ImprovedScreenModel.fromSelector(peopleModel);

      expect(viewModel.isLoading, true);
    });

    test('sets error if has error', () {
      final peopleModel = PeopleModel()..people = snapError;
      final viewModel = ImprovedScreenModel.fromSelector(peopleModel);

      expect(viewModel.hasError, true);
    });

    test('sets nothing if has no error and no data', () {
      final peopleModel = PeopleModel()..people = snapNothing;
      final viewModel = ImprovedScreenModel.fromSelector(peopleModel);

      expect(viewModel.hasNothing, true);
    });

    test('sets empty if people list is empty', () {
      final peopleModel = PeopleModel()..people = snapEmpty;
      final viewModel = ImprovedScreenModel.fromSelector(peopleModel);

      expect(viewModel.isEmpty, true);
    });

    test('sets people from model list ', () {
      const peopleData = [person1, person2, person3];
      final peopleModel = PeopleModel()
        ..people = AsyncSnapshot<List<Person>>.withData(
          ConnectionState.done,
          peopleData,
        );
      final viewModel = ImprovedScreenModel.fromSelector(peopleModel);

      expect(viewModel.people, peopleData);
    });
  });
}
