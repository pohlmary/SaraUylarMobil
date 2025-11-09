import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profil tahrirlash sahifasi')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildProfileHeader(context),
          SizedBox(height: 24),
          _buildStatsSection(),
          SizedBox(height: 24),
          _buildMenuSection('Mening faoliyatim', [
            _buildMenuItem(Icons.home_work, 'Mening e\'lonlarim', '3 ta', () {}),
            _buildMenuItem(Icons.favorite, 'Saqlanganlar', '8 ta', () {}),
            _buildMenuItem(Icons.history, 'Ko\'rilgan uylar', '25 ta', () {}),
            _buildMenuItem(Icons.visibility, 'Profil ko\'rilishi', '156 marta', () {}),
          ]),
          SizedBox(height: 16),
          _buildMenuSection('Sozlamalar', [
            _buildThemeToggle(context),
            _buildMenuItem(Icons.notifications, 'Bildirishnomalar', '', () {}),
            _buildMenuItem(Icons.language, 'Til', 'O\'zbekcha', () {}),
            _buildMenuItem(Icons.security, 'Xavfsizlik', '', () {}),
          ]),
          SizedBox(height: 16),
          _buildMenuSection('Yordam', [
            _buildMenuItem(Icons.help_outline, 'Yordam markazi', '', () {}),
            _buildMenuItem(Icons.feedback, 'Fikr bildirish', '', () {}),
            _buildMenuItem(Icons.info_outline, 'Ilova haqida', 'v1.0.0', () {}),
          ]),
          SizedBox(height: 32),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'),
                  backgroundColor: AppColors.primaryColor,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(Icons.check, size: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Iftixor To\'ychiyev',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Faol foydalanuvchi',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkGreyText 
                    : AppColors.greyText,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text('4.8 (12 baho)', style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.phone, color: AppColors.primaryColor),
                      SizedBox(height: 4),
                      Text('+998 50 500 9356', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.email, color: AppColors.primaryColor),
                      SizedBox(height: 4),
                      Text('iftixortoychiyev@gmail.com', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.location_on, color: AppColors.primaryColor),
                      SizedBox(height: 4),
                      Text('Samarqand', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            _buildStatItem('E\'lonlar', '3', Icons.home_work),
            _buildStatItem('Ko\'rishlar', '156', Icons.visibility),
            _buildStatItem('Saqlanganlar', '8', Icons.favorite),
            _buildStatItem('Kunlar', '45', Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppColors.greyText),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ListTile(
          leading: Icon(
            themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: AppColors.primaryColor,
          ),
          title: Text('Tungi rejim'),
          subtitle: Text(themeProvider.isDarkMode ? 'Yoqilgan' : 'O\'chirilgan'),
          trailing: Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(),
            activeColor: AppColors.primaryColor,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Chiqish'),
              content: Text('Hisobdan chiqishni xohlaysizmi?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Bekor qilish'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hisobdan chiqildi'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text('Chiqish', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: Colors.red),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 8),
            Text('Hisobdan chiqish', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}