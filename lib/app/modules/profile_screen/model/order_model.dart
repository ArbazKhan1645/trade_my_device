import '../../sell_my_phone/models/mobile_phones_model.dart';

class OrderModel {
  final int? id;
  final DateTime? createdAt;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? zipCode;
  final String? street;
  final int? customerId;
  final String? orderNumber;
  final List<MobilePhonesModel>? models;
  final String? deliveryOption;
  final String? status;
  final String? accountName;
  final String? accountNumber;
  final String? sortCode;

  OrderModel({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.phone,
    this.zipCode,
    this.street,
    this.customerId,
    this.orderNumber,
    this.models,
    this.deliveryOption,
    this.status,
    this.accountName,
    this.accountNumber,
    this.sortCode,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      zipCode: json['zip_code'] as String?,
      street: json['street'] as String?,
      customerId: json['customer_id'] as int?,
      orderNumber: json['order_number'] as String?,
      models: (json['models'] as List<dynamic>)
          .map((phone) => MobilePhonesModel.fromJson(phone))
          .toList(),
      //     ? Map<String, dynamic>.from(json['models'])
      //     : null,
      deliveryOption: json['delivery_option'] as String?,
      status: json['status'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      sortCode: json['sort_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'zip_code': zipCode,
      'street': street,
      'customer_id': customerId,
      'order_number': orderNumber,
      'models': models,
      'delivery_option': deliveryOption,
      'status': status,
      'account_name': accountName,
      'account_number': accountNumber,
      'sort_code': sortCode,
    };
  }
}
