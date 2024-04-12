import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khada_book/view/Home/CashbookReport.dart';

class Cashbook extends StatefulWidget {
  const Cashbook({super.key});

  @override
  State<Cashbook> createState() => _CashbookState();
}

class _CashbookState extends State<Cashbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("OUT"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.green,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("IN"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.blue[50],
                radius: 23,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2)),
                    child: const Icon(
                      Icons.currency_rupee_outlined,
                      color: Colors.blue,
                    ))),
            const Text(
              "   Cashbook",
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            color: Colors.indigo,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "₹ 50",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text("Today Balance"),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "₹ 50",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text("Today's Balance"),
                              ],
                            ),
                          ],
                        ),
                        Row(children: [
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cash in Hand",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          "Online",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "₹ 50",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          "₹ 0",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cash in Hand",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          "Online",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "₹ 50",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          "₹ 0",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ]),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    const CashbookReport())));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.call_to_action_outlined),
                              Text(
                                "   VIEW CASHBOOK REPORT",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 40,
                  width: 140,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("13 MAR", style: TextStyle(fontSize: 10)),
                      Text("1 Entry",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("OUT", style: TextStyle(fontSize: 12)),
                        Text("₹ 0",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 40,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("IN", style: TextStyle(fontSize: 12)),
                        Text("₹ 88",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //   const SizedBox(
          //     height: 50,
          //   ),
          //   Container(
          //     height: 100,
          //     child: Image.asset(
          //       "images/Entryimg.png",
          //       color: Colors.redAccent,
          //     ),
          //   ),
          //   const Text(
          //     "Hello ! Lets make today's entries",
          //     style: TextStyle(fontSize: 11),
          //   ),
          //   SizedBox(
          //     height: 90,
          //   ),
          //   Container(
          //     padding: const EdgeInsets.symmetric(vertical: 20),
          //     width: MediaQuery.of(context).size.width,
          //     color: Colors.blue[100],
          //     child: const Column(
          //       children: [
          //         Text("Add Your First Entry"),
          //         Icon(Icons.arrow_downward)
          //       ],
          //     ),
          //   )
          // ])
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 5,
          //     shrinkWrap: true,
          //     controller: ScrollController(),
          //     itemBuilder: (context, index) {

          //       return Container(
          //         decoration: const BoxDecoration(
          //             border: Border(bottom: BorderSide(color: Colors.black12))),
          //         child: Row(
          //           children: [
          //             const SizedBox(
          //               height: 60,
          //               width: 140,
          //               child: Row(
          //                 children: [
          //                   Padding(
          //                     padding: EdgeInsets.only(left: 10),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text(
          //                           "12:55 PM",
          //                           style: TextStyle(fontSize: 12),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Container(
          //               color: const Color.fromARGB(255, 230, 219, 222),
          //               height: 60,
          //               width: 100,
          //               child: const Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   Padding(
          //                     padding: EdgeInsets.only(right: 4.0),
          //                     child: Text(""),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             const Expanded(
          //               child: SizedBox(
          //                 height: 60,
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   children: [
          //                     Padding(
          //                       padding: EdgeInsets.only(right: 10),
          //                       child: Text(
          //                         "₹ 50",
          //                         style: TextStyle(color: Colors.green),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
