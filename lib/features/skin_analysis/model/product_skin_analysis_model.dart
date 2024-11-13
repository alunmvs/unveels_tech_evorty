// To parse this JSON data, do
//
//     final productSkinAnalisisModel = productSkinAnalisisModelFromJson(jsonString);

import 'dart:convert';

ProductSkinAnalisisModel productSkinAnalisisModelFromJson(String str) => ProductSkinAnalisisModel.fromJson(json.decode(str));

String productSkinAnalisisModelToJson(ProductSkinAnalisisModel data) => json.encode(data.toJson());

class ProductSkinAnalisisModel {
    List<Item> items;
    SearchCriteria searchCriteria;
    int totalCount;

    ProductSkinAnalisisModel({
        required this.items,
        required this.searchCriteria,
        required this.totalCount,
    });

    factory ProductSkinAnalisisModel.fromJson(Map<String, dynamic> json) => ProductSkinAnalisisModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        searchCriteria: SearchCriteria.fromJson(json["search_criteria"]),
        totalCount: json["total_count"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "search_criteria": searchCriteria.toJson(),
        "total_count": totalCount,
    };
}

class Item {
    int id;
    String sku;
    String name;
    int attributeSetId;
    int price;
    int status;
    int visibility;
    String typeId;
    DateTime createdAt;
    DateTime updatedAt;
    int weight;
    ExtensionAttributes extensionAttributes;
    List<dynamic> productLinks;
    List<dynamic> options;
    List<MediaGalleryEntry> mediaGalleryEntries;
    List<dynamic> tierPrices;
    List<CustomAttribute> customAttributes;

    Item({
        required this.id,
        required this.sku,
        required this.name,
        required this.attributeSetId,
        required this.price,
        required this.status,
        required this.visibility,
        required this.typeId,
        required this.createdAt,
        required this.updatedAt,
        required this.weight,
        required this.extensionAttributes,
        required this.productLinks,
        required this.options,
        required this.mediaGalleryEntries,
        required this.tierPrices,
        required this.customAttributes,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        attributeSetId: json["attribute_set_id"],
        price: json["price"],
        status: json["status"],
        visibility: json["visibility"],
        typeId: json["type_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        weight: json["weight"],
        extensionAttributes: ExtensionAttributes.fromJson(json["extension_attributes"]),
        productLinks: List<dynamic>.from(json["product_links"].map((x) => x)),
        options: List<dynamic>.from(json["options"].map((x) => x)),
        mediaGalleryEntries: List<MediaGalleryEntry>.from(json["media_gallery_entries"].map((x) => MediaGalleryEntry.fromJson(x))),
        tierPrices: List<dynamic>.from(json["tier_prices"].map((x) => x)),
        customAttributes: List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "attribute_set_id": attributeSetId,
        "price": price,
        "status": status,
        "visibility": visibility,
        "type_id": typeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "weight": weight,
        "extension_attributes": extensionAttributes.toJson(),
        "product_links": List<dynamic>.from(productLinks.map((x) => x)),
        "options": List<dynamic>.from(options.map((x) => x)),
        "media_gallery_entries": List<dynamic>.from(mediaGalleryEntries.map((x) => x.toJson())),
        "tier_prices": List<dynamic>.from(tierPrices.map((x) => x)),
        "custom_attributes": List<dynamic>.from(customAttributes.map((x) => x.toJson())),
    };
}

class CustomAttribute {
    String attributeCode;
    dynamic value;

    CustomAttribute({
        required this.attributeCode,
        required this.value,
    });

    factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
        attributeCode: json["attribute_code"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "attribute_code": attributeCode,
        "value": value,
    };
}

class ExtensionAttributes {
    List<int> websiteIds;
    List<CategoryLink> categoryLinks;

    ExtensionAttributes({
        required this.websiteIds,
        required this.categoryLinks,
    });

    factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
        websiteIds: List<int>.from(json["website_ids"].map((x) => x)),
        categoryLinks: List<CategoryLink>.from(json["category_links"].map((x) => CategoryLink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "website_ids": List<dynamic>.from(websiteIds.map((x) => x)),
        "category_links": List<dynamic>.from(categoryLinks.map((x) => x.toJson())),
    };
}

class CategoryLink {
    int position;
    String categoryId;

    CategoryLink({
        required this.position,
        required this.categoryId,
    });

    factory CategoryLink.fromJson(Map<String, dynamic> json) => CategoryLink(
        position: json["position"],
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "position": position,
        "category_id": categoryId,
    };
}

class MediaGalleryEntry {
    int id;
    String mediaType;
    dynamic label;
    int position;
    bool disabled;
    List<String> types;
    String file;

    MediaGalleryEntry({
        required this.id,
        required this.mediaType,
        required this.label,
        required this.position,
        required this.disabled,
        required this.types,
        required this.file,
    });

    factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) => MediaGalleryEntry(
        id: json["id"],
        mediaType: json["media_type"],
        label: json["label"],
        position: json["position"],
        disabled: json["disabled"],
        types: List<String>.from(json["types"].map((x) => x)),
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "media_type": mediaType,
        "label": label,
        "position": position,
        "disabled": disabled,
        "types": List<dynamic>.from(types.map((x) => x)),
        "file": file,
    };
}

class SearchCriteria {
    List<FilterGroup> filterGroups;

    SearchCriteria({
        required this.filterGroups,
    });

    factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
        filterGroups: List<FilterGroup>.from(json["filter_groups"].map((x) => FilterGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "filter_groups": List<dynamic>.from(filterGroups.map((x) => x.toJson())),
    };
}

class FilterGroup {
    List<Filter> filters;

    FilterGroup({
        required this.filters,
    });

    factory FilterGroup.fromJson(Map<String, dynamic> json) => FilterGroup(
        filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
    };
}

class Filter {
    String field;
    String value;
    String conditionType;

    Filter({
        required this.field,
        required this.value,
        required this.conditionType,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        field: json["field"],
        value: json["value"],
        conditionType: json["condition_type"],
    );

    Map<String, dynamic> toJson() => {
        "field": field,
        "value": value,
        "condition_type": conditionType,
    };
}
