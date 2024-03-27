import 'package:flutter/material.dart';
import '../Home/home_page.dart';

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(), // Add your HomePage here
    Icon(
      Icons.monetization_on,
      size: 150,
      color: Colors.indigo,
    ),
    Icon(
      Icons.dashboard_outlined,
      size: 150,
    ),
    // Icon(
    //   Icons.chat,
    //   size: 150,
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Row(
        children: [
          Icon( Icons.book,color: Colors.white, ),
          const Text(' hello',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold
              ,color: Colors.white),),
          const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
        ],
      ),
      backgroundColor: Colors.indigo,
    ),
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
            icon: Icon(Icons.monetization_on, ),
            label: 'MONEY',
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
