

import 'package:flutter_task/data/storage/hive_storage.dart';
import 'package:hive/hive.dart';
//part 'productsMode.g.dart';



@HiveType(typeId: HiveTypeIds.productModel,adapterName: 'ProductModelListAdapter')
class ProductsModel {
  @HiveField(0)
  final bool? success;
  @HiveField(1)
  final String? message;
  @HiveField(2)
  final Data? data;
  @HiveField(3)
  final dynamic errors;
  @HiveField(4)
  final int? code;

  ProductsModel({
     this.success,
     this.message,
     this.data,
     this.errors,
     this.code,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json){
    return ProductsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errors: json["errors"],
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "errors": errors,
    "code": code,
  };

}

class Data {
  Data({
    required this.fixedOffers,
    required this.mainProducts,
  });

  @HiveField(6)
  final List<dynamic> fixedOffers;
  @HiveField(7)
  final MainProducts? mainProducts;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      fixedOffers: json["fixed_offers"] == null ? [] : List<dynamic>.from(json["fixed_offers"]!.map((x) => x)),
      mainProducts: json["main_products"] == null ? null : MainProducts.fromJson(json["main_products"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "fixed_offers": fixedOffers.map((x) => x).toList(),
    "main_products": mainProducts?.toJson(),
  };

}

class MainProducts {
  MainProducts({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });
  @HiveField(8)
  final int? currentPage;
  @HiveField(9)
  final List<Datum> data;

  final String? firstPageUrl;

  final int? from;

  final int? lastPage;

  final String? lastPageUrl;

  final List<Link> links;

  final dynamic nextPageUrl;

  final String? path;

  final int? perPage;

  final dynamic prevPageUrl;

  final int? to;

  final int? total;

  factory MainProducts.fromJson(Map<String, dynamic> json){
    return MainProducts(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data.map((x) => x.toJson()).toList(),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links.map((x) => x.toJson()).toList(),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };

}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
    required this.sku,
    required this.price,
    required this.sellBasePriceNew,
    required this.sellBasePriceOld,
    required this.quantity,
    required this.status,
    required this.isFeatured,
    required this.isAccessory,
    required this.categoryId,
    required this.brandId,
    required this.seriesId,
    required this.operationTypeId,
    required this.releaseDate,
    required this.lowestPriceUnitId,
    required this.thumb,
    required this.category,
    required this.lowestUnit,
  });

  final int? id;
  @HiveField(10)
  final String? name;
  @HiveField(11)
  final String? image;
  final String? slug;
  final String? sku;
  final String? price;
  final String? sellBasePriceNew;
  final String? sellBasePriceOld;
  final int? quantity;
  final int? status;
  final int? isFeatured;
  final int? isAccessory;
  final int? categoryId;
  final int? brandId;
  final int? seriesId;
  final int? operationTypeId;
  final DateTime? releaseDate;
  final int? lowestPriceUnitId;
  final String? thumb;
  final Category? category;
  @HiveField(12)
  final LowestUnit? lowestUnit;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      slug: json["slug"],
      sku: json["sku"],
      price: json["price"],
      sellBasePriceNew: json["sell_base_price_new"],
      sellBasePriceOld: json["sell_base_price_old"],
      quantity: json["quantity"],
      status: json["status"],
      isFeatured: json["is_featured"],
      isAccessory: json["is_accessory"],
      categoryId: json["category_id"],
      brandId: json["brand_id"],
      seriesId: json["series_id"],
      operationTypeId: json["operation_type_id"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      lowestPriceUnitId: json["lowest_price_unit_id"],
      thumb: json["thumb"],
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      lowestUnit: json["lowest_unit"] == null ? null : LowestUnit.fromJson(json["lowest_unit"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
    "sku": sku,
    "price": price,
    "sell_base_price_new": sellBasePriceNew,
    "sell_base_price_old": sellBasePriceOld,
    "quantity": quantity,
    "status": status,
    "is_featured": isFeatured,
    "is_accessory": isAccessory,
    "category_id": categoryId,
    "brand_id": brandId,
    "series_id": seriesId,
    "operation_type_id": operationTypeId,
    "release_date": "${releaseDate?.year.toString()}-${releaseDate?.month.toString()}-${releaseDate?.day.toString()}",
    "lowest_price_unit_id": lowestPriceUnitId,
    "thumb": thumb,
    "category": category?.toJson(),
    "lowest_unit": lowestUnit?.toJson(),
  };

}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.parentId,
  });

  final int? id;
  final String? name;
  final int? parentId;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
      parentId: json["parent_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
  };

}

class LowestUnit {
  LowestUnit({
    required this.id,
    required this.mainProductId,
    required this.conditionId,
    required this.mrp,
    required this.salePrice,
    required this.availableQuantity,
    required this.marketplacePrice,
    required this.note,
    required this.specialPrice,
    required this.startDate,
    required this.endDate,
    required this.offers,
  });

  final int? id;
  final int? mainProductId;
  final int? conditionId;
  final String? mrp;
  @HiveField(13)
  final String? salePrice;
  final int? availableQuantity;
  final String? marketplacePrice;
  final String? note;
  final String? specialPrice;
  final dynamic startDate;
  final dynamic endDate;
  final List<dynamic> offers;

  factory LowestUnit.fromJson(Map<String, dynamic> json){
    return LowestUnit(
      id: json["id"],
      mainProductId: json["main_product_id"],
      conditionId: json["condition_id"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      availableQuantity: json["available_quantity"],
      marketplacePrice: json["marketplace_price"],
      note: json["note"],
      specialPrice: json["special_price"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      offers: json["offers"] == null ? [] : List<dynamic>.from(json["offers"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "main_product_id": mainProductId,
    "condition_id": conditionId,
    "mrp": mrp,
    "sale_price": salePrice,
    "available_quantity": availableQuantity,
    "marketplace_price": marketplacePrice,
    "note": note,
    "special_price": specialPrice,
    "start_date": startDate,
    "end_date": endDate,
    "offers": offers.map((x) => x).toList(),
  };

}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };

}
