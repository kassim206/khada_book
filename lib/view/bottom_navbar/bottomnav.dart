import 'package:flutter/material.dart';
import 'package:khada_book/view/Home/More.dart';
import '../Home/home_page.dart';

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(), 
   
   More()
  
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        selectedItemColor: Colors.indigo,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, ),
            label: 'HOME',
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined,),
            label: 'MORE',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
