import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/raised_gradient_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd MMM yyyy, EEEE');
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final String formatted = formatter.format(now);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 0, 10),
              child: Text(
                'Today',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Text(
                formatted,
                style: const TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            RaisedGradientButton(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.lightBlue.shade300,
                  Colors.blue.shade800,
                ],
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Search',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: TabBar(
                controller: tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.green,
                unselectedLabelStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
                padding: const EdgeInsets.all(15.0),
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  color: Colors.blue,
                ),
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Complete'),
                  Tab(text: 'Incomplete'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  Text('Hello World'),
                  Text('Hello World 2'),
                  Text('Hello World3 '),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
