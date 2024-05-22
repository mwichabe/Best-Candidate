import 'package:best_candidate/Dashboard/BuildingCv/building_cv.dart';
import 'package:best_candidate/Dashboard/Drawer/navigation_drawer.dart';
import 'package:best_candidate/Dashboard/Orders/my_orders.dart';
import 'package:best_candidate/Dashboard/Portfolio/portfolio.dart';
import 'package:best_candidate/Dashboard/dashboard/dashboard.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<int> getOrdersCount() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('orders')
        .get();
    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    bool canPop = false;
    return PopScope(
       canPop: canPop,
      onPopInvoked: (bool value) {
        setState(() {
          canPop= !value;
        });

        if (canPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Click once more to exit"),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: Scaffold(
        endDrawer: const CustomNavigationDraer(),
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
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: 'Motivation',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: 'Build Portfolio',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.description),
                  label: 'Build CV',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Icon(Icons.shopping_cart),
                      FutureBuilder<int>(
                        future: getOrdersCount(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data! > 0) {
                            return Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${snapshot.data}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                  label: 'Orders',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
