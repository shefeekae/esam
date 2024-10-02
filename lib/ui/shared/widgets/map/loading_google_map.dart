


import 'package:flutter/material.dart';

import 'google_map_widget.dart';

class GoogleMapLoadingWidget extends StatelessWidget {
  const GoogleMapLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        Opacity(
          opacity: 0.3,
          child: GoogleMapWidget(),
        ),
      ],
    );
  }
}
