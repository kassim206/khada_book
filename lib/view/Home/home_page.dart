import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:intl/intl.dart';
import 'package:khada_book/view/Home/transaction.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:khada_book/view/Home/transaction.dart' as MyTransaction;
import 'package:timeago/timeago.dart' as timeago;

import '../../model/user_model.dart';
import '../viewreport/view_report.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  List<Contact> filteredContacts = [];
  // List<Contact> selectedContacts = []; // List to store selected contacts
  String? relativeTime;
  String ?docId;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ScrollingFabAnimated(
        color: Colors.indigo,
        width: 140,
        height: 50,
        icon: const Icon(
          Icons.person_add,
          color: Colors.white,
          size: 20,
        ),
        text: const Text(
          'Add Customer',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
        onPress: () {
          _openContacts();
        },
        scrollController: _scrollController,
        animateIcon: true,
        inverted: false,
        radius: 10.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 50,
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "You Will give",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "₹ 368",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "You Will get",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "₹ 20",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewReport()));
                      },
                      child: const Text(
                        "View Report >",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    // Add your onTap logic here
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books,
                          color: Colors.indigo,
                        ),
                        Text(
                          "   OPEN CASHBOOK",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white, // Set the background color to white
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: CupertinoSearchTextField(
                  backgroundColor: Colors.white.withOpacity(0.4),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.black),
                  suffixIcon: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.grey,
                  ),
                ),
              ),

              // ListView.builder(
              //     padding: const EdgeInsets.all(0),
              //     shrinkWrap: true,
              //     controller: ScrollController(),
              //     itemCount: selectedContacts.length,
              //     itemBuilder: (BuildContext context, index) {
              //       return Column(
              //         children: [
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           Container(
              //             child: Card(
              //               child: ListTile(
              //                 onTap: () {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder: (context) => MyTransaction.Transaction(
              //                         name: selectedContacts[index].displayName ?? "",
              //                         number: _getPhoneNumber(selectedContacts[index]),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //                 tileColor: Colors.white,
              //                 leading: const CircleAvatar(
              //                   backgroundColor: Colors.blue,
              //                   backgroundImage: NetworkImage(
              //                       'https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp'),
              //                 ),
              //                 trailing: const Text(
              //                   "₹ 10",
              //                   style: TextStyle(
              //                       fontSize: 13, color: Colors.green),
              //                 ),
              //                 title: Text(
              //                     "${selectedContacts[index].displayName}" ??
              //                         ''),
              //                 subtitle: Text(
              //                   "${relativeTime}",
              //                   style: const TextStyle(fontSize: 10),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       );
              //     }),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Customers').orderBy("createDate", descending :true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator while data is being fetched
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  // Extract documents from snapshot
                  var documents = snapshot.data!.docs;

                  return
                  ListView.builder(
                    controller: ScrollController(),
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, index) {
                      print('${documents[index].id}');
                      var selectedContact = documents[index].data() as Map<String, dynamic>?; // Get data for the current document
                      String customerId = documents[index].id;
                      DateTime? createDate = selectedContact?['createDate'] != null
                          ? (selectedContact?['createDate'] as Timestamp).toDate()
                          : null;

                      // Formatting the DateTime object to a string in the desired format
                      String formattedCreateDate = createDate != null
                          ? DateFormat('dd/MM/yy HH:mm').format(createDate)
                          : '';

                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MyTransaction.Transaction(
                                        customerId: customerId,
                                        name:selectedContact?['userName'] ?? "" ?? "",
                                        number:selectedContact?['contactNumber'] ?? "" ?? "", // Casting to Contact type
                                      ),
                                    ),
                                  );
                                },
                                tileColor: Colors.white,
                                leading: CircleAvatar(
                                  backgroundImage: selectedContact?['avatar'] != null
                                      ? NetworkImage(selectedContact?['avatar'] ?? '') // Load avatar image if available
                                      : null, // No background image if avatar is not available
                                  backgroundColor: selectedContact?['avatar'] == null
                                      ? Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0) // Generate a random color if avatar is not available
                                      : null, // No background color if avatar image is available
                                  child: selectedContact?['avatar'] == null
                                      ? Text(
                                    selectedContact?['userName']?[0] ?? '', // Display first letter of the user's name
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                  )
                                      : null, // No child if avatar image is available
                                ),
                                trailing: const Text(
                                  "₹ 10",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.green),
                                ),
                                title: Text(selectedContact?['userName'] ?? ""),
                                subtitle:   Text(formattedCreateDate,style: TextStyle(fontSize: 10,color: Colors.grey),),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }

  void _openContacts() async {
    // Request permission to access contacts
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      // Fetch contacts
      Iterable<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);

      // If there are contacts, display an AlertDialog
      if (contacts.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            List<Contact> filteredContacts =
                List.from(contacts); // Copy original contacts list
            TextEditingController searchController = TextEditingController();

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                void filterContacts(String query) {
                  setState(() {
                    filteredContacts = contacts.where((contact) {
                      final displayName = contact.displayName!.toLowerCase();
                      final phoneNumber =
                          _getPhoneNumber(contact).toLowerCase();
                      final searchLower = query.toLowerCase();

                      return displayName.contains(searchLower) ||
                          phoneNumber.contains(searchLower);
                    }).toList();
                  });
                }

                return Scaffold(
                  appBar: AppBar(
                    title: Text('Select a contact'),
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchController,
                          onChanged: filterContacts,
                          decoration: InputDecoration(
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListBody(
                            children: filteredContacts.map((contact) {
                              return ListTile(
                                leading: CircleAvatar(
                              backgroundColor: contact.avatar != null && contact.avatar!.isNotEmpty
                              ? null // No need for background color if avatar image is available
                                  : _generateRandomColor(), // Generate random color if avatar image is not available

                              child: contact.avatar == null || contact.avatar!.isEmpty
                              ? Text(
                              contact.displayName != null && contact.displayName!.isNotEmpty
                              ? contact.displayName![0].toUpperCase()
                                  : '',
                              style: TextStyle(color: Colors.white),
                              )
                                  : null,
                              ),


                                title: Text(contact.displayName ?? '',
                                    style: TextStyle(fontSize: 13)),
                                subtitle: Text(_getPhoneNumber(contact),
                                    style: TextStyle(fontSize: 8)),
                                trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.indigo,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _addContact(contact);
                                  },
                                  child: Text("Add"),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      } else {
        // Show a message if no contacts are available
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('No contacts available'),
              content: Text('Your contact list is empty.'),
            );
          },
        );
      }
    } else {
      // Show a message if permission is denied
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission denied'),
            content: const Text('Please grant permission to access contacts.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // void _addContact(Contact contact) {
  //   // Add the selected contact to the list of selected contacts
  //   setState(() {
  //     selectedContacts.add(contact);
  //   });
  //   DateTime now = DateTime.now();
  //
  //   // Calculate the relative time
  //   relativeTime = timeago.format(now.subtract(const Duration(seconds: 2)));
  //
  //   // Show a message indicating that the contact has been added with relative time
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content:
  //           Text('Contact added ${relativeTime}  ${contact.displayName ?? ""}'),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }
  void _addContact(Contact contact) async {

    CustomersModel customer = CustomersModel(
      userName: contact.displayName,
      createDate: DateTime.now(), contactNumber:_getPhoneNumber(contact),
    );

    Map<String, dynamic> customerData = customer.toJson();

    DocumentReference docRef = await FirebaseFirestore.instance.collection('Customers').add(customerData);

    // Create a new CustomersModel instance

    // Convert CustomersModel to JSON

    try {

      // Add the customer data to the "Customers" collection in Firestore
      CustomersModel customer = CustomersModel(
        userName: contact.displayName,
        createDate: DateTime.now(), contactNumber:_getPhoneNumber(contact),
      );

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contact added to Firestore'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Show an error message if adding to Firestore fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add contact to Firestore'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

}
Color _generateRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
    1.0, // Opacity
  );
}
String _getPhoneNumber(Contact contact) {
  if (contact.phones!.isNotEmpty) {
    // Extracting the first phone number
    String phoneNumber = contact.phones!.first.value ?? '';
    return phoneNumber;
  } else {
    return ''; // Return an empty string if no phone number is available
  }
}
