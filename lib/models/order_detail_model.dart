class OrderDetailModel {
  int? _id;
  int? _userId;
  int? _orderId;
  int? _productId;
  int? _price;
  ProductDetails? _productDetails;
  int? _quantity;
  int? _taxAmount;
  String? _createdAt;
  String? _updatedAt;

  OrderDetailModel(
      {int? id,
      int? userId,
      int? orderId,
      int? productId,
      int? price,
      ProductDetails? productDetails,
      int? quantity,
      int? taxAmount,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (productId != null) {
      this._productId = productId;
    }
    if (price != null) {
      this._price = price;
    }
    if (productDetails != null) {
      this._productDetails = productDetails;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (taxAmount != null) {
      this._taxAmount = taxAmount;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  int? get orderId => _orderId;
  set orderId(int? orderId) => _orderId = orderId;
  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  int? get price => _price;
  set price(int? price) => _price = price;
  ProductDetails? get productDetails => _productDetails;
  set productDetails(ProductDetails? productDetails) =>
      _productDetails = productDetails;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  int? get taxAmount => _taxAmount;
  set taxAmount(int? taxAmount) => _taxAmount = taxAmount;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = int.parse(json['user_id']);
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _price = json['price'];
    _productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    _quantity = json['quantity'];
    _taxAmount = json['tax_amount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['order_id'] = this._orderId;
    data['product_id'] = this._productId;
    data['price'] = this._price;
    if (this._productDetails != null) {
      data['product_details'] = this._productDetails!.toJson();
    }
    data['quantity'] = this._quantity;
    data['tax_amount'] = this._taxAmount;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class ProductDetails {
  int? _id;
  String? _name;
  String? _brand;
  String? _description;
  int? _price;
  int? _stars;
  String? _img;
  String? _subcategory;
  String? _createdAt;
  String? _updatedAt;
  int? _typeId;

  ProductDetails(
      {int? id,
      String? name,
      String? brand,
      String? description,
      int? price,
      int? stars,
      String? img,
      String? subcategory,
      String? createdAt,
      String? updatedAt,
      int? typeId}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (brand != null) {
      this._brand = brand;
    }
    if (description != null) {
      this._description = description;
    }
    if (price != null) {
      this._price = price;
    }
    if (stars != null) {
      this._stars = stars;
    }
    if (img != null) {
      this._img = img;
    }
    if (subcategory != null) {
      this._subcategory = subcategory;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (typeId != null) {
      this._typeId = typeId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get brand => _brand;
  set brand(String? brand) => _brand = brand;
  String? get description => _description;
  set description(String? description) => _description = description;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get stars => _stars;
  set stars(int? stars) => _stars = stars;
  String? get img => _img;
  set img(String? img) => _img = img;
  String? get subcategory => _subcategory;
  set subcategory(String? subcategory) => _subcategory = subcategory;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get typeId => _typeId;
  set typeId(int? typeId) => _typeId = typeId;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _brand = json['brand'];
    _description = json['description'];
    _price = int.parse(json['price']);
    _stars = int.parse(json['stars']);
    _img = json['img'];
    _subcategory = json['subcategory'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _typeId = int.parse(json['type_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['brand'] = this._brand;
    data['description'] = this._description;
    data['price'] = this._price;
    data['stars'] = this._stars;
    data['img'] = this._img;
    data['subcategory'] = this._subcategory;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['type_id'] = this._typeId;
    return data;
  }
}
