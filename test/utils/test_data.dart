import 'package:demo/models/people.dart';

const person1 = Person(
  name: Name(firstName: 'Manuel'),
  age: 20,
  level: Level.newbie,
);

const person2 = Person(
  name: Name(lastName: 'Rosa'),
  age: 25,
  level: Level.associate,
);

const person3 = Person(
  name: Name(nickName: 'Manu'),
  age: 30,
  level: Level.engineer,
);
