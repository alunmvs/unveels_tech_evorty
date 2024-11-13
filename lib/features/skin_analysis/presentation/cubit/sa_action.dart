part of 'sa_bloc.dart';

abstract class SaEvent extends Equatable {
  const SaEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAllowCamera extends SaEvent {
  final bool value;

  const UpdateAllowCamera(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateProgressEvent extends SaEvent {
  final bool value;

  const UpdateProgressEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateSHowAnalysis extends SaEvent {
  final bool value;

  const UpdateSHowAnalysis(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateSelectLabel extends SaEvent {
  final String value;

  const UpdateSelectLabel(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateDataAnalys extends SaEvent {
  final List<SkinAnalysisModel>? value;

  const UpdateDataAnalys(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateListResult extends SaEvent {
  final List<SkinResultModel>? value;

  const UpdateListResult(this.value);

  @override
  List<Object?> get props => [value];
}

class FetchProduct extends SaEvent {
  final String skinConcern;
  final String skinConcernLabel;

  FetchProduct(this.skinConcern, this.skinConcernLabel);
  @override
  List<Object?> get props => [skinConcern, skinConcernLabel];
}

class UpdateSkinConcern extends SaEvent {
  final String? value;

  const UpdateSkinConcern(this.value);

  @override
  List<Object?> get props => [value];
}
