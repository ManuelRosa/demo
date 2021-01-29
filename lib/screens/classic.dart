import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/person_tile.dart';
import '../models/people.dart';

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
            return Placeholder(color: Colors.grey);
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
