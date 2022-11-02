import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/tabs/all_tasks.dart';
import 'package:todo/tabs/complete_tasks.dart';
import 'package:todo/tabs/incomplete_tasks.dart';

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
  late ScrollController scrollController;

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
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: const Icon(Icons.add, size: 35.0),
          onPressed: () {
            //scrollableModalBottomSheet(context);
          },
        ),
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
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            //TabBar
            // ignore: avoid_unnecessary_containers
            Container(
              child: TabBar(
                controller: tabController,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelColor: Colors.blue,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                padding: const EdgeInsets.all(15.0),
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  color: Colors.blue,
                ),
                tabs: const [
                  Tab(text: 'Active'),
                  Tab(text: 'Complete'),
                  Tab(text: 'Trash'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  AllTasks(),
                  CompleteTasks(),
                  IncompleteTasks(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> scrollableModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: ((context) => DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.2,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                color: Colors.white,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text('Item ${index + 1}'),
                    );
                  }),
                  itemCount: 20,
                ),
              );
            },
          )),
    );
  }
}
