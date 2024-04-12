import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditEntry extends StatefulWidget {
  EditEntry({super.key, required this.amount, required this.color});
  String amount;
  Color color;
  @override
  State<EditEntry> createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  String? _pickedImagePath; // State to hold the picked image path
  DateTime? _selectedDate;
  TextEditingController _amtController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _amtController.text = widget.amount;
  }

  @override
  void dispose() {
    _amtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              title: const Text(
                'Exit without saving?',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              content: const Text('Changes will not be saved'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        return exit;
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor:
              widget.color == Colors.red ? Colors.red : Colors.green,
          title: widget.color == Colors.red
              ? Text(
                  "You gave ₹ ${widget.amount} to KassimSherSoft",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              : Text(
                  "You got ₹ ${widget.amount} from KassimSherSoft",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _amtController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: widget.color == Colors.red
                              ? const Icon(
                                  Icons.currency_rupee_outlined,
                                  color: Colors.redAccent,
                                )
                              : const Icon(
                                  Icons.currency_rupee_outlined,
                                  color: Colors.green,
                                ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText:
                              'Enter details (Items,bill no.,quantity,etc.)',
                          hintStyle: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (_pickedImagePath != null)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add Bill No.",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: widget.color == Colors.red
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(_selectedDate != null
                                          ? DateFormat('dd MMM yy')
                                              .format(_selectedDate!)
                                          : "Select Date")),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: widget.color == Colors.red
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _showImagePicker(context);
                          },
                          child: Card( color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: _pickedImagePath != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Image.file(
                                          File(_pickedImagePath!),
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: widget.color == Colors.red
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: widget.color == Colors.red
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text("Attach bills"),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: widget.color == Colors.red
                              ? Colors.pink
                              : Colors.green,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 20),
                    child: Text(
                      "Select Photo",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 136, 34, 2)),
                    ),
                  ),
                ],
              ),
              Wrap(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.indigo,
                    ),
                    title: const Text('Take a picture'),
                    onTap: () {
                      _pickImage(
                        ImageSource.camera,
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.photo,
                      color: Colors.indigo,
                    ),
                    title: const Text('Choose from gallery'),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  // Add more options here
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    // Handle picked image
    if (pickedImage != null) {
      // Update the state with the picked image path
      setState(() {
        _pickedImagePath = pickedImage.path;
      });
      print('Image picked: ${pickedImage.path}');
    }
  }
}
