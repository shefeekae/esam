
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'asset_condition_event.dart';
part 'asset_condition_state.dart';

class AssetConditionBloc
    extends Bloc<AssetConditionEvent, AssetConditionState> {
  AssetConditionBloc() : super(AssetConditionInitial(underMaintenance: true)) {
    on<ChangeAssetConditionEvent>((event, emit) {
      // TODO: implement event handler

       emit(AssetConditionState(underMaintenance: event.assetCondition));
    });
  }
}
