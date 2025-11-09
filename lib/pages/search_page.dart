import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/house.dart';
import 'house_details_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String? _selectedRegion;
  String? _selectedCategory;
  int? _selectedRooms;
  RangeValues _priceRange = RangeValues(0, 500000);
  
  List<House> _searchResults = [];
  bool _isSearching = false;

  final List<House> _allHouses = [
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

  @override
  void initState() {
    super.initState();
    _searchResults = _allHouses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izlash'),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchHeader(),
          _buildFilterSection(),
          Expanded(child: _buildSearchResults()),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) => _performSearch(),
            decoration: InputDecoration(
              hintText: 'Manzil yoki kalit so\'zlar...',
              prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _performSearch();
                      },
                    )
                  : null,
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
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${_searchResults.length} ta natija topildi',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? AppColors.darkGreyText 
                        : AppColors.greyText,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _showFilterDialog,
                icon: Icon(Icons.tune, color: AppColors.primaryColor),
                label: Text('Filter', style: TextStyle(color: AppColors.primaryColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('Barcha', _selectedCategory == null, () {
            setState(() => _selectedCategory = null);
            _performSearch();
          }),
          _buildFilterChip('Sotuv', _selectedCategory == 'Sotuv', () {
            setState(() => _selectedCategory = 'Sotuv');
            _performSearch();
          }),
          _buildFilterChip('Ijara', _selectedCategory == 'Ijara', () {
            setState(() => _selectedCategory = 'Ijara');
            _performSearch();
          }),
          _buildFilterChip('1-2 xona', _selectedRooms != null && _selectedRooms! <= 2, () {
            setState(() => _selectedRooms = _selectedRooms == 2 ? null : 2);
            _performSearch();
          }),
          _buildFilterChip('3+ xona', _selectedRooms != null && _selectedRooms! >= 3, () {
            setState(() => _selectedRooms = _selectedRooms == 3 ? null : 3);
            _performSearch();
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primaryColor.withOpacity(0.2),
        checkmarkColor: AppColors.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primaryColor : null,
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, 
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkGreyText 
                    : AppColors.greyText),
            SizedBox(height: 16),
            Text(
              'Hech narsa topilmadi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Boshqa kalit so\'zlar bilan qidiring',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkGreyText 
                    : AppColors.greyText,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final house = _searchResults[index];
        return _buildHouseCard(house);
      },
    );
  }

  Widget _buildHouseCard(House house) {
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
          child: Row(
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
                    Text(
                      house.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      house.address.street,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? AppColors.darkGreyText 
                            : AppColors.greyText,
                      ),
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
              Column(
                children: [
                  Text(
                    '\$${house.price.toInt()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: AppColors.primaryColor),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Saqlanganlarga qo\'shildi')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildModalDropdown('Viloyat', _selectedRegion, ['Toshkent', 'Samarqand', 'Buxoro'], (value) {
                setModalState(() => _selectedRegion = value);
              }),
              SizedBox(height: 16),
              _buildModalDropdown('Turi', _selectedCategory, ['Sotuv', 'Ijara'], (value) {
                setModalState(() => _selectedCategory = value);
              }),
              SizedBox(height: 16),
              Text('Narx oralig\'i', style: TextStyle(fontWeight: FontWeight.bold)),
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 1000000,
                divisions: 100,
                activeColor: AppColors.primaryColor,
                labels: RangeLabels(
                  '\$${_priceRange.start.round()}',
                  '\$${_priceRange.end.round()}',
                ),
                onChanged: (values) {
                  setModalState(() => _priceRange = values);
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedRegion = null;
                          _selectedCategory = null;
                          _selectedRooms = null;
                          _priceRange = RangeValues(0, 500000);
                        });
                        _performSearch();
                        Navigator.pop(context);
                      },
                      child: Text('Tozalash'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _performSearch();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                      child: Text('Qo\'llash', style: TextStyle(color: Colors.white)),
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

  Widget _buildModalDropdown(String label, String? value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark 
                ? AppColors.darkSecondary 
                : AppColors.secondaryColor,
          ),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _performSearch() {
    setState(() {
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _searchResults = _allHouses.where((house) {
          bool matchesSearch = _searchController.text.isEmpty || 
              house.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
              house.address.street.toLowerCase().contains(_searchController.text.toLowerCase());
          
          bool matchesCategory = _selectedCategory == null ||
              (_selectedCategory == 'Sotuv' && house.category == Category.sotuv) ||
              (_selectedCategory == 'Ijara' && house.category == Category.ijara);
          
          bool matchesRooms = _selectedRooms == null || 
              (_selectedRooms == 2 && house.rooms <= 2) ||
              (_selectedRooms == 3 && house.rooms >= 3);
          
          bool matchesPrice = house.price >= _priceRange.start && house.price <= _priceRange.end;
          
          return matchesSearch && matchesCategory && matchesRooms && matchesPrice;
        }).toList();
        _isSearching = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}