import 'package:best_candidate/constance/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Order History'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserId)
              .collection('orders')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final ordersDoc = snapshot.data!.docs;
              if (ordersDoc.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ConstanceData.cartEmpty),
                      const Text('No orders have been made.'),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                    itemCount: ordersDoc.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final orderDoc = ordersDoc[index];
                      final userNmae = orderDoc['userName'];
                      final email = orderDoc['email'];
                      final paymentStatus = orderDoc['payment'];
                      final orderStatus = orderDoc['status'];
                      final orderType = orderDoc['Order Type'];
                      final payment = orderDoc['budget'];
                      final createdAt = orderDoc['createdAt'];
                      final formattedDate =
                          DateFormat.yMMMd().format(createdAt.toDate());
                      if (orderStatus == 'Reviewing') {
                        return Container(
                          //height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Hi $userNmae you have placed an order of developin an $orderType',
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                              const Divider(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Card(
                                    elevation: 2.0,
                                    color: blueColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Order Status'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Card(
                                    elevation: 2.0,
                                    color: orderStatus == 'Reviewing'
                                        ? Colors.yellow
                                        : Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          orderStatus,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  const Card(
                                    elevation: 2.0,
                                    color: blueColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Payment Status'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Card(
                                    elevation: 2.0,
                                    color: paymentStatus == 'Incomplete'
                                        ? Colors.yellow
                                        : Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          paymentStatus,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Order Informatin',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 18),
                                ),
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Card(
                                      child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Account Mail',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          email,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  )),
                                  Card(
                                      child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Date of Creation ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          formattedDate,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Order Budget',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      payment,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ),
                        );
                      } else if (orderStatus == 'Accepted') {
                        return Center(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.green),
                                color: Colors.green.shade100),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                'Congratulations $userNmae your order $orderType \n crerated on $formattedDate has been $orderStatus \n You will be contacted soon ',
                                style: const TextStyle(fontSize: 22),
                              )),
                            ),
                          ),
                        );
                      }
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
