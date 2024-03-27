import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/globel_variable.dart';
import '../provider.dart';
import '../viewreport/entry_details.dart';
import 'gave_transaction.dart';

class Transaction extends StatefulWidget {
  String name;
  String number;
  String customerId;
  Transaction({
    super.key,
    required this.name,
    required this.number,
    required this.customerId,
  });

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool isGaveSelected = false;
  late List<Map<String, dynamic>>
      transactions; // List to store transaction data
  double? netAmount = 0.0;
  NetAmountNotifier _netAmountNotifier = NetAmountNotifier();
  @override
  void initState() {
    // Call a method to fetch transactions when the widget initializes
    super.initState();
  }

  // Method to fetch transactions from Firestore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionPay(
                            docid: widget.customerId,
                            isGaveSelected: isGaveSelected = true,
                            name: widget.name,
                          )),
                );
              },
              child: const Text("YOU GAVE ₹"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionPay(
                            isGaveSelected: isGaveSelected = false,
                            name: widget.name,
                            docid: widget.customerId,
                          )),
                );
              },
              child: const Text("YOU GOT ₹"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
                backgroundColor:
                    Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                        .withOpacity(1.0),
                child: Text(
                  '${widget.name}'.substring(0, 1),
                  style: const TextStyle(color: Colors.white),
                )),
            Text(
              "  ${widget.name}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          const Icon(
            Icons.more_vert,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.indigo.shade600,
              width: double.infinity,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            netAmount == 0.0
                                ? const Text("Settled up")
                                : netAmount! < 0.0
                                    ? const Text(
                                        "You will get",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Text(
                                        "You will pay",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                            Icon(
                              netAmount! < 0.0
                                  ? Icons.emoji_emotions
                                  : Icons.emoji_emotions_outlined,
                              color:
                                  netAmount! < 0.0 ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                        Text(
                          "₹ ${netAmount?.toInt()}", // Added a null check here
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: h * 0.09,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.picture_as_pdf_outlined,
                    color: Colors.indigo.shade400,
                  ),
                  Icon(
                    Icons.currency_rupee,
                    color: Colors.indigo.shade400,
                  ),
                  // Icon(Icons.call,color: Colors.indigo,),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.indigo.shade400,
                    ),
                    onPressed: () {
                      String url =
                          "https://wa.me/${widget.number}/?text=Dear Sir/Madam,Your Payment of 100 is pending at My Businuss(${widget.number})";
                      launch(url);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat_outlined,
                        color: Colors.indigo.shade400),
                    onPressed: () {
                      String phoneNumber = widget.number;
                      String message =
                          "Dear Sir/Madam,Your Payment of 100 is pending at My Business(${widget.number})";
                      String url = "sms:$phoneNumber?body=$message";
                      launch(url);
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 15, 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(width: 1,),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "ENTRIES",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Expanded(
                      flex: 1,
                      child: Text(
                        "YOU GAVE",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 8),
                    child: Expanded(
                      flex: 1,
                      child: Text(
                        "YOU GOT",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Customers')
                  .doc(widget.customerId)
                  .collection('youGave')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // Extract documents from snapshot
                var transactionsYouGave = snapshot.data!.docs;

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Customers')
                      .doc(widget.customerId)
                      .collection('youGot')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    // Extract documents from snapshot
                    var transactionsYouGot = snapshot.data!.docs;
                    double totalAmountGiven = 0;
                    for (var transaction in transactionsYouGave) {
                      var data = transaction.data() as Map<String, dynamic>?;
                      var amount = double.parse(data?['amount']);
                      totalAmountGiven += amount;
                    }

// Calculate total amount received
                    double totalAmountReceived = 0;
                    for (var transaction in transactionsYouGot) {
                      var data = transaction.data() as Map<String, dynamic>?;
                      var amount = double.parse(data?['amount']);
                      totalAmountReceived += amount;
                    }
                    print(
                        'Total Amount Received: $totalAmountReceived'); // Print total amount received to console
                    print(
                        'Total Amount Given: $totalAmountGiven'); // Print total amount received to console

                    // Calculate net amount
                    _netAmountNotifier.netAmount = totalAmountGiven - totalAmountReceived;
                    print("${_netAmountNotifier.netAmount}===========");
                    return ListView.builder(
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: transactionsYouGave.length +
                          transactionsYouGot.length,
                      itemBuilder: (context, index) {
                        if (index < transactionsYouGave.length &&
                            index < transactionsYouGot.length) {
                          var transaction1 = transactionsYouGave[index].data()
                              as Map<String, dynamic>?;
                          var transaction2 = transactionsYouGot[index].data()
                              as Map<String, dynamic>?;
                          String formattedTimestamp1 =
                              DateFormat('dd MMM yy • hh:mm a')
                                  .format(transaction1?['timestamp'].toDate());
                          String formattedTimestamp2 =
                              DateFormat('dd MMM yy • hh:mm a')
                                  .format(transaction2?['timestamp'].toDate());
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      // Container styling for youGave items
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EntryDetails(
                                                            Amount:
                                                                '${transaction1['amount']}',
                                                            number: widget.name,
                                                          )));
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 4,
                                                    blurRadius: 3,
                                                    offset: const Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 60,
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            formattedTimestamp1,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        11),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            color: Colors
                                                                .red.shade100,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          2.0),
                                                              child: Text(
                                                                "Bal. ₹  ${transaction1!['balance'] ?? ""}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 60,
                                                      color: Colors.transparent,
                                                      child: Center(
                                                        child: Text(
                                                          "₹ ${transaction1['amount']}",
                                                          style: const TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 60,
                                                      color: Colors.white,
                                                      // Add your content for the third part here
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )))),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      // Container styling for youGave items
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EntryDetails(
                                                            Amount:
                                                                '${transaction2['amount']}',
                                                            number: widget.name,
                                                          )));
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 4,
                                                    blurRadius: 3,
                                                    offset: const Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 60,
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            formattedTimestamp2,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        11),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            color: Colors
                                                                .red.shade100,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          2.0),
                                                              child: Text(
                                                                "Bal. ₹  ${transaction2!['balance'] ?? ""}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 60,
                                                      color: Colors.transparent,
                                                      child: const Center(
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 60,
                                                      color: Colors.white,
                                                      child: Center(
                                                          child: Text(
                                                        "₹ ${transaction2['amount']}",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )),
                                                      // Add your content for the third part here
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )))),
                            ],
                          );
                        } else if (index < transactionsYouGave.length) {
                          // Render items only from youGave collection
                          var transaction1 = transactionsYouGave[index].data()
                              as Map<String, dynamic>?;
                          String formattedTimestamp1 =
                              DateFormat('dd MMM yy * hh:mm a')
                                  .format(transaction1?['timestamp'].toDate());
                          // Your code to render items from youGave collection goes here
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  // Container styling for youGave items
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EntryDetails(
                                                        Amount:
                                                            '${transaction1['amount']}',
                                                        number: widget.name,
                                                      )));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 4,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: 60,
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "$formattedTimestamp1",
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 11),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        color:
                                                            Colors.red.shade100,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          child: Text(
                                                            "Bal. ₹  ${transaction1!['balance'] ?? ""}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 60,
                                                  color: Colors.transparent,
                                                  child: Center(
                                                    child: Text(
                                                      "₹ ${transaction1['amount']}",
                                                      style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 60,
                                                  color: Colors.white,
                                                  // Add your content for the third part here
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))));
                        } else if (index < transactionsYouGot.length) {
                          // Render items only from youGot collection
                          var transaction2 = transactionsYouGot[index].data()
                              as Map<String, dynamic>?;
                          String formattedTimestamp2 =
                              DateFormat('dd MMM yy * hh:mm a')
                                  .format(transaction2?['timestamp'].toDate());
                          // Your code to render items from youGot collection goes here
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  // Container styling for youGave items
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EntryDetails(
                                                        Amount:
                                                            '${transaction2['amount']}',
                                                        number: widget.name,
                                                      )));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 4,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: 60,
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "$formattedTimestamp2",
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 11),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        color:
                                                            Colors.red.shade100,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          child: Text(
                                                            "Bal. ₹  ${transaction2!['balance'] ?? ""}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 60,
                                                  color: Colors.transparent,
                                                  child: const Center(
                                                    child: Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 60,
                                                  color: Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                    "₹ ${transaction2['amount']}",
                                                    style: const TextStyle(
                                                        color: Colors.green),
                                                  )),
                                                  // Add your content for the third part here
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))));
                        }
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
