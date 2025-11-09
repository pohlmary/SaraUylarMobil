import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/house.dart';

class DesktopHouseDetails extends StatelessWidget {
  final House house;

  const DesktopHouseDetails({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 1000,
        height: 700,
        child: Row(
          children: [
            // Left side - Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                child: house.images.isNotEmpty
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
                            child: Center(
                              child: Icon(Icons.home, size: 150, 
                                  color: Theme.of(context).brightness == Brightness.dark 
                                      ? AppColors.darkGreyText 
                                      : AppColors.greyText),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? AppColors.darkSecondary 
                            : AppColors.secondaryColor,
                        child: Center(
                          child: Icon(Icons.home, size: 150, 
                              color: Theme.of(context).brightness == Brightness.dark 
                                  ? AppColors.darkGreyText 
                                  : AppColors.greyText),
                        ),
                      ),
              ),
            ),
            // Right side - Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            house.name,
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
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
                            size: 20),
                        SizedBox(width: 8),
                        Text(
                          '${house.address.city}, ${house.address.street}',
                          style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark 
                                  ? AppColors.darkGreyText 
                                  : AppColors.greyText, 
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        '\$${house.price.toInt()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        _buildInfoCard(Icons.bed, '${house.rooms}', 'Xonalar'),
                        SizedBox(width: 16),
                        _buildInfoCard(Icons.square_foot, '${house.area}', 'm²'),
                        SizedBox(width: 16),
                        _buildInfoCard(
                          Icons.sell,
                          house.category == Category.sotuv ? 'Sotuv' : 'Ijara',
                          'Turi',
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Tavsif',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      house.description,
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? AppColors.darkGreyText 
                              : AppColors.greyText, 
                          height: 1.6, fontSize: 16),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Qo\'ng\'iroq qilish', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: AppColors.primaryColor),
                            ),
                            child: Text('Xabar yuborish', style: TextStyle(color: AppColors.primaryColor, fontSize: 16)),
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

  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Expanded(
      child: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark 
                ? AppColors.darkSecondary 
                : AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 28),
              SizedBox(height: 8),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(label, style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? AppColors.darkGreyText 
                      : AppColors.greyText, 
                  fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}