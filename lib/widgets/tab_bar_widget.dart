import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      Container(
        color: Colors.green,
        child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(
                100,
                (index) => Card(
                      color: index % 4 == 0
                          ? Colors.red
                          : index % 4 == 2
                              ? Colors.pink
                              : index % 4 == 1
                                  ? Colors.yellow
                                  : Colors.blue,
                      child: Text('Grid$index'),
                    ))),
      ),
      Container(
        color: Colors.red,
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('List$index'),
                ),
              );
            }),
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.blue,
      ),
    ]);
  }
}
