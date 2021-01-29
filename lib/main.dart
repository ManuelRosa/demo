import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/people.dart';
import 'models/weather.dart';
import 'screens/classic.dart';
import 'screens/improved.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PeopleModel>(create: (_) => PeopleModel()),
        Provider<WeatherModel>(
          create: (_) => WeatherModel(condition: WeatherCondition.sunny),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const ClassicScreen(),
            ImprovedScreen.fromProvider(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          tabs: [
            Tab(child: Container(child: Icon(Icons.remove), color: Colors.red)),
            Tab(child: Container(child: Icon(Icons.add), color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
