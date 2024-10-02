import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/alarms_details.dart';
import '../../schemas/alarms_schema.dart';
import '../graphql_services.dart';
import 'dart:ui' as ui;
import 'package:nectar_assets/core/services/assets/assets_services.dart';

class AlarmsMapServices {
  Set<Marker> convertToMarkerData({
    required BuildContext context,
    required List<EventLogs> alarms,
    BitmapDescriptor? customMarker,
  }) {
    Set<Marker> customMarkers = {};

    for (var element in alarms) {
      if (element.location != null) {
        LatLng? latLng = AssetsServices().parseWktPoint(element.location!);

        if (latLng != null) {
          customMarkers.add(
            Marker(
              markerId: MarkerId(element.eventId!),
              position: latLng,
              icon: customMarker ?? BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: element.name ?? "",
                snippet: element.clientName,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AlarmsDetailsScreen.id,
                    arguments: {
                      "identifier": element.eventId,
                    },
                  );
                },
              ),
            ),
          );
        }
      }
    }

    return customMarkers;
  }

// =============================================================================

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // ============================================================================

  // Get Fire Alarms

  Future<Set<Marker>> getFireAlarmsMarkersforGoogleMap({
    required BuildContext context,
    required Map<String, dynamic> payload,
  }) async {
    var result = await GraphqlServices().performQuery(
      query: AlarmsSchema.listAlarmsQuery,
      variables: {
        "filter": payload,
      },
    );

    if (result.hasException) {
      return {};
    }

    var model = ListAlarmsModel.fromJson(result.data ?? {});

    List<EventLogs> eventLogs = model.listAlarms?.eventLogs ?? [];

    var bytes = await getBytesFromAsset(
      "assets/images/fire_image.png",
      100,
    );

    BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(bytes);

    if (context.mounted) {
      return convertToMarkerData(
        context: context,
        alarms: eventLogs,
        customMarker: bitmapDescriptor,
      );
    }

    return {};
  }
}
