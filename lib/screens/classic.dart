import 'package:demo/models/people.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const vSpace = SizedBox(height: 24);
const hSpace = SizedBox(width: 24);

class ClassicScreen extends StatelessWidget {
  const ClassicScreen();

  @override
  Widget build(BuildContext context) => Consumer<PeopleModel>(
        builder: (context, peopleModel, _) {
          final AsyncSnapshot<List<Person>> snapPeople = peopleModel.people;

          if (snapPeople.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapPeople.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error),
                  vSpace,
                  Text(
                    'There was an error...',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  vSpace,
                  RaisedButton(
                    onPressed: peopleModel.loadPeople,
                    child: Icon(Icons.refresh),
                  )
                ],
              ),
            );
          }

          if (!snapPeople.hasData) {
            // if there is nothing, show nothing...
            return Container(color: Colors.grey);
          }

          final people = snapPeople.data;

          if (people.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'We need some people',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  vSpace,
                  RaisedButton(
                    onPressed: peopleModel.addSomePerson,
                    color: Colors.greenAccent,
                    child: Icon(Icons.person_add),
                  )
                ],
              ),
            );
          }

          return Center(
            child: Column(
              children: [
                vSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: peopleModel.loadPeople,
                      color: Colors.blueAccent,
                      child: Icon(Icons.refresh),
                    ),
                    hSpace,
                    RaisedButton(
                      onPressed: peopleModel.addSomePerson,
                      color: Colors.greenAccent,
                      child: Icon(Icons.person_add),
                    ),
                    hSpace,
                    RaisedButton(
                      onPressed: peopleModel.triggerError,
                      color: Colors.orangeAccent,
                      child: Icon(Icons.error),
                    )
                  ],
                ),
                vSpace,
                Expanded(
                  child: Container(
                    color: Color(0xFFA0C69F), // make weather dependent
                    child: ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (ctx, i) => PersonTile(people[i]),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}

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
        return Icon(Icons.arrow_drop_down);
      case Level.associate:
      case Level.engineer:
      case Level.senior:
      default:
        return Icon(Icons.arrow_drop_up);
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
