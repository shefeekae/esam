part of 'asset_condition_bloc.dart';

@immutable
abstract class AssetConditionEvent {}

class ChangeAssetConditionEvent extends AssetConditionEvent {
  bool assetCondition;

  ChangeAssetConditionEvent({
    required this.assetCondition,
  });
}
