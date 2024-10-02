import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class BuildLiveWidget extends StatelessWidget {
  BuildLiveWidget({
    super.key,
    required this.liveList,
    required this.lastCommunicatedDateTime,
  });

  final List<Map> liveList;

  bool search = false;

  String searchValue = "";
  String lastCommunicatedDateTime;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, searchtState) {
        List<Map> searchedList = liveList.where((element) {
          String title = element['title'];

          return title.toLowerCase().contains(searchValue.toLowerCase());
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 7.sp,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: StatefulBuilder(builder: (context, setState) {
                return Row(
                  children: [
                    search
                        ? SizedBox(
                            width: 70.w,
                            child: CupertinoTextField(
                              cursorColor: primaryColor,
                              placeholder: "Search Points",
                              onChanged: (value) {
                                searchtState(() {
                                  searchValue = value;
                                });
                              },
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              text: "Last Communicated at  ",
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 8.sp,
                              ),
                              children: [
                                TextSpan(
                                  // text: "01 - Feb - 2023 2:20 PM",
                                  text: lastCommunicatedDateTime,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (search) {
                          searchtState(() {
                            searchValue = "";
                          });
                        }
                        setState(() {
                          search = !search;
                        });
                      },
                      icon: Icon(
                        search ? Icons.close : Icons.search,
                      ),
                    )
                  ],
                );
              }),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Builder(builder: (context) {
              if (searchedList.isEmpty) {
                return const Center(
                  child: Text("No data to show"),
                );
              }

              return Column(
                children: List.generate(
                  searchedList.length,
                  (index) {
                    String title = searchedList[index]['title'];
                    String value = searchedList[index]['value'];

                    return CustomListTileWidget(
                      title: title,
                      value: value,
                      visible: searchedList.length - 1 != index,
                    );
                  },
                ),
              );
            })
          ],
        );
      },
    );
  }
}

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    required this.title,
    required this.value,
    required this.visible,
  });

  final String title;
  final String value;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 50.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 10.sp,
              // ),
              Expanded(
                child: Text(
                  value,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: visible,
            child: Divider(
              height: 30.sp,
            ),
          ),
        ],
      ),
    );
  }
}
