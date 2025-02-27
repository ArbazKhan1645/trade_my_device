class BrandsModel {
  final String? name;
  final int? id;

  BrandsModel({this.name, this.id});

  // Factory constructor for creating a new instance from a map
  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  // CopyWith method for immutability and modifications
  BrandsModel copyWith({String? name, int? id}) {
    return BrandsModel(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  @override
  String toString() => 'TypesModel(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BrandsModel && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
