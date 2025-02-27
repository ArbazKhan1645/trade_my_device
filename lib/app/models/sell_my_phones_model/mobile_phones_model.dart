// ignore_for_file: non_constant_identifier_names

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
  final String? condition;
  final String? imei;
   num? base_price;
  final num? manage_price;
  final List<dynamic>? questions;

  MobilePhonesModel({
    this.id,
    this.name,
    this.image,
    this.brands,
    this.brandName,
    this.manage_price,
    this.questions,
    this.type,
    this.imei,
    this.createdAt,
    this.isTurnOn,
    this.base_price,
    this.networkIsUnlocked,
    this.storage,
    this.condition,
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
        condition: json['condition'] as String?,
        imei: json['imei'] as String?,
        questions: json['questions'] as List<dynamic>?,
        manage_price: json['manage_price'] as num?,
        base_price: json['base_price'] as num?);
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'brands': brands,
      'type': type,
      'questions': questions,
      'storage': storage,
      'isCracked': isCracked,
      'isTurnOn': isTurnOn,
      'manage_price': manage_price,
      'networkIsUnlocked': networkIsUnlocked,
      'condition': condition,
      'imei': imei,
      'base_price': base_price
    };
  }

  // CopyWith method for immutability and modifications
  MobilePhonesModel copyWith(
      {int? id,
      String? name,
      String? image,
      int? brands,
      String? imei,
      num? manage_price,
      int? type,
      List<dynamic>? questions,
      num? base_price,
      DateTime? createdAt,
      bool? isTurnOn,
      bool? networkIsUnlocked,
      String? storage,
      bool? isCracked,
      String? condition}) {
    return MobilePhonesModel(
        id: id ?? this.id,
        name: name ?? this.name,
        manage_price: manage_price ?? this.manage_price,
        image: image ?? this.image,
        base_price: base_price ?? this.base_price,
        imei: imei ?? this.imei,
        brands: brands ?? this.brands,
        questions: questions ?? this.questions,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        isTurnOn: isTurnOn ?? this.isTurnOn,
        networkIsUnlocked: networkIsUnlocked ?? this.networkIsUnlocked,
        storage: storage ?? this.storage,
        isCracked: isCracked ?? this.isCracked,
        condition: condition ?? this.condition);
  }

  @override
  String toString() =>
      'TypesModel(id: $id, name: $name, image: $image, brands: $brands, type: $type, createdAt: $createdAt, isTurnOn: $isTurnOn, networkIsUnlocked: $networkIsUnlocked, storage: $storage, isCracked: $isCracked)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MobilePhonesModel &&
        other.id == id &&
        other.condition == condition &&
        other.manage_price == manage_price &&
        other.name == name &&
        other.imei == imei &&
        other.questions == questions &&
        other.base_price == base_price &&
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
      condition.hashCode ^
      imei.hashCode ^
      image.hashCode ^
      base_price.hashCode ^
      questions.hashCode ^
      brands.hashCode ^
      type.hashCode ^
      manage_price.hashCode ^
      createdAt.hashCode ^
      isTurnOn.hashCode ^
      networkIsUnlocked.hashCode ^
      storage.hashCode ^
      isCracked.hashCode;
}
