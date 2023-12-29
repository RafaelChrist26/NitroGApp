import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tugas_layout/Login/login.dart';
import 'package:tugas_layout/firebase_options.dart';
import 'package:tugas_layout/pages/Myprofil/settingpage.dart';
import 'package:tugas_layout/pages/beranda.dart';
import 'package:tugas_layout/pages/games.dart';
import 'package:tugas_layout/pages/Myprofil/profil.dart';
import 'package:tugas_layout/pages/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 12, 12, 12)),
      // Set initialRoute to '/login' (LoginPage)
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), // Define the route for LoginPage
        '/home': (context) => MyHomePage(),
        '/settings': (context) =>  settingpage(), // Tambahkan rute untuk SettingsPage
        // Add routes for other pages if needed
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // final List<IconData> _icons = [
  //   Icons.home,
  //   Icons.games,
  //   Icons.store,
  //   Icons.person,
  // ];

  static List<Widget> _pages = <Widget>[
    berandaku(),
    Mygames(),
    Mystore(),
    Myprofile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'NitroGApp';
      case 1:
        return 'My Games';
      case 2:
        return 'My Store';
      case 3:
        return 'My Profile';
      default:
        return 'NitroGApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 5, 38, 66),
                  Color.fromARGB(255, 71, 2, 110),
                  Color.fromARGB(255, 0, 0, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: getAppBarTitle(),
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Aclonica',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            if (_selectedIndex == 3) // MyProfile
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Tambahkan logika logout di sini
                  // Contoh: Keluar dari akun dan kembali ke halaman login
                  Navigator.pushReplacementNamed(context, '/settings');
                },
              ),
          ],
        ),
        body: Center(
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 45, 46, 46),
          type: BottomNavigationBarType.fixed, // Set the type to fixed
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Color.fromARGB(255, 255, 255, 255),

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Icon(
                      Icons.home,
                    )
                  : Icon(
                      Icons.home_outlined,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? Image.asset(
                      'lib/icons/games.png',
                      width: 24, // Sesuaikan lebar sesuai kebutuhan
                      height: 24, // Sesuaikan tinggi sesuai kebutuhan
                      color: Colors.white,
                    )
                  : Image.asset(
                      'lib/icons/console.png',
                      width: 24, // Sesuaikan lebar sesuai kebutuhan
                      height: 24, // Sesuaikan tinggi sesuai kebutuhan
                      color: Colors.white,
                    ),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? Icon(
                      Icons.store,
                    )
                  : Icon(
                      Icons.store_outlined,
                    ),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? Image.asset(
                      'lib/icons/zeta.png',
                      width: 40, // Sesuaikan lebar sesuai kebutuhan
                      height: 35, // Sesuaikan tinggi sesuai kebutuhan
                    )
                  : Image.asset(
                      'lib/icons/zeta.png',
                      width: 40, // Sesuaikan lebar sesuai kebutuhan
                      height: 35, // Sesuaikan tinggi sesuai kebutuhan
                    ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label) {
    final isActive = index == _selectedIndex;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
