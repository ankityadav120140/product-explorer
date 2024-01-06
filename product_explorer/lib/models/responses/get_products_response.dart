class GetProductsWithSizesResponse {
  int productCount;
  List<Product> products;
  List<Brand> brands;
  int lastUpdatedToken;
  dynamic appColor;

  GetProductsWithSizesResponse({
    required this.productCount,
    required this.products,
    required this.brands,
    required this.lastUpdatedToken,
    required this.appColor,
  });

  factory GetProductsWithSizesResponse.fromJson(Map<String, dynamic> json) =>
      GetProductsWithSizesResponse(
        productCount: json["ProductCount"],
        products: List<Product>.from(
            json["Products"].map((x) => Product.fromJson(x))),
        brands: List<Brand>.from(json["Brands"].map((x) => Brand.fromJson(x))),
        lastUpdatedToken: json["LastUpdatedToken"],
        appColor: json["AppColor"],
      );

  Map<String, dynamic> toJson() => {
        "ProductCount": productCount,
        "Products": List<dynamic>.from(products.map((x) => x.toJson())),
        "Brands": List<dynamic>.from(brands.map((x) => x.toJson())),
        "LastUpdatedToken": lastUpdatedToken,
        "AppColor": appColor,
      };
}

class Brand {
  String name;
  int moq;

  Brand({
    required this.name,
    required this.moq,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["Name"],
        moq: json["MOQ"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "MOQ": moq,
      };
}

class Product {
  String brand;
  String gender;
  String theme;
  String category;
  String subCategory;
  String name;
  String color;
  String option;
  double mrp;
  String collection;
  String fit;
  String description;
  String qrCode;
  String finish;
  List<String> availableSizes;
  String offerMonths;
  int maxQuantity;
  String imageUrl;
  String imageUrl2;
  String imageUrl3;
  String imageUrl4;
  String imageUrl5;
  String? technologyImageUrl;

  Product({
    required this.brand,
    required this.gender,
    required this.theme,
    required this.category,
    required this.name,
    required this.color,
    required this.option,
    required this.mrp,
    required this.subCategory,
    required this.collection,
    required this.fit,
    required this.description,
    required this.qrCode,
    required this.finish,
    required this.availableSizes,
    required this.offerMonths,
    required this.maxQuantity,
    required this.imageUrl,
    required this.imageUrl2,
    required this.imageUrl3,
    required this.imageUrl4,
    required this.imageUrl5,
    required this.technologyImageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        brand: json["Brand"],
        gender: json["Gender"],
        theme: json["Theme"],
        category: json["Category"],
        name: json["Name"],
        color: json["Color"],
        option: json["Option"],
        mrp: json["MRP"],
        subCategory: json["SubCategory"],
        collection: json["Collection"],
        fit: json["Fit"],
        description: json["Description"],
        qrCode: json["QRCode"],
        finish: json["Finish"],
        availableSizes:
            json["AvailableSizes"] == null || json["AvailableSizes"] == []
                ? []
                : List<String>.from(json["AvailableSizes"].map((x) => x)),
        offerMonths: json["OfferMonths"].runtimeType == String
            ? json["OfferMonths"]
            : List<String>.from(json["OfferMonths"].map((x) => x)).first,
        maxQuantity: json["MaxQuantity"],
        imageUrl: json["ImageUrl"],
        imageUrl2: json["ImageUrl2"],
        imageUrl3: json["ImageUrl3"],
        imageUrl4: json["ImageUrl4"],
        imageUrl5: json["ImageUrl5"],
        technologyImageUrl: json["TechnologyImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "Brand": brand,
        "Gender": gender,
        "Theme": theme,
        "Category": category,
        "Name": name,
        "Color": color,
        "Option": option,
        "MRP": mrp,
        "SubCategory": subCategory,
        "Collection": collection,
        "Fit": fit,
        "Description": description,
        "QRCode": qrCode,
        "Finish": finish,
        "AvailableSizes": List<dynamic>.from(availableSizes.map((x) => x)),
        "OfferMonths": offerMonths,
        "MaxQuantity": maxQuantity,
        "ImageUrl": imageUrl,
        "ImageUrl2": imageUrl2,
        "ImageUrl3": imageUrl3,
        "ImageUrl4": imageUrl4,
        "ImageUrl5": imageUrl5,
        "TechnologyImageUrl": technologyImageUrl,
      };
}
