// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../core/services/platform_services.dart';

class LoadingIosAndroidWidget extends StatelessWidget {
  const LoadingIosAndroidWidget({this.color, this.radius = 15, super.key});

  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    bool isAndroid = PlatformServices().checkPlatformIsAndroid(context);

    return !isAndroid
        ? Center(
            child: CupertinoActivityIndicator(
              radius: radius,
              color: color,
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
                // value: radius,

                ),
          );
  }
}

class BuildShimmerLoadingWidget extends StatelessWidget {
  BuildShimmerLoadingWidget({
    this.height,
    this.itemCount = 7,
    this.shrinkWrap = false,
    this.padding,
    this.borderRadius = 10,
    this.scrollDirection = Axis.vertical,
    this.width,
    super.key,
  });

  double? height;
  int itemCount;
  bool shrinkWrap;
  double? padding;
  double borderRadius;
  Axis scrollDirection;
  double? width;

  @override
  Widget build(BuildContext context) {
    height ??= 20.h;
    padding ??= 10.sp;

    return ListView.separated(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(padding!),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        height: 10.sp,
        width: 5.sp,
      ),
      itemBuilder: (context, index) {
        return Shimmer(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFEBEBF4),
              Color(0xFFF4F4F4),
              Color(0xFFEBEBF4),
            ],
            stops: [
              0.1,
              0.3,
              0.4,
            ],
            begin: Alignment(-1.0, -0.3),
            end: Alignment(1.0, 0.3),
            tileMode: TileMode.clamp,
          ),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: ThemeServices().getBgColor(context),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            height: height,
          ),
        );
      },
    );
  }
}

class ShimmerLoadingContainerWidget extends StatelessWidget {
  ShimmerLoadingContainerWidget(
      {this.height, this.width, this.borderRadius, super.key});

  double? height;
  double? width;
  double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        // width: 200,
        decoration: BoxDecoration(
          color: ThemeServices().getBgColor(context),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
