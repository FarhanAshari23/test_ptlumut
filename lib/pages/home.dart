import 'package:flutter/material.dart';
import 'package:test_lumut/widgets/activity_card.dart';

import '../models/activity.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Post> _activity;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _activity = [];
    getPosts();
  }

  Future<void> getPosts() async {
    _activity = await ApiService().getPosts();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/run.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            const Text("List Activity"),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                mainAxisExtent: 300,
              ),
              itemCount: _activity.length,
              itemBuilder: (context, index) {
                String stringReps;
                bool checkBoolean = _activity[index].completed;
                if (checkBoolean) {
                  stringReps = "True";
                } else {
                  stringReps = "False";
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 10,
                    bottom: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            title: _activity[index].title,
                            completed: stringReps,
                          ),
                        ),
                      );
                    },
                    child: ActivityCard(
                      title: _activity[index].title,
                      completed: stringReps,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
