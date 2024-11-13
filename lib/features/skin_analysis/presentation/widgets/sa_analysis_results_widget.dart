import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:unveels/features/skin_analysis/model/skin_result_model.dart';
import 'package:unveels/features/skin_analysis/presentation/cubit/sa_bloc.dart';

import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import 'sa_product_item_widget.dart';

final _skinConcern = [
  {"label": "Oily Skin", "value": "5825"},
  {"label": "Dark Circles", "value": "5826"},
  {"label": "Anti Aging", "value": "5827"},
  {"label": "Wrinkles", "value": "5828"},
  {"label": "Damaged Skin", "value": "5829"},
  {"label": "Fine Lines", "value": "5830"},
  {"label": "Sensitive Skin", "value": "5831"},
  {"label": "Redness", "value": "5832"},
  {"label": "Acne", "value": "5833"},
  {"label": "Spots", "value": "5834"},
  {"label": "Uneven Skintone", "value": "5835"},
  {"label": "Dry Skin", "value": "5836"},
  {"label": "Pores", "value": "5837"},
  {"label": "Black Heads", "value": "5838"},
  {"label": "Blemishes", "value": "5839"},
  {"label": "Lip Lines", "value": "5840"}
];

class SAAnalysisResultsWidget extends StatefulWidget {
  final Function() onViewAll;
  final List<SkinResultModel> categoriesSkin;

  const SAAnalysisResultsWidget({
    super.key,
    required this.onViewAll,
    required this.categoriesSkin,
  });

  @override
  State<SAAnalysisResultsWidget> createState() =>
      _SAAnalysisResultsWidgetState();
}

class _SAAnalysisResultsWidgetState extends State<SAAnalysisResultsWidget> {
  String? _selectedCategory;

  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  double getCategoryValue(String label) {
    final matchedSkin = widget.categoriesSkin.firstWhere(
      (skin) => skin.label.toLowerCase() == label.toLowerCase(),
      orElse: () => SkinResultModel(label: label, value: 0),
    );
    return matchedSkin.value.toDouble();
  }

  @override
  void initState() {
    super.initState();
    final initSelect = context.read<SaBloc>().state.selectSkinConcern;
    if (initSelect == null || initSelect.isEmpty) {
      _selectedCategory = _skinConcern.first['label'];
    } else {
      final matchedSkin = _skinConcern.firstWhere(
        (skin) => skin['label']!.toLowerCase() == initSelect.toLowerCase(),
        orElse: () => _skinConcern.first,
      );
      _selectedCategory = matchedSkin['label'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaBloc, SaState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.categoriesSkin.isNotEmpty
              ? SizedBox(
                  height: 55,
                  child: ListView.separated(
                    itemCount: _skinConcern.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(width: 15),
                    itemBuilder: (context, index) {
                      final category = _skinConcern[index];
                      final isSelected = _selectedCategory == category['label'];
                      final isFirst = index == 0;
                      final isEnd = index == _skinConcern.length - 1;

                      return Padding(
                        padding: EdgeInsets.only(
                          left: isFirst ? 8 : 0,
                          right: isEnd ? 8 : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isSelected) ...[
                              Text(
                                '${getCategoryValue(category['label'] ?? '').toStringAsFixed(2)} %',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                            ButtonWidget(
                              text: capitalizeFirst(category['label'] ?? ''),
                              backgroundColor:
                                  isSelected ? null : Colors.transparent,
                              borderColor: Colors.white,
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              borderRadius: BorderRadius.circular(99),
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category['label'];
                                });
                                if (category['value'] != null) {
                                  context.read<SaBloc>().add(
                                      FetchProduct(category['value']!, ''));
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding * 1.9,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                ReadMoreText(
                  "Hey there! As much as we embrace aging gracefully...",
                  trimMode: TrimMode.Line,
                  trimLines: 3,
                  colorClickableText: ColorConfig.primary,
                  trimCollapsedText: 'More',
                  trimExpandedText: 'Less',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  moreStyle: TextStyle(
                    fontSize: 14,
                    color: ColorConfig.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onViewAll,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: SizeConfig.horizontalPadding,
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          state.loadingProduct!
              ? CircularProgressIndicator()
              : SizedBox(
                  height: 130,
                  child: state.productData?.items.length == 0
                      ? SizedBox()
                      : ListView.separated(
                          itemCount: state.productData?.items.length ?? 0,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final product = state.productData?.items[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 8 : 0,
                                right: index == 9 ? 8 : 0,
                              ),
                              child: SAProductItemWidget(
                                productName: product?.name ?? '',
                                brandName: "Brand Name",
                                price: product?.price.toString() ?? '',
                                originalPrice: product?.price.toString() ?? '',
                                imagePath:
                                    product?.mediaGalleryEntries[0].file ?? '',
                              ),
                            );
                          },
                        ),
                ),
        ],
      );
    });
  }
}
