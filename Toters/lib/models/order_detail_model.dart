class OrderDetailModel {
  int? id;
  int? orderId;
  int? foodId;
  String? foodDetails;
  int? quantity;
  double? price;
  double? taxAmount;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor
  OrderDetailModel({
    this.id,
    this.orderId,
    this.foodId,
    this.foodDetails,
    this.quantity,
    this.price,
    this.taxAmount,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create an instance from a JSON map
  OrderDetailModel.fromJson(Map<String, dynamic> json) {
      id= json['id'];
      orderId= json['order_id'];
      foodId= json['food_id'];
      foodDetails= json['food_details'];
      quantity= json['quantity'];
      price= (json['price'] as num?)?.toDouble();
      taxAmount= (json['tax_amount'] as num?)?.toDouble();
      createdAt= json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
      updatedAt= json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;

  }

  // Method to convert an instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'food_id': foodId,
      'food_details': foodDetails,
      'quantity': quantity,
      'price': price,
      'tax_amount': taxAmount,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }


}