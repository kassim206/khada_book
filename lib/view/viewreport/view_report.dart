import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewReport extends StatefulWidget {
  const ViewReport({super.key});

  @override
  State<ViewReport> createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          "View Report",
          style: TextStyle(fontSize: 17),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white),
          onPressed: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.picture_as_pdf_outlined),
              SizedBox(
                width: 10,
              ),
              Text("DOWNLOAD"),
            ],
          ),
        ),
      ),
      body: Column(children: [
        Container(
          height: 150,
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
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          _selectStartDate(context);
                        },
                        child: const Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              size: 18,
                              color: Colors.black54,
                            ),
                            Text("  START DATE",
                                style: TextStyle(
                                    color: Colors.indigo, fontSize: 13)),
                          ],
                        )),
                      )),
                      Container(
                        width: 1,
                        color: Colors.black12,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          _selectEndDate(context);
                        },
                        child: const Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              size: 18,
                              color: Colors.black54,
                            ),
                            Text("  END DATE",
                                style: TextStyle(
                                    color: Colors.indigo, fontSize: 13)),
                          ],
                        )),
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 60,
                  color: Colors.white,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.indigo,
                        ),
                        hintStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                        hintText: "Search Entries"),
                  ),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Net Balance",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(
                "₹ 75",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ],
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
                    Text("TOTAL", style: TextStyle(fontSize: 10)),
                    Text("1 Entries",
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
                      Text("YOU GAVE", style: TextStyle(fontSize: 10)),
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
                      Text("YOU GOT", style: TextStyle(fontSize: 10)),
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
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(0),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 60,
                      width: 140,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Saleel"),
                                Text(
                                  "11 Mar 24 . 05:03 PM",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color.fromARGB(255, 230, 219, 222),
                      height: 60,
                      width: 100,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Text("₹ 88"),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text("₹ 88"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  DateTime? _selectedstartDate;
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedstartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedstartDate) {
      setState(() {
        _selectedstartDate = picked;
      });
    }
  }  DateTime? _selectedEndDate;
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }
}
