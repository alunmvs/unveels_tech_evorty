import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unveels/features/skin_analysis/model/skin_result_model.dart';
import 'package:unveels/features/skin_analysis/presentation/cubit/sa_bloc.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import 'sa_alaysis_details_widget.dart';

final List<String> skinConditionLabels = [
  "Firmness",
  "Radiance",
  "Anti Aging",
  "Fine Lines",
  "Sensitive Skin",
  "Redness",
  "Uneven Skintone",
  "Black Heads",
  "Blemishes",
  "Lip Lines"
];

final List<String> skinProblemLabels = [
  "Wrinkles",
  "Oily Skin",
  "Dark Circles",
  "Dry Skin",
  "Pores",
  "Damaged Skin",
  "Acne",
  "Spots"
];

class SAFullAnalysisResultsWidget extends StatefulWidget {
  final List<SkinResultModel> dataSkinConcern;
  const SAFullAnalysisResultsWidget({super.key, required this.dataSkinConcern});

  @override
  State<SAFullAnalysisResultsWidget> createState() =>
      _SAFullAnalysisResultsWidgetState();
}

class _SAFullAnalysisResultsWidgetState
    extends State<SAFullAnalysisResultsWidget> {
  double getCategoryValue(String label) {
    final matchedSkin = widget.dataSkinConcern.firstWhere(
      (skin) => skin.label.toLowerCase() == label.toLowerCase(),
      orElse: () => SkinResultModel(label: label, value: 0),
    );
    return matchedSkin.value.toDouble();
  }

  double getTotalValueForCategory(List<String> categoryLabels) {
    double totalValue = 0;

    for (var label in categoryLabels) {
      totalValue += getCategoryValue(
          label); // Menggunakan fungsi getCategoryValue yang sudah ada
    }

    return totalValue / categoryLabels.length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaBloc, SaState>(builder: (context, state) {
      return Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: BottomCopyrightWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.horizontalPadding,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Analysis Results",
                        style: TextStyle(
                          color: ColorConfig.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImagePath.saFaceExample,
                            width: 120,
                            height: 120,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SummaryItemWidget(
                                  iconPath: IconPath.connectionChart,
                                  value: "Skin Health Score : 72%",
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                _SummaryItemWidget(
                                  iconPath: IconPath.hasTagCircle,
                                  value: "Skin Age: 27",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Detected Skin Problems",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 130,
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${(getTotalValueForCategory(skinProblemLabels)).toStringAsFixed(2)}%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 21,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Skin Problems",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _CircularChartBarWidget(
                              height: 140,
                              width: 140,
                              color: ColorConfig.green,
                              value: getCategoryValue('texture') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 160,
                              width: 160,
                              color: ColorConfig.purple,
                              value: getCategoryValue('dark circles') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 180,
                              width: 180,
                              color: ColorConfig.oceanBlue,
                              value: getCategoryValue('eye bags') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 200,
                              width: 200,
                              color: ColorConfig.blue,
                              value: getCategoryValue('wrinkles') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 220,
                              width: 220,
                              color: ColorConfig.yellow,
                              value: getCategoryValue('pores') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 240,
                              width: 240,
                              color: ColorConfig.taffi,
                              value: getCategoryValue('spots') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 260,
                              width: 260,
                              color: ColorConfig.pink,
                              value: getCategoryValue('acne') / 100,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _LegendItemWidget(
                                    color: ColorConfig.green,
                                    value: getCategoryValue('texture').toInt(),
                                    label: "Texture",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.purple,
                                    value: getCategoryValue('dark circles')
                                        .toInt(),
                                    label: "Dark Circles",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.oceanBlue,
                                    value: getCategoryValue('Eyebags').toInt(),
                                    label: "Eyebags",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  _LegendItemWidget(
                                    color: ColorConfig.blue,
                                    value: getCategoryValue('Wrinkles').toInt(),
                                    label: "Wrinkles",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.yellow,
                                    value: getCategoryValue('Pores').toInt(),
                                    label: "Pores",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.taffi,
                                    value: getCategoryValue('Spots').toInt(),
                                    label: "Spots",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.pink,
                                    value: getCategoryValue('Acne').toInt(),
                                    label: "Acne",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          "Detected Skin Condition",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 130,
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${(getTotalValueForCategory(skinConditionLabels)).toStringAsFixed(2)}%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 21,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Skin Condition",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _CircularChartBarWidget(
                              height: 140,
                              width: 140,
                              color: ColorConfig.green,
                              value: getCategoryValue('firmness') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 160,
                              width: 160,
                              color: ColorConfig.purple,
                              value:
                                  getCategoryValue('droopy upper eyelid') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 180,
                              width: 180,
                              color: ColorConfig.oceanBlue,
                              value:
                                  getCategoryValue('droopy lower eyelid') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 200,
                              width: 200,
                              color: ColorConfig.blue,
                              value: getCategoryValue('moisture level') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 220,
                              width: 220,
                              color: ColorConfig.yellow,
                              value: getCategoryValue('oiliness') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 240,
                              width: 240,
                              color: ColorConfig.taffi,
                              value: getCategoryValue('redness') / 100,
                            ),
                            _CircularChartBarWidget(
                              height: 260,
                              width: 260,
                              color: ColorConfig.pink,
                              value: getCategoryValue('radiance') / 100,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _LegendItemWidget(
                                    color: ColorConfig.green,
                                    value: getCategoryValue('Firmness').toInt(),
                                    label: "Firmness",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.purple,
                                    value:
                                        getCategoryValue('Droopy Upper Eyelid')
                                            .toInt(),
                                    label: "Droopy Upper Eyelid",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.oceanBlue,
                                    value:
                                        getCategoryValue('Droopy Lower Eyelid')
                                            .toInt(),
                                    label: "Droopy Lower Eyelid",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  _LegendItemWidget(
                                    color: ColorConfig.blue,
                                    value: getCategoryValue('Moisture').toInt(),
                                    label: "Moisture Level",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.yellow,
                                    value: getCategoryValue('Oiliness').toInt(),
                                    label: "Oiliness",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.taffi,
                                    value: getCategoryValue('Redness').toInt(),
                                    label: "Redness",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _LegendItemWidget(
                                    color: ColorConfig.pink,
                                    value: getCategoryValue('Radiance').toInt(),
                                    label: "Radiance",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SAAnalysisDetailsWidget(
                    title: "Spots", productData: state.spotsData),
                SAAnalysisDetailsWidget(
                    title: "Dark Circles", productData: state.darkcircleData),
                SAAnalysisDetailsWidget(
                    title: "Redness", productData: state.rednessData),
                SAAnalysisDetailsWidget(
                    title: "Oiliness", productData: state.oilinessData),
                SAAnalysisDetailsWidget(
                    title: "Pores", productData: state.poresData),
                SAAnalysisDetailsWidget(
                    title: "Eye Bags", productData: state.eyebagsData),
                SAAnalysisDetailsWidget(
                    title: "Acne", productData: state.acneData),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _LegendItemWidget extends StatelessWidget {
  final Color color;
  final int value;
  final String label;

  const _LegendItemWidget({
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "$value%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularChartBarWidget extends StatelessWidget {
  final double height, width, value;
  final Color color;

  const _CircularChartBarWidget({
    required this.height,
    required this.width,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Transform.rotate(
        angle: 1.5,
        child: CircularProgressIndicator(
          color: color,
          value: value,
          strokeCap: StrokeCap.round,
          strokeWidth: 6,
        ),
      ),
    );
  }
}

class _SummaryItemWidget extends StatelessWidget {
  final String iconPath;
  final String value;

  const _SummaryItemWidget({
    required this.iconPath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
