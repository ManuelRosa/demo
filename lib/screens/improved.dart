import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/person_tile.dart';
import '../models/people.dart';

const vSpace = SizedBox(height: 24);
const hSpace = SizedBox(width: 24);

typedef FutureVoidCallback = Future<void> Function();

class ImprovedScreen extends StatelessWidget {
  const ImprovedScreen(this.model);

  final ImprovedScreenModel model;

  static Widget fromProvider() => Selector<PeopleModel, ImprovedScreenModel>(
        selector: (_, people) => ImprovedScreenModel.fromSelector(people),
        builder: (_, model, __) => ImprovedScreen(model),
      );

  @override
  Widget build(BuildContext context) {
    if (model.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (model.hasError) {
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
              onPressed: model.reload,
              child: Icon(Icons.refresh),
            )
          ],
        ),
      );
    }

    if (model.hasNothing) {
      // if there is nothing, show nothing...
      return Placeholder(color: Colors.grey);
    }

    if (model.isEmpty) {
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
              onPressed: model.addSomePerson,
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
                onPressed: model.reload,
                color: Colors.blueAccent,
                child: Icon(Icons.refresh),
              ),
              hSpace,
              RaisedButton(
                onPressed: model.addSomePerson,
                color: Colors.greenAccent,
                child: Icon(Icons.person_add),
              ),
              hSpace,
              RaisedButton(
                onPressed: model.triggerError,
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
                itemCount: model.people.length,
                itemBuilder: (ctx, i) => PersonTile(model.people[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImprovedScreenModel extends Equatable {
  @visibleForTesting
  const ImprovedScreenModel({
    this.isLoading,
    this.hasError,
    this.hasNothing,
    this.isEmpty,
    this.people,
    this.reload,
    this.addSomePerson,
    this.triggerError,
  });

  factory ImprovedScreenModel.fromSelector(PeopleModel peopleModel) {
    final AsyncSnapshot<List<Person>> snapPeople = peopleModel.people;

    return ImprovedScreenModel(
      isLoading: snapPeople.connectionState == ConnectionState.waiting,
      hasError: snapPeople.hasError,
      hasNothing: !snapPeople.hasData && !snapPeople.hasError,
      isEmpty: snapPeople.data?.isEmpty ?? true,
      people: snapPeople.data,
      reload: peopleModel.loadPeople,
      addSomePerson: peopleModel.addSomePerson,
      triggerError: peopleModel.triggerError,
    );
  }

  final bool isLoading;
  final bool hasError;
  final bool hasNothing;
  final bool isEmpty;
  final List<Person> people;
  final FutureVoidCallback reload;
  final FutureVoidCallback addSomePerson;
  final VoidCallback triggerError;

  @override
  List<Object> get props => [isLoading, hasError, hasNothing, isEmpty, people];
}
