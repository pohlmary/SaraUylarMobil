import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sozlamalar'),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSection('Ko\'rinish', [
            _buildThemeToggle(context),
            _buildLanguageItem(),
            _buildFontSizeItem(),
          ]),
          SizedBox(height: 16),
          _buildSection('Bildirishnomalar', [
            _buildNotificationItem('Yangi e\'lonlar', true),
            _buildNotificationItem('Narx o\'zgarishi', false),
            _buildNotificationItem('Xabarlar', true),
          ]),
          SizedBox(height: 16),
          _buildSection('Hisob', [
            _buildAccountItem(Icons.person, 'Profil ma\'lumotlari'),
            _buildAccountItem(Icons.security, 'Xavfsizlik'),
            _buildAccountItem(Icons.privacy_tip, 'Maxfiylik'),
          ]),
          SizedBox(height: 16),
          _buildSection('Yordam', [
            _buildHelpItem(Icons.help_outline, 'Yordam markazi'),
            _buildHelpItem(Icons.feedback, 'Fikr bildirish'),
            _buildHelpItem(Icons.info_outline, 'Ilova haqida'),
          ]),
          SizedBox(height: 32),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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

  Widget _buildLanguageItem() {
    return ListTile(
      leading: Icon(Icons.language, color: AppColors.primaryColor),
      title: Text('Til'),
      subtitle: Text('O\'zbekcha'),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget _buildFontSizeItem() {
    return ListTile(
      leading: Icon(Icons.text_fields, color: AppColors.primaryColor),
      title: Text('Shrift o\'lchami'),
      subtitle: Text('O\'rtacha'),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget _buildNotificationItem(String title, bool isEnabled) {
    return ListTile(
      leading: Icon(
        isEnabled ? Icons.notifications : Icons.notifications_off,
        color: AppColors.primaryColor,
      ),
      title: Text(title),
      trailing: Switch(
        value: isEnabled,
        onChanged: (value) {},
        activeColor: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildAccountItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget _buildHelpItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
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
                      SnackBar(content: Text('Hisobdan chiqildi')),
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