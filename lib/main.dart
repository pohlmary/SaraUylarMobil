import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/colors.dart';
import 'constants/themes.dart';
import 'providers/theme_provider.dart';
import 'widgets/responsive_layout.dart';
import 'pages/home_page.dart';
import 'pages/desktop_layout.dart';
import 'pages/search_page.dart';
import 'pages/favorites_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/add_listing_page.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: SaraUylarApp(),
    ),
  );
}

class SaraUylarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Sara Uylar',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _mobilePages = [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    AddListingPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      desktop: DesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: _mobilePages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark 
            ? AppColors.darkGreyText 
            : AppColors.greyText,
        backgroundColor: Theme.of(context).cardColor,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Uylar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Izlash',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saqlanganlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'E\'lon berish',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}