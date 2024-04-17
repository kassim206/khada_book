import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khada_book/firebaseconstants.dart';
import 'package:khada_book/loginpagee.dart';
import 'package:khada_book/model/accountusermodel.dart';
import 'package:khada_book/view/bottom_navbar/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      final String? userUid = prefs.getString('userUid');
      if (userUid != null) {
        // Fetch user details from Firestore
        usersmodel = await getUser(userUid);

        // Update lastLogged time in Firestore
        if (usersmodel != null) {
          final updatedData = usersmodel!.copyWith(lastLogged: DateTime.now());
          FirebaseFirestore.instance
              .collection(FirebaseConstants.user)
              .doc(userUid)
              .update(updatedData.toJson());
        }
      }
    }

    // Navigate to the appropriate screen after a delay
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        // isLoggedIn
            // ? MaterialPageRoute(builder: (context) => BasicBottomNavBar(uid: '',))
             MaterialPageRoute(builder: (context) => LoginPage()),
            // (route) => false,
      );
    });
  }

  Future<UsersModel?> getUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      print("User exists");
      final data = UsersModel.fromJson(snapshot.data()!);
      return data;
    } else {
      print("User not found");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/SS.png', width: 70, height: 100),
                Text(
                  'SherCash',
                  style: GoogleFonts.aBeeZee(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}