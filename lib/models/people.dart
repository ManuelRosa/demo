import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PeopleModel with ChangeNotifier {
  PeopleModel();

  AsyncSnapshot<List<Person>> _people =
      AsyncSnapshot.withData(ConnectionState.done, []);

  AsyncSnapshot<List<Person>> get people => _people;

  set people(AsyncSnapshot<List<Person>> snap) {
    _people = snap;
    notifyListeners();
  }

  Future<void> loadPeople() async {
    people = people.inState(ConnectionState.waiting);

    // some backend work
    await Future.delayed(const Duration(seconds: 1));

    final data = <Person>[
      Person(name: Name(firstName: 'Manuel'), age: 20, level: Level.newbie),
      Person(name: Name(lastName: 'Rosa'), age: 25, level: Level.associate),
      Person(name: Name(nickName: 'Manu'), age: 30, level: Level.engineer),
    ];
    people = AsyncSnapshot.withData(ConnectionState.done, data);
  }

  Future<void> addSomePerson() async => addPerson(
        Person(name: Name(firstName: 'Someone', lastName: 'New')),
      );

  Future<void> addPerson(Person newPerson) async {
    people = people.inState(ConnectionState.waiting);

    // some backend work
    await Future.delayed(const Duration(seconds: 1));

    final data = <Person>[
      ...people.data, // just copying all people we currently have
      newPerson,
    ];
    people = AsyncSnapshot.withData(ConnectionState.done, data);
  }

  void triggerError() {
    people = AsyncSnapshot.withError(ConnectionState.done, 'Error');
  }
}

class Person extends Equatable {
  const Person({
    this.name,
    this.age,
    this.level = Level.newbie,
  });

  final Name name;
  final int age;
  final Level level;

  @override
  List<Object> get props => [name, age, level];
}

class Name extends Equatable {
  const Name({
    this.firstName,
    this.lastName,
    this.nickName,
  });

  final String firstName;
  final String lastName;
  final String nickName;

  @override
  List<Object> get props => [firstName, lastName, nickName];
}

enum Level {
  newbie,
  associate,
  engineer,
  senior,
}
