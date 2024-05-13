
import 'package:best_candidate/Dashboard/BuildingCv/building_cv.dart';
import 'package:best_candidate/Dashboard/Drawer/navigation_drawer.dart';
import 'package:best_candidate/Dashboard/Orders/my_orders.dart';
import 'package:best_candidate/Dashboard/Portfolio/portfolio.dart';
import 'package:best_candidate/Dashboard/dashboard/dashboard.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    // pages
    const Dashboard(),
    const Portfolio(),
    const BuildingCv(),
    const Orders(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const CustomNavigationDraer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Best Candidate'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              backgroundColor: primarycolor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: 'Motivation',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: 'Build Portfolio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description),
                  label: 'Build CV',
                ),
              ]),
        ),
      ),
    );
  }
}