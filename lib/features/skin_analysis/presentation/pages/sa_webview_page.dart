import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unveels/features/skin_analysis/model/skin_analysis_model.dart';
import 'package:unveels/features/skin_analysis/model/skin_result_model.dart';
import 'package:unveels/features/skin_analysis/presentation/cubit/sa_bloc.dart';
import 'package:unveels/features/skin_analysis/presentation/widgets/sa_alaysis_details_widget.dart';
import 'package:unveels/features/skin_analysis/presentation/widgets/sa_analysis_results_widget.dart';
import 'package:unveels/features/skin_analysis/presentation/widgets/sa_full_analysis_results_widget.dart';
import 'package:unveels/shared/configs/size_config.dart';
import 'package:unveels/shared/extensions/context_parsing.dart';
import 'package:unveels/shared/widgets/buttons/button_widget.dart';
import 'package:unveels/shared/widgets/lives/bottom_copyright_widget.dart';
import 'package:unveels/shared/widgets/webview/acces_denied_camera_widget.dart';

class SaWebviewPage extends StatefulWidget {
  const SaWebviewPage({super.key});

  @override
  State<SaWebviewPage> createState() => _SaWebviewPageState();
}

class _SaWebviewPageState extends State<SaWebviewPage> {
  InAppWebViewController? webViewController;
  // late SaBloc _saBloc;
  bool loadingDetection = false;
  bool showAnlysis = false;
  bool showFullAnlysis = false;
  List<SkinResultModel> categories = [];

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    context.read<SaBloc>().add(UpdateAllowCamera(true));
  }

  Future<void> _setCategories() async {
    var data = context.read<SaBloc>().state.dataAnalys;
    final totalScores = <String, double>{};
    final labelCounts = <String, int>{};

    // Mengelompokkan data berdasarkan label dan menghitung total score untuk setiap label
    if (data!.isNotEmpty) {
      for (var item in data) {
        final label = item.label as String;
        final score = item.score as double;

        totalScores[label] = (totalScores[label] ?? 0) + score;
        labelCounts[label] = (labelCounts[label] ?? 0) + 1;
      }
    }

    // Menghitung rata-rata persentase untuk setiap label
    final percentages = totalScores.entries.map((entry) {
      final label = entry.key;
      final totalScore = entry.value;
      final count = labelCounts[label] ?? 1;
      final percentage = ((totalScore / count) * 100 / 100);

      return SkinResultModel(label: label, value: percentage.toInt());
    }).toList();

    setState(() {
      categories = percentages;
    });
    //  _onAnalysisResults();
  }

  @override
  void initState() {
    requestCameraPermission();
    // _saBloc = SaBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaBloc, SaState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Skin Analysis'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (showFullAnlysis) {
                  setState(() {
                    showFullAnlysis = false;
                  });
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            actions: [
              // IconButton(
              //   icon: const Icon(Icons.shopping_cart),
              //   tooltip: 'Open shopping cart',
              //   onPressed: () {
              //     // context.read<StfCubit>().fetchSkinTone();
              //     print(state.productData);
              //     // print(state.dataAnalys);
              //   },
              // ),
              // IconButton(
              //   icon: const Icon(Icons.shopping_cart),
              //   tooltip: 'Open shopping cart',
              //   onPressed: () {
              //     // context.read<StfCubit>().fetchSkinTone();
              //     _setCategories();
              //   },
              // ),
            ],
          ),
          body: !state.isAllowCamera
              ? const AccessDeniedCameraWidget()
              : Stack(
                  children: [
                    // Loading indikator

                    InAppWebView(
                      initialUrlRequest: URLRequest(
                          url: WebUri(
                              'https://unveels-webview.netlify.app/skin-analysis-web')),
                      onWebViewCreated: (controller) async {
                        webViewController = controller;

                        // // Tambahkan handler JavaScript untuk deteksi klik
                        // webViewController?.addJavaScriptHandler(
                        //   handlerName: 'handleWebClick',
                        //   callback: (args) {
                        //     // Proses yang dilakukan saat klik terdeteksi
                        //     print("Deteksi klik dari web: ");
                        //   },
                        // );

                        // JavaScript handler untuk 'detectionRun'
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionRun',
                          callback: (args) {
                            print('runn');
                            setState(() {
                              loadingDetection = true;
                            });
                            // context
                            //     .read<SaBloc>()
                            //     .add(UpdateProgressEvent(true));
                          },
                        );

                        // JavaScript handler untuk 'detectionResult'
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionResult',
                          callback: (args) async {
                            // context
                            //     .read<SaBloc>()
                            //     .add(UpdateProgressEvent(false));
                            setState(() {
                              loadingDetection = false;
                            });

                            if (args.isNotEmpty) {
                              print('ini hasil data');
                              print(args[0]);
                              try {
                                dynamic decodedData;

                                // Decode JSON if the input is a String
                                if (args[0] is String) {
                                  decodedData = json.decode(args[0] ?? "[]");
                                } else {
                                  decodedData = args[0];
                                }

                                // Ensure decodedData is a List and parse each item as SkinAnalysisModel
                                if (decodedData is List) {
                                  List<SkinAnalysisModel> data = decodedData
                                      .map((item) =>
                                          SkinAnalysisModel.fromJson(item))
                                      .toList();

                                  // Flatten list if necessary (ensure data structure is compatible with expand)
                                  List<SkinAnalysisModel> flatList =
                                      data.expand((x) => [x]).toList();

                                  context
                                      .read<SaBloc>()
                                      .add(UpdateDataAnalys(flatList));
                                  context
                                      .read<SaBloc>()
                                      .add(FetchProduct('5825', ''));
                                  context.read<SaBloc>().add(
                                      FetchProduct('5826', 'Dark Circles'));
                                  context
                                      .read<SaBloc>()
                                      .add(FetchProduct('5832', 'Redness'));
                                  context
                                      .read<SaBloc>()
                                      .add(FetchProduct('5825', 'Oily Skin'));
                                  context
                                      .read<SaBloc>()
                                      .add(FetchProduct('5837', 'Pores'));
                                  context
                                      .read<SaBloc>()
                                      .add(FetchProduct('5833', 'Acne'));
                                  context
                                      .read<SaBloc>()
                                      .add(FetchProduct('5825', 'Spots'));
                                } else {
                                  print('Decoded data is not a List');
                                }
                              } catch (e) {
                                print('Error parsing detection result: $e');
                              }

                              // context.read<StfCubit>().fetchSkinTone();
                            }
                            _setCategories();
                          },
                        );
                        // JavaScript handler untuk handle lable
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'getLabel',
                          callback: (args) async {
                            // if (args.isNotEmpty) {
                            //   final decodedLabel = json.decode(args[0] ?? "");
                            //   context
                            //       .read<SaBloc>()
                            //       .add(UpdateSelectLabel(decodedLabel));
                            // }
                            print('label');
                            print(args);
                            if (args.isNotEmpty) {
                              final decodedLabel = json.decode(args[0] ?? "");
                              context.read<SaBloc>().add(UpdateSkinConcern(
                                  decodedLabel['skinAnalysisLabelClick']));
                              _onAnalysisResults();
                            }
                            print('label');
                            print(args);
                          },
                        );

                        // JavaScript handler untuk 'detectionError'
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionError',
                          callback: (args) {
                            setState(() {
                              loadingDetection = false;
                            });
                          },
                        );
                      },
                      onPermissionRequest:
                          (controller, permissionRequest) async {
                        return PermissionResponse(
                            resources: permissionRequest.resources,
                            action: PermissionResponseAction.GRANT);
                      },
                    ),
                    if (loadingDetection)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state.dataAnalys!.isNotEmpty)
                      BottomCopyrightWidget(
                        child: Column(
                          children: [
                            showAnlysis
                                ? SizedBox()
                                : ButtonWidget(
                                    text: 'ANALYSIS RESULT',
                                    width: context.width / 2,
                                    backgroundColor: Colors.black,
                                    onTap: () {
                                      _setCategories();
                                      _onAnalysisResults();
                                    }
                                    // () {
                                    //   setState(() {
                                    //     // showFullAnlysis = true;
                                    //     showAnlysis = true;
                                    //   });
                                    // },
                                    ),
                          ],
                        ),
                      ),
                    if (showFullAnlysis)
                      SAFullAnalysisResultsWidget(
                        dataSkinConcern: categories,
                      ),
                  ],
                ));
    });
  }

  Future<void> _onAnalysisResults() async {
    if (categories.isEmpty) {
      _setCategories();
    }

    // show analysis results
    setState(() {
      showAnlysis = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      constraints: BoxConstraints(
        minHeight: context.height * 0.6,
        maxHeight: context.height * 0.8,
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SAAnalysisResultsWidget(
                  categoriesSkin: categories,
                  onViewAll: () {
                    // close this dialog
                    // context.pop();
                    setState(() {
                      showAnlysis = false;
                      showFullAnlysis = true;
                    });

                    // _onViewAllProducts();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    // hide analysis results
    setState(() {
      showAnlysis = false;
    });
  }
}
