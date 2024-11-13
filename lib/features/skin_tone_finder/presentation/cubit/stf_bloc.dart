import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unveels/features/product/product_model.dart';
import 'package:unveels/features/skin_tone_finder/presentation/models/skin_tone_model.dart';
import 'package:unveels/features/skin_tone_finder/presentation/models/tone_type_model.dart';
import 'package:unveels/shared/service/stf_service.dart';
import 'package:equatable/equatable.dart';
part 'stf_action.dart';
part 'stf_state.dart';

class StfBloc extends Bloc<StfEvent, StfState> {
  // final StfService stfService;

  StfBloc() : super(StfState.initial()) {
    on<UpdateHexColor>(_onUpdateHexColor);
    on<UpdateSkinType>(_onUpdateSkinType);
    on<UpdateAllowCamera>(_onUpdateAllowCamera);
    on<ClearData>((event, emit) {
      emit(StfState.initial());
    });

    //tone type
    on<FetchToneType>(_onFetchToneType);
    on<UpdateToneTypeId>(_onUpdateToneTypeId);

    //skin tone
    on<UpdateSelectSkinId>(_onUpdateSelectSkinId);
    on<FetchSkinTone>(_onFetchSkinTone);

    //product
    on<FetchProduct>(_onFetchProduct);
    on<UpdateHexColorProduct>(_onUpdateHexColorProduct);

    //change Tab
    on<ChangeTabActive>(_onChangeTabActive);
  }

//tone type
  Future<void> _onFetchToneType(
      FetchToneType event, Emitter<StfState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final toneTypeData = await StfService().fetchToneType();
      final skinToneLabel = state.skinType?.split(" ")[0];
      final selectIdToneType = toneTypeData.options!
          .firstWhere(
            (item) => item.label == skinToneLabel,
          )
          .value;
      final listSkinTone = toneTypeData.options!
          .where((e) => e.label != "" && e.value != "")
          .map((e) => {"label": e.label!, "value": e.value!})
          .toList();

      emit(state.copyWith(
        toneTypeData: toneTypeData,
        toneTypeSelectId: selectIdToneType,
        toneTypeOptions: listSkinTone,
        isLoading: false,
      ));
      add(FetchProduct());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  //skin tone
  Future<void> _onFetchSkinTone(FetchSkinTone event, Emitter<StfState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final skinToneData = await StfService().fetchSkinToneData();
      final matchTone = skinToneData.options!
          .where((e) => e.label != "" && e.value != "")
          .map((e) => {"label": e.label!, "value": e.value!})
          .toList();
      emit(state.copyWith(
        skinTone: skinToneData,
        matchedTones: matchTone,
        selectToneSkinId: matchTone[0]["value"],
        isLoading: false,
      ));
      add(FetchProduct());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  //skin tone
  Future<void> _onFetchProduct(FetchProduct event, Emitter<StfState> emit) async {
    try {
      emit(state.copyWith(loadingProduct: true));
      final productData = await StfService()
          .fetchProductData(state.selectToneSkinId, state.toneTypeSelectId);
      print(productData);
      List<String> listHexa = productData.items
          .map((product) {
            // Filter untuk mendapatkan nilai hexacodes
            final hexacodeAttribute = product.customAttributes.firstWhere(
              (attribute) => attribute.attributeCode == 'hexacode',
            );
            //return
            return hexacodeAttribute.value;
          })
          .where((hex) => hex != null)
          .cast<String>()
          .toList();

      emit(state.copyWith(
        productData: productData,
        loadingProduct: false,
        listHexa: listHexa,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), loadingProduct: false));
    }
  }

  void _onUpdateHexColor(UpdateHexColor event, Emitter<StfState> emit) {
    emit(state.copyWith(hexColor: event.newColor));
  }

  void _onUpdateHexColorProduct(
      UpdateHexColorProduct event, Emitter<StfState> emit) {
    emit(state.copyWith(hexColorSelect: event.newColor));
  }

  void _onUpdateSkinType(UpdateSkinType event, Emitter<StfState> emit) {
    emit(state.copyWith(skinType: event.newSkinType));
  }

  void _onUpdateAllowCamera(UpdateAllowCamera event, Emitter<StfState> emit) {
    emit(state.copyWith(isAllowCamera: event.value));
  }

  void _onUpdateSelectSkinId(UpdateSelectSkinId event, Emitter<StfState> emit) {
    emit(state.copyWith(selectToneSkinId: event.newSkinId));
  }

  void _onChangeTabActive(ChangeTabActive event, Emitter<StfState> emit) {
    emit(state.copyWith(activeTab: event.value));
  }

  void _onUpdateToneTypeId(UpdateToneTypeId event, Emitter<StfState> emit) {
    emit(state.copyWith(toneTypeSelectId: event.newIdToneType));
  }
}
