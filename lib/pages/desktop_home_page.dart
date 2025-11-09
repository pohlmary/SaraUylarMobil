import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/house.dart';
import '../widgets/responsive_layout.dart';
import 'house_details_page.dart';
import 'desktop_house_details.dart';

class DesktopHomePage extends StatelessWidget {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
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
                      _buildSidebarItem(Icons.home, 'Bosh sahifa', true),
                      _buildSidebarItem(Icons.search, 'Izlash', false),
                      _buildSidebarItem(Icons.favorite, 'Saqlanganlar', false),
                      _buildSidebarItem(Icons.add_circle, 'E\'lon berish', false),
                      _buildSidebarItem(Icons.person, 'Profil', false),
                      _buildSidebarItem(Icons.settings, 'Sozlamalar', false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
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
                            decoration: InputDecoration(
                              hintText: 'Manzil yoki turini kiriting...',
                              prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                              suffixIcon: Icon(Icons.tune, color: AppColors.primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        icon: Icon(Icons.notifications_outlined),
                        onPressed: () {},
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Content area
                Expanded(
                  child: Container(
                    color: AppColors.secondaryColor,
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Uy-joylar',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.grid_view),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.view_list),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              childAspectRatio: 1.2,
                            ),
                            itemCount: houses.length * 3,
                            itemBuilder: (context, index) {
                              final house = houses[index % houses.length];
                              return _buildHouseCard(context, house);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, bool isActive) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.primaryColor : AppColors.greyText,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primaryColor : AppColors.greyText,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isActive,
        selectedTileColor: AppColors.primaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {},
      ),
    );
  }

  Widget _buildHouseCard(BuildContext context, House house) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (ResponsiveLayout.isDesktop(context)) {
            showDialog(
              context: context,
              builder: (context) => DesktopHouseDetails(house: house),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HouseDetailsPage(house: house),
              ),
            );
          }
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
                                color: AppColors.secondaryColor,
                                child: Icon(Icons.home, size: 80, color: AppColors.greyText),
                              );
                            },
                          )
                        : Container(
                            width: double.infinity,
                            color: AppColors.secondaryColor,
                            child: Icon(Icons.home, size: 80, color: AppColors.greyText),
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
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.favorite_border, color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      house.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      house.address.street,
                      style: TextStyle(color: AppColors.greyText, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.bed, size: 16, color: AppColors.greyText),
                        SizedBox(width: 4),
                        Text('${house.rooms}', style: TextStyle(fontSize: 14)),
                        SizedBox(width: 12),
                        Icon(Icons.square_foot, size: 16, color: AppColors.greyText),
                        SizedBox(width: 4),
                        Text('${house.area}m²', style: TextStyle(fontSize: 14)),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: house.category == Category.sotuv 
                                ? Colors.green.withOpacity(0.1)
                                : Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            house.category == Category.sotuv ? 'Sotuv' : 'Ijara',
                            style: TextStyle(
                              fontSize: 12,
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
}