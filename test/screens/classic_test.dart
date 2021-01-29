import 'package:demo/components/person_tile.dart';
import 'package:demo/models/people.dart';
import 'package:demo/screens/classic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../utils/test_app.dart';
import '../utils/test_data.dart';

void main() {
  const snapNothing = AsyncSnapshot<List<Person>>.nothing();
  const snapWaiting =
      AsyncSnapshot<List<Person>>.withData(ConnectionState.waiting, <Person>[]);
  const snapError =
      AsyncSnapshot<List<Person>>.withError(ConnectionState.done, 'Error');
  const snapEmpty =
      AsyncSnapshot<List<Person>>.withData(ConnectionState.done, <Person>[]);

  group('ClassicScreen', () {
    testWidgets('if loading, shows spinner', (tester) async {
      final peopleModel = PeopleModel()..people = snapWaiting;

      await tester.pumpWidget(
        ChangeNotifierProvider<PeopleModel>.value(
          value: peopleModel,
          child: TestApp(ClassicScreen()),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('if error, shows error and refresh button', (tester) async {
      final peopleModel = PeopleModel()..people = snapError;

      await tester.pumpWidget(
        ChangeNotifierProvider<PeopleModel>.value(
          value: peopleModel,
          child: TestApp(ClassicScreen()),
        ),
      );

      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('There was an error...'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('if has no information, shows placeholder', (tester) async {
      final peopleModel = PeopleModel()..people = snapNothing;

      await tester.pumpWidget(
        ChangeNotifierProvider<PeopleModel>.value(
          value: peopleModel,
          child: TestApp(ClassicScreen()),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
    });

    testWidgets('if people list is empty, shows add button', (tester) async {
      final peopleModel = PeopleModel()..people = snapEmpty;

      await tester.pumpWidget(
        ChangeNotifierProvider<PeopleModel>.value(
          value: peopleModel,
          child: TestApp(ClassicScreen()),
        ),
      );

      expect(find.text('We need some people'), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('if list has people, shows person tiles', (tester) async {
      const peopleData = [person1, person2, person3];
      final peopleModel = PeopleModel()
        ..people = AsyncSnapshot<List<Person>>.withData(
          ConnectionState.done,
          peopleData,
        );

      await tester.pumpWidget(
        ChangeNotifierProvider<PeopleModel>.value(
          value: peopleModel,
          child: TestApp(ClassicScreen()),
        ),
      );

      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.byType(PersonTile), findsNWidgets(peopleData.length));
    });
  });
}
