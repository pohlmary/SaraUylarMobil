import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/theme_provider.dart';
import '../models/house.dart';
import 'desktop_house_details.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'add_listing_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';

class DesktopLayout extends StatefulWidget {
  @override
  _DesktopLayoutState createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String? _selectedCategory;
  int? _selectedRooms;
  bool _isGridView = true;

  final List<House> houses = [
    House(
      id: '1',
      name: '3 xonali kvartira',
      description: 'Yangi ta\'mirlangan, jihozlangan, markazda joylashgan',
      address: Address(region: 'Toshkent', city: 'Toshkent', street: 'Chilonzor 9-kvartal'),
      price: 250000,
      category: Category.sotuv,
      area: 85,
      rooms: 3,
      images: ['https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=400'],
      ownerId: 'user1',
      createdAt: DateTime.now(),
      status: Status.aktiv,
    ),
    House(
      id: '2',
      name: 'Hovli uy',
      description: 'Katta hovli, garaj bor, tinch hudud',
      address: Address(region: 'Toshkent', city: 'Toshkent', street: 'Sergeli tumani'),
      price: 1500,
      category: Category.ijara,
      area: 120,
      rooms: 4,
      images: ['https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=400'],
      ownerId: 'user2',
      createdAt: DateTime.now(),
      status: Status.aktiv,
    ),
    House(
      id: '3',
      name: 'Penthouse',
      description: 'Lux darajadagi kvartira, tom qavat',
      address: Address(region: 'Toshkent', city: 'Toshkent', street: 'Yunusobod 12-kvartal'),
      price: 450000,
      category: Category.sotuv,
      area: 150,
      rooms: 5,
      images: ['https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400'],
      ownerId: 'user3',
      createdAt: DateTime.now(),
      status: Status.aktiv,
    ),
  ];

  List<House> get filteredHouses {
    return houses.where((house) {
      bool matchesSearch = _searchQuery.isEmpty || 
          house.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          house.address.street.toLowerCase().contains(_searchQuery.toLowerCase());
      
      bool matchesCategory = _selectedCategory == null ||
          (_selectedCategory == 'Sotuv' && house.category == Category.sotuv) ||
          (_selectedCategory == 'Ijara' && house.category == Category.ijara);
      
      bool matchesRooms = _selectedRooms == null || house.rooms == _selectedRooms;
      
      return matchesSearch && matchesCategory && matchesRooms;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(Icons.home, color: AppColors.primaryColor, size: 32),
                SizedBox(width: 12),
                Text(
                  'Sara Uylar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildSidebarItem(Icons.home, 'Bosh sahifa', 0),
                _buildSidebarItem(Icons.search, 'Izlash', 1),
                _buildSidebarItem(Icons.favorite, 'Saqlanganlar', 2),
                _buildSidebarItem(Icons.add_circle, 'E\'lon berish', 3),
                _buildSidebarItem(Icons.person, 'Profil', 4),
                _buildSidebarItem(Icons.settings, 'Sozlamalar', 5),
                SizedBox(height: 20),
                _buildThemeToggle(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    bool isActive = _selectedIndex == index;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.primaryColor : 
              (Theme.of(context).brightness == Brightness.dark 
                  ? AppColors.darkGreyText 
                  : AppColors.greyText),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primaryColor : 
                (Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkGreyText 
                    : AppColors.greyText),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isActive,
        selectedTileColor: AppColors.primaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ListTile(
            leading: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: AppColors.primaryColor,
            ),
            title: Text('Tungi rejim'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(),
              activeColor: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildSearchPage();
      case 2:
        return _buildFavoritesPage();
      case 3:
        return _buildAddListingPage();
      case 4:
        return _buildProfilePage();
      case 5:
        return _buildSettingsPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark 
                ? AppColors.darkBackground 
                : AppColors.secondaryColor,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Uy-joylar (${filteredHouses.length})',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.grid_view, 
                              color: _isGridView ? AppColors.primaryColor : AppColors.greyText),
                          onPressed: () {
                            setState(() {
                              _isGridView = true;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.view_list,
                              color: !_isGridView ? AppColors.primaryColor : AppColors.greyText),
                          onPressed: () {
                            setState(() {
                              _isGridView = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Expanded(
                  child: _isGridView
                      ? GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: filteredHouses.length,
                          itemBuilder: (context, index) {
                            return _buildHouseCard(filteredHouses[index]);
                          },
                        )
                      : ListView.builder(
                          itemCount: filteredHouses.length,
                          itemBuilder: (context, index) {
                            return _buildHouseListItem(filteredHouses[index]);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Manzil yoki turini kiriting...',
                  prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                      ? AppColors.darkSecondary 
                      : AppColors.secondaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          _buildFilterDropdown(),
          SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bildirishnomalar')),
              );
            },
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'),
            backgroundColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.tune, color: AppColors.primaryColor),
      onSelected: (value) {
        setState(() {
          if (value == 'Sotuv' || value == 'Ijara') {
            _selectedCategory = value;
          } else if (value.contains('xona')) {
            _selectedRooms = int.tryParse(value.split(' ')[0]);
          } else if (value == 'Tozalash') {
            _selectedCategory = null;
            _selectedRooms = null;
          }
        });
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Sotuv', child: Text('Sotuv')),
        PopupMenuItem(value: 'Ijara', child: Text('Ijara')),
        PopupMenuDivider(),
        PopupMenuItem(value: '1 xona', child: Text('1 xona')),
        PopupMenuItem(value: '2 xona', child: Text('2 xona')),
        PopupMenuItem(value: '3 xona', child: Text('3 xona')),
        PopupMenuItem(value: '4 xona', child: Text('4 xona')),
        PopupMenuItem(value: '5 xona', child: Text('5+ xona')),
        PopupMenuDivider(),
        PopupMenuItem(value: 'Tozalash', child: Text('Filterni tozalash')),
      ],
    );
  }

  Widget _buildHouseCard(House house) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => DesktopHouseDetails(house: house),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: house.images.isNotEmpty
                        ? Image.network(
                            house.images[0],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? AppColors.darkSecondary 
                                    : AppColors.secondaryColor,
                                child: Icon(Icons.home, size: 60, 
                                    color: Theme.of(context).brightness == Brightness.dark 
                                        ? AppColors.darkGreyText 
                                        : AppColors.greyText),
                              );
                            },
                          )
                        : Container(
                            width: double.infinity,
                            color: Theme.of(context).brightness == Brightness.dark 
                                ? AppColors.darkSecondary 
                                : AppColors.secondaryColor,
                            child: Icon(Icons.home, size: 60, 
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? AppColors.darkGreyText 
                                    : AppColors.greyText),
                          ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        '\$${house.price.toInt()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${house.name} saqlanganlarga qo\'shildi')),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.favorite_border, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          house.name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          house.address.street,
                          style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark 
                                  ? AppColors.darkGreyText 
                                  : AppColors.greyText, 
                              fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.bed, size: 14, 
                            color: Theme.of(context).brightness == Brightness.dark 
                                ? AppColors.darkGreyText 
                                : AppColors.greyText),
                        SizedBox(width: 4),
                        Text('${house.rooms}', style: TextStyle(fontSize: 12)),
                        SizedBox(width: 8),
                        Icon(Icons.square_foot, size: 14, 
                            color: Theme.of(context).brightness == Brightness.dark 
                                ? AppColors.darkGreyText 
                                : AppColors.greyText),
                        SizedBox(width: 4),
                        Text('${house.area}m²', style: TextStyle(fontSize: 12)),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: house.category == Category.sotuv 
                                ? Colors.green.withOpacity(0.1)
                                : Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            house.category == Category.sotuv ? 'Sotuv' : 'Ijara',
                            style: TextStyle(
                              fontSize: 10,
                              color: house.category == Category.sotuv 
                                  ? Colors.green[700]
                                  : Colors.blue[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchPage() {
    return SearchPage();
  }

  Widget _buildFavoritesPage() {
    return FavoritesPage();
  }

  Widget _buildAddListingPage() {
    return AddListingPage();
  }

  Widget _buildProfilePage() {
    return ProfilePage();
  }

  Widget _buildSettingsPage() {
    return SettingsPage();
  }

  Widget _buildHouseListItem(House house) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => DesktopHouseDetails(house: house),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 120,
                  height: 120,
                  child: house.images.isNotEmpty
                      ? Image.network(
                          house.images[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.secondaryColor,
                              child: Icon(Icons.home, size: 40, color: AppColors.greyText),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.secondaryColor,
                          child: Icon(Icons.home, size: 40, color: AppColors.greyText),
                        ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      house.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      house.address.street,
                      style: TextStyle(color: AppColors.greyText, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.bed, size: 16, color: AppColors.greyText),
                        SizedBox(width: 4),
                        Text('${house.rooms}'),
                        SizedBox(width: 16),
                        Icon(Icons.square_foot, size: 16, color: AppColors.greyText),
                        SizedBox(width: 4),
                        Text('${house.area}m²'),
                        Spacer(),
                        Text(
                          '\$${house.price.toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}