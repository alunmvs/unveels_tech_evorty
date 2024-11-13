part of 'sa_bloc.dart';

class SaState extends Equatable {
  final bool isAllowCamera;
  final bool isLoading;
  final bool detecTionProgress;

  //label klik
  final String? labelSelect;

  //show analisis
  final bool showAnalisis;

  //data anlysis
  final List<SkinAnalysisModel>? dataAnalys;
  final List<SkinResultModel>? skinAnalisisList;

  //data product skin analis
  final bool? loadingProduct;
  final ProductSkinAnalisisModel? productData;

  //selected skin concern
  final String? selectSkinConcern;

  //product recomendationst
  final ProductSkinAnalisisModel? darkcircleData;
  final ProductSkinAnalisisModel? rednessData;
  final ProductSkinAnalisisModel? oilinessData;
  final ProductSkinAnalisisModel? poresData;
  final ProductSkinAnalisisModel? eyebagsData;
  final ProductSkinAnalisisModel? acneData;
  final ProductSkinAnalisisModel? spotsData;

  const SaState({
    this.isAllowCamera = false,
    this.isLoading = false,
    this.detecTionProgress = false,
    this.showAnalisis = false,
    this.labelSelect,
    this.dataAnalys,
    this.loadingProduct,
    this.productData,
    this.skinAnalisisList,
    this.selectSkinConcern,
    this.darkcircleData,
    this.rednessData,
    this.oilinessData,
    this.poresData,
    this.eyebagsData,
    this.acneData,
    this.spotsData,
  });

  factory SaState.initial() {
    return const SaState(
      isAllowCamera: false,
      isLoading: false,
      detecTionProgress: false,
      showAnalisis: false,
      labelSelect: '',
      dataAnalys: [],
      loadingProduct: false,
      productData: null,
      skinAnalisisList: [],
      selectSkinConcern: '',
      darkcircleData: null,
      rednessData: null,
      oilinessData: null,
      poresData: null,
      eyebagsData: null,
      acneData: null,
      spotsData: null,
    );
  }

  SaState copyWith({
    bool? isAllowCamera,
    bool? isLoading,
    bool? detecTionProgress,
    bool? showAnalisis,
    String? labelSelect,
    List<SkinAnalysisModel>? dataAnalys,
    bool? loadingProduct,
    ProductSkinAnalisisModel? productData,
    List<SkinResultModel>? skinAnalisisList,
    String? selectSkinConcern,
    ProductSkinAnalisisModel? darkcircleData,
    ProductSkinAnalisisModel? rednessData,
    ProductSkinAnalisisModel? oilinessData,
    ProductSkinAnalisisModel? poresData,
    ProductSkinAnalisisModel? eyebagsData,
    ProductSkinAnalisisModel? acneData,
    ProductSkinAnalisisModel? spotsData,
  }) {
    return SaState(
      isAllowCamera: isAllowCamera ?? this.isAllowCamera,
      isLoading: isLoading ?? this.isLoading,
      detecTionProgress: detecTionProgress ?? this.detecTionProgress,
      showAnalisis: showAnalisis ?? this.showAnalisis,
      labelSelect: labelSelect ?? this.labelSelect,
      dataAnalys: dataAnalys ?? this.dataAnalys,
      loadingProduct: loadingProduct ?? this.loadingProduct,
      productData: productData ?? this.productData,
      skinAnalisisList: skinAnalisisList ?? this.skinAnalisisList,
      selectSkinConcern: selectSkinConcern ?? this.selectSkinConcern,
      darkcircleData: darkcircleData ?? this.darkcircleData,
      rednessData: rednessData ?? this.rednessData,
      oilinessData: oilinessData ?? this.oilinessData,
      poresData: poresData ?? this.poresData,
      eyebagsData: eyebagsData ?? this.eyebagsData,
      acneData: acneData ?? this.acneData,
      spotsData: spotsData ?? this.spotsData,
    );
  }

  @override
  List<Object?> get props => [
        isAllowCamera,
        isLoading,
        showAnalisis,
        detecTionProgress,
        labelSelect,
        dataAnalys,
        loadingProduct,
        productData,
        skinAnalisisList,
        selectSkinConcern,
        darkcircleData,
        rednessData,
        oilinessData,
        poresData,
        eyebagsData,
        acneData,
        spotsData,
      ];
}
