import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.black,
        indicatorColor: Colors.black,
        unselectedLabelColor: Colors.grey.shade600,
        tabs: [
      Tab(

        child: Text('Pending Orers'),
      ),
      Tab(
        child: Text('Complete Orders'),

      )
    ]);
  }
}
