part of 'asset_condition_bloc.dart';

class AssetConditionState {
  bool underMaintenance;

  AssetConditionState({
    required this.underMaintenance,
  });
}

class AssetConditionInitial extends AssetConditionState {
  AssetConditionInitial({required super.underMaintenance});
}


