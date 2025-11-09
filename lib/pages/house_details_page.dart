import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/house.dart';

class HouseDetailsPage extends StatelessWidget {
  final House house;

  const HouseDetailsPage({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: house.images.isNotEmpty
                  ? Image.network(
                      house.images[0],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? AppColors.darkSecondary 
                              : AppColors.secondaryColor,
                          child: Icon(Icons.home, size: 100, 
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
                      child: Icon(Icons.home, size: 100, 
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? AppColors.darkGreyText 
                              : AppColors.greyText),
                    ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          house.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$${house.price.toInt()}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, 
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? AppColors.darkGreyText 
                              : AppColors.greyText, 
                          size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${house.address.city}, ${house.address.street}',
                        style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark 
                                ? AppColors.darkGreyText 
                                : AppColors.greyText),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoCard(context, Icons.bed, '${house.rooms}', 'Xonalar'),
                      SizedBox(width: 12),
                      _buildInfoCard(context, Icons.square_foot, '${house.area}', 'm²'),
                      SizedBox(width: 12),
                      _buildInfoCard(
                        context,
                        Icons.sell,
                        house.category == Category.sotuv ? 'Sotuv' : 'Ijara',
                        'Turi',
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Tavsif',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    house.description,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? AppColors.darkGreyText 
                            : AppColors.greyText, 
                        height: 1.5),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Joylashuv',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? AppColors.darkSecondary 
                          : AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 50, 
                              color: Theme.of(context).brightness == Brightness.dark 
                                  ? AppColors.darkGreyText 
                                  : AppColors.greyText),
                          Text('Xarita', style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark 
                                  ? AppColors.darkGreyText 
                                  : AppColors.greyText)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Uy egasi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Uy egasi', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Agent', style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.dark 
                                        ? AppColors.darkGreyText 
                                        : AppColors.greyText)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.phone, color: AppColors.primaryColor),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.message, color: AppColors.primaryColor),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Qo\'ng\'iroq qilish', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(color: AppColors.primaryColor),
                ),
                child: Text('Xabar yuborish', style: TextStyle(color: AppColors.primaryColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark 
              ? AppColors.darkSecondary 
              : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryColor),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkGreyText 
                    : AppColors.greyText, 
                fontSize: 12)),
          ],
        ),
      ),
    );
  }
}