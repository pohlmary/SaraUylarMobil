import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/house.dart';
import 'house_details_page.dart';

class HomePage extends StatelessWidget {
  final List<House> houses = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? AppColors.darkBackground 
          : AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Sara Uylar', style: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColors.textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
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
                fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkSecondary 
                    : AppColors.secondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: houses.length,
                itemBuilder: (context, index) {
                  final house = houses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HouseDetailsPage(house: house),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
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
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '\$${house.price.toInt()}',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${house.name} saqlanganlarga qo\'shildi')),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(12),
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
                              padding: EdgeInsets.all(8),
                              child: Column(
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
                                    style: TextStyle(color: AppColors.greyText, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.bed, size: 14, color: AppColors.greyText),
                                      SizedBox(width: 4),
                                      Text('${house.rooms}', style: TextStyle(fontSize: 12)),
                                      SizedBox(width: 8),
                                      Icon(Icons.square_foot, size: 14, color: AppColors.greyText),
                                      SizedBox(width: 4),
                                      Text('${house.area}m²', style: TextStyle(fontSize: 12)),
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}