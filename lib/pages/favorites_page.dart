import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/house.dart';
import 'house_details_page.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<House> favoriteHouses = [
    House(
      id: '1',
      name: '3 xonali kvartira',
      description: 'Yangi ta\'mirlangan, jihozlangan',
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
      description: 'Katta hovli, garaj bor',
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
      description: 'Lux darajadagi kvartira',
      address: Address(region: 'Toshkent', city: 'Toshkent', street: 'Yunusobod'),
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

  String _sortBy = 'Sana bo\'yicha';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saqlanganlar'),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
                _sortHouses();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Sana bo\'yicha', child: Text('Sana bo\'yicha')),
              PopupMenuItem(value: 'Narx bo\'yicha', child: Text('Narx bo\'yicha')),
              PopupMenuItem(value: 'Nom bo\'yicha', child: Text('Nom bo\'yicha')),
            ],
          ),
        ],
      ),
      body: favoriteHouses.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildHousesList()),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, 
              color: Theme.of(context).brightness == Brightness.dark 
                  ? AppColors.darkGreyText 
                  : AppColors.greyText),
          SizedBox(height: 16),
          Text(
            'Hali saqlangan uylar yo\'q',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Yoqtirgan uylaringizni saqlang',
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkGreyText 
                    : AppColors.greyText),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to home page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Uylarni ko\'rish', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${favoriteHouses.length} ta saqlangan uy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Saralash: $_sortBy',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? AppColors.darkGreyText 
                  : AppColors.greyText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHousesList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoriteHouses.length,
      itemBuilder: (context, index) {
        final house = favoriteHouses[index];
        return _buildHouseCard(house, index);
      },
    );
  }

  Widget _buildHouseCard(House house, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HouseDetailsPage(house: house),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 100,
                      height: 100,
                      child: house.images.isNotEmpty
                          ? Image.network(
                              house.images[0],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Theme.of(context).brightness == Brightness.dark 
                                      ? AppColors.darkSecondary 
                                      : AppColors.secondaryColor,
                                  child: Icon(Icons.home, 
                                      color: Theme.of(context).brightness == Brightness.dark 
                                          ? AppColors.darkGreyText 
                                          : AppColors.greyText),
                                );
                              },
                            )
                          : Container(
                              color: Theme.of(context).brightness == Brightness.dark 
                                  ? AppColors.darkSecondary 
                                  : AppColors.secondaryColor,
                              child: Icon(Icons.home, 
                                  color: Theme.of(context).brightness == Brightness.dark 
                                      ? AppColors.darkGreyText 
                                      : AppColors.greyText),
                            ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                house.name,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
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
                        SizedBox(height: 4),
                        Text(
                          house.address.street,
                          style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark 
                                  ? AppColors.darkGreyText 
                                  : AppColors.greyText),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.bed, size: 16, 
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? AppColors.darkGreyText 
                                    : AppColors.greyText),
                            SizedBox(width: 4),
                            Text('${house.rooms}'),
                            SizedBox(width: 12),
                            Icon(Icons.square_foot, size: 16, 
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? AppColors.darkGreyText 
                                    : AppColors.greyText),
                            SizedBox(width: 4),
                            Text('${house.area}m²'),
                            Spacer(),
                            Text(
                              '\$${house.price.toInt()}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Uy egasiga qo\'ng\'iroq qilish')),
                        );
                      },
                      icon: Icon(Icons.phone, size: 16),
                      label: Text('Qo\'ng\'iroq'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Xabar yuborish')),
                        );
                      },
                      icon: Icon(Icons.message, size: 16),
                      label: Text('Xabar'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _removeFromFavorites(index),
                    icon: Icon(Icons.favorite, color: Colors.red),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeFromFavorites(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Olib tashlash'),
        content: Text('Bu uyni saqlanganlardan olib tashlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                favoriteHouses.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Saqlanganlardan olib tashlandi'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: Text('Olib tashlash', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _sortHouses() {
    switch (_sortBy) {
      case 'Narx bo\'yicha':
        favoriteHouses.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Nom bo\'yicha':
        favoriteHouses.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Sana bo\'yicha':
      default:
        favoriteHouses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }
  }
}