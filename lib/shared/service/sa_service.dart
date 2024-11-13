import 'dart:convert';

import 'package:unveels/features/product/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:unveels/features/skin_analysis/model/product_skin_analysis_model.dart';
import 'package:unveels/shared/constant/constant.dart';

class SaService {
  Future<ProductSkinAnalisisModel> fetchProduct(skinconcern) async {
    final response = await http.get(
        Uri.parse(
            '$baseUrl/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=470&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=simple&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=skin_concern&searchCriteria[filter_groups][2][filters][0][value]=${skinconcern}&searchCriteria[filter_groups][2][filters][0][condition_type]=finset'),
        headers: {"Authorization": "Bearer $apiKey"});
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProductSkinAnalisisModel.fromJson(data);
    } else {
      throw Exception("Failed to load skin tone data");
    }
  }
}
