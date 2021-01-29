import 'package:flutter/material.dart';

import '../models/people.dart';

class PersonTile extends StatelessWidget {
  const PersonTile(this.person);

  final Person person;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: person.level.asIcon,
        title: person.titleWidget,
        subtitle: person.subtitleWidget,
      );
}

extension _LevelWidget on Level {
  Widget get asIcon {
    switch (this) {
      case Level.newbie:
        return Icon(Icons.star_border);
      case Level.associate:
        return Icon(Icons.star_half);
      case Level.engineer:
        return Icon(Icons.star);
      case Level.senior:
        return Icon(Icons.star, color: Colors.yellow);
      default:
        return Icon(Icons.star_border, color: Colors.red);
    }
  }
}

extension _PersonWidget on Person {
  Widget get titleWidget {
    final hasFirstName = name.firstName != null;
    final hasLastName = name.lastName != null;
    final text = hasFirstName && hasLastName
        ? '${name.firstName} ${name.lastName}'
        : hasFirstName
            ? name.firstName
            : hasLastName
                ? name.lastName
                : name?.nickName ?? 'Someone';
    return Text(text);
  }

  Widget get subtitleWidget {
    final text = (age != null ? 'age: $age' : '') +
        (name?.nickName?.isEmpty ?? true ? '' : ' (aka ${name.nickName})');
    return Text(text);
  }
}
