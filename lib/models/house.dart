class House {
  final String id;
  final String name;
  final String description;
  final Address address;
  final double price;
  final Category category;
  final int area;
  final int rooms;
  final List<String> images;
  final String ownerId;
  final DateTime createdAt;
  final Status status;

  House({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.price,
    required this.category,
    required this.area,
    required this.rooms,
    required this.images,
    required this.ownerId,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address.toMap(),
      'price': price,
      'category': category.name,
      'area': area,
      'rooms': rooms,
      'images': images,
      'ownerId': ownerId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'status': status.name,
    };
  }

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      address: Address.fromMap(map['address']),
      price: map['price'].toDouble(),
      category: Category.values.byName(map['category']),
      area: map['area'],
      rooms: map['rooms'],
      images: List<String>.from(map['images']),
      ownerId: map['ownerId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: Status.values.byName(map['status']),
    );
  }
}

class Address {
  final String region;
  final String city;
  final String street;
  final double? latitude;
  final double? longitude;

  Address({
    required this.region,
    required this.city,
    required this.street,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'region': region,
      'city': city,
      'street': street,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      region: map['region'],
      city: map['city'],
      street: map['street'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}

enum Category { ijara, sotuv }
enum Status { aktiv, arxivlangan, kutilmoqda }