import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  GoogleMapWidget(
      {this.target,
      this.zoom = 4.0,
      this.markers = const {},
      this.useFiltBounds = true,
      super.key});

  final Set<Marker> markers;
  final double zoom;
  final LatLng? target;
  final bool useFiltBounds;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      buildingsEnabled: true,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      mapToolbarEnabled: true,
      markers: markers,
      onMapCreated: (controller) {
        _controller.complete(controller);

        if (markers.isNotEmpty) {
          controller.showMarkerInfoWindow(markers.first.markerId);

          if (useFiltBounds) {
            LatLngBounds? bounds = calculateBounds();

            _fitBounds(controller, bounds);
          }
        }
      },
      initialCameraPosition: CameraPosition(
        target: target ?? const LatLng(25.2048, 55.2708),
        zoom: zoom,
      ),
    );
  }

  LatLngBounds? calculateBounds() {
    if (markers.isNotEmpty) {
      double minLat = markers.first.position.latitude;
      double maxLat = markers.first.position.latitude;
      double minLng = markers.first.position.longitude;
      double maxLng = markers.first.position.longitude;

      for (var marker in markers) {
        if (marker.position.latitude < minLat) {
          minLat = marker.position.latitude;
        }
        if (marker.position.latitude > maxLat) {
          maxLat = marker.position.latitude;
        }
        if (marker.position.longitude < minLng) {
          minLng = marker.position.longitude;
        }
        if (marker.position.longitude > maxLng) {
          maxLng = marker.position.longitude;
        }
      }

      return LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );
    }
    return null;
  }

  void _fitBounds(GoogleMapController mapController, LatLngBounds? bounds) {
    if (bounds != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
          150,
        ),
      );
    }
  }
}
