import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unveels/features/product/product_model.dart';
import 'package:unveels/features/skin_analysis/model/product_skin_analysis_model.dart';
import 'package:unveels/features/skin_analysis/model/skin_analysis_model.dart';
import 'package:unveels/features/skin_analysis/model/skin_result_model.dart';
import 'package:unveels/shared/service/sa_service.dart';

part 'sa_action.dart';
part 'sa_state.dart';

class SaBloc extends Bloc<SaEvent, SaState> {
  SaBloc() : super(SaState.initial()) {
    on<UpdateAllowCamera>(_onUpdateAllowCamera);
    on<UpdateProgressEvent>(_onUpdateProgressEvent);
    on<UpdateSHowAnalysis>(_onUpdateSHowAnalysis);
    on<UpdateSelectLabel>(_onUpdateSelectLabel);
    on<UpdateDataAnalys>(_onUpdateDataAnalys);
    on<FetchProduct>(_onFetchProduct);
    on<UpdateListResult>(_onUpdateListResult);
    on<UpdateSkinConcern>(_onUpdateSkinConcern);
  }
  void _onUpdateAllowCamera(UpdateAllowCamera event, Emitter<SaState> emit) {
    emit(state.copyWith(isAllowCamera: event.value));
  }

  void _onUpdateProgressEvent(
      UpdateProgressEvent event, Emitter<SaState> emit) {
    emit(state.copyWith(detecTionProgress: event.value));
  }

  void _onUpdateSHowAnalysis(UpdateSHowAnalysis event, Emitter<SaState> emit) {
    emit(state.copyWith(showAnalisis: event.value));
  }

  void _onUpdateSelectLabel(UpdateSelectLabel event, Emitter<SaState> emit) {
    emit(state.copyWith(labelSelect: event.value));
  }

  void _onUpdateDataAnalys(UpdateDataAnalys event, Emitter<SaState> emit) {
    emit(state.copyWith(dataAnalys: event.value));
  }

  void _onUpdateListResult(UpdateListResult event, Emitter<SaState> emit) {
    emit(state.copyWith(skinAnalisisList: event.value));
  }

  void _onUpdateSkinConcern(UpdateSkinConcern event, Emitter<SaState> emit) {
    emit(state.copyWith(selectSkinConcern: event.value));
  }

  Future<void> _onFetchProduct(
      FetchProduct event, Emitter<SaState> emit) async {
    try {
      emit(state.copyWith(loadingProduct: true));
      final productData = await SaService().fetchProduct(event.skinConcern);
      if (event.skinConcernLabel != '') {
        switch (event.skinConcernLabel) {
          case 'Dark Circles':
            emit(state.copyWith(
                darkcircleData: productData, loadingProduct: false));
            break;
          case 'Redness':
            emit(state.copyWith(
                rednessData: productData, loadingProduct: false));
            break;
          case 'Oily Skin':
            emit(state.copyWith(
                oilinessData: productData, loadingProduct: false));
            break;
          case 'Pores':
            emit(state.copyWith(poresData: productData, loadingProduct: false));
            break;
          case 'Eye Bags':
            emit(state.copyWith(
                eyebagsData: productData, loadingProduct: false));
            break;
          case 'Acne':
            emit(state.copyWith(acneData: productData, loadingProduct: false));
            break;
          case 'Spots':
            emit(state.copyWith(spotsData: productData, loadingProduct: false));
            break;
          default:
            emit(state.copyWith(
                loadingProduct:
                    false)); // Handle if the label is not recognized
            break;
        }
      } else {
        // Fallback or default state update
        emit(state.copyWith(
          productData: productData,
          loadingProduct: false,
        ));
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(loadingProduct: false));
    }
  }
}
