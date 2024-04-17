import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khada_book/loginpagee.dart';
import 'package:khada_book/view/Home/buisinesscard.dart';
import 'package:khada_book/view/Home/cashbook.dart';


class More extends StatefulWidget {
   More({Key? key,required this.uid}) : super(key: key);
String uid;
  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  int _selectedIndex = 0;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        actions: [  GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Center(
                      child: Column(
                        children: [
                          Text(
                            "Logout",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Are You Sure?",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.indigo),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                minimumSize: Size(128, 46),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                textStyle: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16), // Adjust spacing between buttons
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await auth1.signOut(context);
                                // Handle sign-out and navigation here
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Colors.red),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                minimumSize: Size(128, 46),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                
             
              ),
              child: Icon(
                Icons.logout,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const CircleAvatar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo,
              child: Text("M"),
            ),
            title: const Text(
              "  My Business",
              style: TextStyle(fontSize: 17),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.indigo,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                "Edit",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(255, 231, 228, 228),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 231, 228, 228),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            // _showBottomSheet(context);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BuisinessCard(userid: widget.uid,)));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              width: 120,
                              height: 145,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green[50],
                                    radius: 28,
                                    child: const FaIcon(
                                      FontAwesomeIcons.idCard,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Business\n   Card",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  Cashbook(customerId: '',
                                userId: widget.uid)));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              width: 120,
                              height: 145,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.blue[50],
                                      radius: 28,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue,
                                                  width: 2)),
                                          child: const Icon(
                                            Icons.currency_rupee_outlined,
                                            color: Colors.blue,
                                          ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Cashbook",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
                ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      context: context,
      builder: (BuildContext context) {
        return
         Container(
          color: Colors.white,
          height: 350,
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Business Card",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.indigo,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(),
            Expanded(
              child: Container(
                child: _buildCarouselSlider(),
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(8)),
                      foregroundColor: Colors.indigo,
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // _downloadBusinessCard(context, _selectedIndex);
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download),
                        SizedBox(
                          width: 10,
                        ),
                        Text("DOWNLOAD"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
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
                        Icon(Icons.share),
                        SizedBox(
                          width: 10,
                        ),
                        Text("SHARE"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        );
      },
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      items: [
        _buildCarouselItem("images/Bcardimg1.jpg", "My Business", "987654321",
            "Add Business Address"),
        _buildCarouselItem("images/Bcardimg2.jpg", "Slide 2", "987654321", ""),
        _buildCarouselItem("images/Bcardimg3.webp", "Slide 3", "987654321", ""),
      ],
      options: CarouselOptions(
        height: 180.0,
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlay: false,
        onPageChanged: (index, reason) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCarouselItem(
      String imagePath, String title1, String title2, String title3) {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[100],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title1,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      Text(
                        title2,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Name", style: TextStyle(fontSize: 10)),
                      Text(title3, style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text("Add Business Address", style: TextStyle(fontSize: 11))
            ],
          ),
        ),
      ),
    );
  }

  //   Future<Uint8List> _captureWidgetToImage() async {
  //   RenderRepaintBoundary boundary =
  //       _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   return byteData!.buffer.asUint8List();
  // }
//  Future<Uint8List> _downloadBusinessCard(BuildContext context, int selectedIndex) async {
//   try {
//     final RenderRepaintBoundary? boundary = _findBoundaryOfIndex(context, selectedIndex);
//     if (boundary != null) {
//       ui.Image image = await boundary.toImage(pixelRatio: MediaQuery.of(context).devicePixelRatio);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
//       final Directory? directory = await getExternalStorageDirectory();
//       if (directory != null) {
//         final String directoryPath = directory.path;
//         final String filePath = '$directoryPath/business_card.png';
//         final File imageFile = File(filePath);
//         await imageFile.writeAsBytes(byteData!.buffer.asUint8List());
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Business card saved to $filePath')));
//       } else {
//         throw Exception('External storage directory is null');
//       }
      
//       return byteData.buffer.asUint8List();
//     } else {
//       throw Exception('RenderRepaintBoundary not found');
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save business card: $e')));
//     return Uint8List(0); // Return an empty Uint8List in case of failure
//   }
// }

//   RenderRepaintBoundary? _findBoundaryOfIndex(BuildContext context, int index) {
//   RenderRepaintBoundary? foundBoundary;

//   // Function to recursively search for RenderRepaintBoundary in the widget tree
//   void searchForBoundary(RenderObject? renderObject) {
//     if (renderObject is RenderRepaintBoundary) {
//       // Check if the current RenderRepaintBoundary corresponds to the selected index
//       if (renderObject.debugNeedsLayout && renderObject.hashCode == index) {
//         foundBoundary = renderObject;
//       }
//     } else if (renderObject is RenderObject) {
//       // Continue searching recursively in the children
//       renderObject.visitChildren((child) {
//         searchForBoundary(child);
//       });
//     }
//   }

//   // Start searching from the root of the widget tree
//   searchForBoundary(context.findRenderObject());

//   return foundBoundary;
// }
}
