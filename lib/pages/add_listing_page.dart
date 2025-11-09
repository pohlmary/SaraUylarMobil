import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/house.dart';

class AddListingPage extends StatefulWidget {
  @override
  _AddListingPageState createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _areaController = TextEditingController();
  final _roomsController = TextEditingController();
  final _regionController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();

  Category _selectedCategory = Category.sotuv;
  List<String> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E\'lon berish'),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildSection('Asosiy ma\'lumotlar', [
              _buildTextField(
                controller: _nameController,
                label: 'Uy nomi',
                icon: Icons.home,
                hint: 'Masalan: 3 xonali kvartira',
                validator: (value) => value?.isEmpty == true ? 'Uy nomini kiriting' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Tavsif',
                icon: Icons.description,
                hint: 'Uy haqida batafsil ma\'lumot',
                maxLines: 3,
                validator: (value) => value?.isEmpty == true ? 'Tavsif kiriting' : null,
              ),
            ]),
            SizedBox(height: 16),
            _buildSection('Narx va turi', [
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _priceController,
                      label: 'Narx (\$)',
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty == true ? 'Narx kiriting' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildCategoryDropdown(),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 16),
            _buildSection('Xususiyatlar', [
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _areaController,
                      label: 'Maydon (m²)',
                      icon: Icons.square_foot,
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty == true ? 'Maydon kiriting' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _roomsController,
                      label: 'Xonalar soni',
                      icon: Icons.bed,
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty == true ? 'Xonalar sonini kiriting' : null,
                    ),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 16),
            _buildSection('Manzil', [
              _buildTextField(
                controller: _regionController,
                label: 'Viloyat',
                icon: Icons.location_city,
                validator: (value) => value?.isEmpty == true ? 'Viloyat kiriting' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _cityController,
                label: 'Shahar',
                icon: Icons.location_on,
                validator: (value) => value?.isEmpty == true ? 'Shahar kiriting' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _streetController,
                label: 'Ko\'cha manzili',
                icon: Icons.home,
                validator: (value) => value?.isEmpty == true ? 'Ko\'cha manzilini kiriting' : null,
              ),
            ]),
            SizedBox(height: 16),
            _buildSection('Rasmlar', [
              _buildImagePicker(),
            ]),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: AppColors.greyText),
                    ),
                    child: Text('Bekor qilish'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitListing,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('E\'lon berish', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 12),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.greyText),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark 
            ? AppColors.darkSecondary 
            : AppColors.secondaryColor,
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<Category>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Turi',
        prefixIcon: Icon(Icons.category, color: AppColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.greyText),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark 
            ? AppColors.darkSecondary 
            : AppColors.secondaryColor,
      ),
      items: [
        DropdownMenuItem(value: Category.sotuv, child: Text('Sotuv')),
        DropdownMenuItem(value: Category.ijara, child: Text('Ijara')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
        });
      },
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Uy rasmlari (ixtiyoriy)', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildAddImageButton(),
              ..._selectedImages.map((image) => _buildImageItem(image)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton() {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark 
            ? AppColors.darkSecondary 
            : AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor, style: BorderStyle.solid),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedImages.add('https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=400');
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Rasm qo\'shildi')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo, color: AppColors.primaryColor, size: 32),
            SizedBox(height: 8),
            Text('Rasm qo\'shish', style: TextStyle(color: AppColors.primaryColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.secondaryColor,
                  child: Icon(Icons.image, color: AppColors.greyText),
                );
              },
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedImages.remove(imageUrl);
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitListing() {
    if (_formKey.currentState?.validate() == true) {
      // Create new house object
      final newHouse = House(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        address: Address(
          region: _regionController.text,
          city: _cityController.text,
          street: _streetController.text,
        ),
        price: double.parse(_priceController.text),
        category: _selectedCategory,
        area: int.parse(_areaController.text),
        rooms: int.parse(_roomsController.text),
        images: _selectedImages,
        ownerId: 'current_user',
        createdAt: DateTime.now(),
        status: Status.aktiv,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('E\'lon muvaffaqiyatli joylashtirildi!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _roomsController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    super.dispose();
  }
}