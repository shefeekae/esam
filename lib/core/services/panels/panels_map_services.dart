import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nectar_assets/core/services/alarms/alarms_map_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/panel_details_screen.dart';

import '../../../ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import '../../models/asset/assets_list_model.dart';
import '../../schemas/assets_schema.dart';
import '../assets/assets_services.dart';
import '../graphql_services.dart';

class PanelsMapServices {
  //  ================================================================================================

  Set<Marker> convertToMarkerData({
    required BuildContext context,
    required List<Assets> assets,
    required BitmapDescriptor customIcon,
  }) {
    Set<Marker> customMarkers = {};

    for (var element in assets) {
      if (element.location != null) {
        LatLng? latLng = AssetsServices().parseWktPoint(element.location!);

        BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

        bool hasAlarm = element.points?.any((element) =>
                element.pointName == "Common Alarm" &&
                element.data != "Normal") ??
            false;

        if (hasAlarm) {
          icon = customIcon;
        }

        if (latLng != null) {
          customMarkers.add(
            Marker(
              markerId: MarkerId(element.identifier!),
              position: latLng,
              icon: icon,
              infoWindow: InfoWindow(
                anchor: const Offset(2, 4),
                title: element.displayName,
                snippet: element.clientName,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(PanelDetailsScreen.id, arguments: {
                    "domain": element.domain,
                    "identifier": element.identifier,
                  });
                },
              ),
            ),
          );
        }
      }
    }

    return customMarkers;
  }

  Future<Set<Marker>> getFirePanelsAndAlarms({
    required BuildContext context,
    required Map<String, dynamic> payload,
  }) async {
    var result = await GraphqlServices().performQuery(
      query: AssetSchema.getAssetList,
      variables: {
        "filter": payload,
      },
    );

    if (result.hasException) {
      return {};
    }

    AssetsListModel assetsListModel =
        AssetsListModel.fromJson(result.data ?? {});

    List<Assets> assets = assetsListModel.getAssetList?.assets ?? [];

    var bytes = await AlarmsMapServices().getBytesFromAsset(
      "assets/images/fire_image.png",
      100,
    );

    BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(bytes);

    if (context.mounted) {
      return convertToMarkerData(
        context: context,
        assets: assets,
        customIcon: bitmapDescriptor,
      );
    }

    return {};
  }
}
