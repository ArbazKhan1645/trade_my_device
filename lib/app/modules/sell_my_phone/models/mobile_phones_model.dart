class MobilePhonesModel {
  final int? id;
  final String? name;
  final String? image;
  final String? brandName;
  final int? brands;
  final int? type;
  final DateTime? createdAt;
  bool? isTurnOn;
  final bool? networkIsUnlocked;
  String? storage;
  final bool? isCracked;

  MobilePhonesModel({
    this.id,
    this.name,
    this.image,
    this.brands,
    this.brandName,
    this.type,
    this.createdAt,
    this.isTurnOn,
    this.networkIsUnlocked,
    this.storage,
    this.isCracked,
  });

  // Factory constructor for creating a new instance from a map
  factory MobilePhonesModel.fromJson(Map<String, dynamic> json) {
    return MobilePhonesModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      brands: json['brands'] as int?,
      type: json['type'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      isTurnOn: json['isTurnOn'] as bool?,
      networkIsUnlocked: json['networkIsUnlocked'] as bool?,
      storage: json['storage'] as String?,
      isCracked: json['isCracked'] as bool?,
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'brands': brands,
      'type': type,
      'storage': storage,
      'isCracked': isCracked,
      'isTurnOn': isTurnOn,
      'networkIsUnlocked': networkIsUnlocked,
    };
  }

  // CopyWith method for immutability and modifications
  MobilePhonesModel copyWith({
    int? id,
    String? name,
    String? image,
    int? brands,
    int? type,
    DateTime? createdAt,
    bool? isTurnOn,
    bool? networkIsUnlocked,
    String? storage,
    bool? isCracked,
  }) {
    return MobilePhonesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      brands: brands ?? this.brands,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isTurnOn: isTurnOn ?? this.isTurnOn,
      networkIsUnlocked: networkIsUnlocked ?? this.networkIsUnlocked,
      storage: storage ?? this.storage,
      isCracked: isCracked ?? this.isCracked,
    );
  }

  @override
  String toString() =>
      'TypesModel(id: $id, name: $name, image: $image, brands: $brands, type: $type, createdAt: $createdAt, isTurnOn: $isTurnOn, networkIsUnlocked: $networkIsUnlocked, storage: $storage, isCracked: $isCracked)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MobilePhonesModel &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.brands == brands &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.isTurnOn == isTurnOn &&
        other.networkIsUnlocked == networkIsUnlocked &&
        other.storage == storage &&
        other.isCracked == isCracked;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      brands.hashCode ^
      type.hashCode ^
      createdAt.hashCode ^
      isTurnOn.hashCode ^
      networkIsUnlocked.hashCode ^
      storage.hashCode ^
      isCracked.hashCode;
}
