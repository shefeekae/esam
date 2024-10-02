// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_filter_form/widgets/asset_update/asset_profile_update.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';

import '../../../../../../shared/widgets/required_text_with_container_listtile.dart';

class EquipmentProfileScreen extends StatelessWidget {
  EquipmentProfileScreen({super.key});

  static const String id = '/equipments/details/profile';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    args?['assetEntity'] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: AssetProfileUpdateForm(
        assetEntity: args?['assetEntity'] ?? {},
        // const {
        //   "type": "TertiaryPump",
        //   "data": {
        //     "identifier": "c89fb57b-7cb9-4003-8ac3-3879a884afd9",
        //     "domain": "buildingdemo"
        //   },
        // },
        assetInfoData: args?['assetInfoData'] ?? {},
        saveSuccessHandler: (value) {
          Navigator.of(context).pop(true);
        },
        // {
        //   "domain": "buildingdemo",
        //   "name": "603aba7b-4be3-4298-96db-b3d20100f85e-S A1 Tertiary Pump 03",
        //   "identifier": "c89fb57b-7cb9-4003-8ac3-3879a884afd9",
        //   "make": "",
        //   "model": "",
        //   "displayName": "S A1 Tertiary Pump 03 - edited",
        //   "sourceTagPath":
        //       "%5B%7B%22type%22%3A%22DefaultTenant%22%2C%22topic%22%3A%22buildingdemo%22%2C%22name%22%3A%22Building%20Demo%22%2C%22parentType%22%3A%22Domain%22%2C%22domain%22%3A%22nectarit%22%2C%22identifier%22%3Anull%2C%22annotation%22%3Anull%2C%22order%22%3A0%2C%22showInPath%22%3Atrue%7D%2C%7B%22type%22%3A%22Community%22%2C%22topic%22%3A%22sobha%22%2C%22name%22%3A%22Nectar%20Smart%20District%22%2C%22parentType%22%3A%22Community%22%2C%22domain%22%3A%22buildingdemo%22%2C%22identifier%22%3Anull%2C%22annotation%22%3Anull%2C%22order%22%3A0%2C%22showInPath%22%3Atrue%7D%2C%7B%22type%22%3A%22SubCommunity%22%2C%22topic%22%3A%22b56c1a0a-cb1d-4f53-84a6-c8cf206a866b%22%2C%22name%22%3A%22Cyber%20Park%22%2C%22parentType%22%3A%22SiteGroup%22%2C%22domain%22%3A%22buildingdemo%22%2C%22identifier%22%3Anull%2C%22annotation%22%3Anull%2C%22order%22%3A0%2C%22showInPath%22%3Atrue%7D%2C%7B%22type%22%3A%22ResidentialTower%22%2C%22topic%22%3A%22603aba7b-4be3-4298-96db-b3d20100f85e%22%2C%22name%22%3A%22Nectar%20Headoffice%22%2C%22parentType%22%3A%22Site%22%2C%22domain%22%3A%22buildingdemo%22%2C%22identifier%22%3Anull%2C%22annotation%22%3Anull%2C%22order%22%3A0%2C%22showInPath%22%3Atrue%7D%2C%7B%22type%22%3A%22Room%22%2C%22topic%22%3A%223bee10d9-ac79-4b5a-911c-36bb828b59a8%22%2C%22name%22%3A%22Room%20102%22%2C%22parentType%22%3A%22Space%22%2C%22domain%22%3A%22buildingdemo%22%2C%22identifier%22%3Anull%2C%22annotation%22%3Anull%2C%22order%22%3A0%2C%22showInPath%22%3Atrue%7D%2C%7B%22type%22%3A%22Room%22%2C%22topic%22%3A%223010cd18-131a-479c-a333-a3f13a1bdb1d%22%2C%22name%22%3A%22Staging%20Room%22%2C%22parentType%22%3A%22Space%22%2C%22domain%22%3A%22buildingdemo%22%2C%22identifier%22%3Anull%2C%22annotation%22%3Anull%2C%22order%22%3A0%2C%22showInPath%22%3Atrue%7D%2C%7B%22type%22%3A%22TertiaryPump%22%2C%22topic%22%3A%22c89fb57b-7cb9-4003-8ac3-3879a884afd9%22%2C%22name%22%3A%22S%20A1%20Tertiary%20Pump%2003%20-%20edited%22%2C%22parentType%22%3A%22Equipment%22%2C%22domain%22%3A%22buildingdemo%22%2C%22identifier%22%3Anull%2C%22annotation%22%3Anull%2C%22order%22%3A0%2C%22showInPath%22%3Atrue%7D%5D",
        //   "ddLink":
        //       "../files/graphics/2D/Atlantis CHWS Twin=>0a620d9e-2469-4810-bc0f-b3619fd4df69=>V2.json",
        //   "dddLink": "",
        //   "profileImage": "",
        //   "status": "ACTIVE",
        //   "createdOn": 1657015313394,
        //   "assetCode": "",
        //   "typeName": "Tertiary Pump",
        //   "ownerClientId": "sobha"
        // },
      ),
      // Padding(
      //   padding: EdgeInsets.all(10.sp),
      //   child: Column(
      //     children: [
      //       Expanded(child: listViewBuilder()),
      //       saveButton(),
      //     ],
      //   ),
      // ),
    );
  }

  // =====================================

  CustomElevatedButton saveButton() {
    return const CustomElevatedButton(
      title: "Save",
    );
  }
}
