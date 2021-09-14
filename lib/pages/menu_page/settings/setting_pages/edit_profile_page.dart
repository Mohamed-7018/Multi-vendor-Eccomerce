import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_zone/controllers/profile_controller.dart';
import 'package:top_zone/pages/menu_page/settings/setting_pages/change_location.dart';
import 'package:top_zone/widgets/appBtn.dart';
import 'package:top_zone/widgets/custom_alerts.dart';
import 'package:top_zone/widgets/custom_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_zone/widgets/custom_rate_bar.dart';
import 'package:top_zone/widgets/custom_text_field.dart';
import 'package:top_zone/widgets/image_picker_sheet%20copy.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

const mediumStyle = TextStyle(
  fontWeight: FontWeight.normal,
  fontFamily: "Tajawal-Medium",
);

class _EditProfilePageState extends State<EditProfilePage> {

  final profileController = Get.find<ProfileController>();
  final userNameController = TextEditingController();
  final phoneNumbrerController = TextEditingController();
  final shopOwnerController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  double lat;
  double long;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar:
              customShopAppBar(context, title: "تعديل الحساب", withBack: true),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black, width: 2),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/error.png",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Medhat Mostafa",
                                style: mediumStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomRateBar(
                                rate: 5,
                                size: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: SvgPicture.asset("assets/svg/edit1.svg"),
                        color: Colors.black,
                        onPressed: changePhoto,
                      ),
                    ),
                  ],
                ),
              ),
//              Center(
//                child: Row(
//                  mainAxisSize: MainAxisSize.min,
//                  children: [
//                    Container(
//                      padding: EdgeInsets.all(24),
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(12),
//                        border: Border.all(width: 2, color: Colors.black),
//                        color: Color(0xFF0097FE),
//                      ),
//                      height: 100,
//                      width: 100,
//                      child: SvgPicture.asset(
//                        "assets/svg/setting.svg",
//                      ),
//                    ),
//                  ],
//                ),
//              ),
              const SizedBox(height: 50),
              CustomTextField(
                controller: userNameController,
                hint: "اسم المتجر",
                keyboardType: TextInputType.name,
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: phoneNumbrerController,
                hint: "رقم الهاتف",
                keyboardType: TextInputType.name,
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: shopOwnerController,
                hint: "اسم مالك المتجر",
                keyboardType: TextInputType.name,
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: emailController,
                hint: "البريد الالكتروني",
                keyboardType: TextInputType.name,
                prefixIcon: Icon(Icons.email_outlined),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 1.3),
                ),
                width: Get.mediaQuery.size.width * 0.9,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        'الكمية',
                        style: Get.textTheme.bodyText1
                            .copyWith(color: Colors.black45),
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Get.theme.colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChangeLocation()),
                            );
                          },
                          child:Text (
                            'تغيير العنوان'
                          ),
                        ),
                      ),

                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              SizedBox(height: 60),
              BtnApp(
                title: "حفظ",
                onTap: () async {
                  profileController.name.value = userNameController.text;
                  profileController.email.value = emailController.text;
                  profileController.ownerName.value = shopOwnerController.text;
                  profileController.vendorEditProfile();
                },
              )
            ],
          ),
        ));
  }




  changePhoto() {
    File file;
    displayBottomSheet(
      context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text(
                "اضف صورة للمتجر",
                style: mediumStyle.copyWith(fontSize: 20),
              ),
              SizedBox(height: 16),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: 16),
              Container(
                height: 110,
                width: 110,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 2, color: Colors.black),
                        ),
                        child: file != null
                            ? Image.file(
                          file,
                          fit: BoxFit.fill,
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/error.png",
                          ),
                        ),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          ImagePickerDialog().show(
                              context: context,
                              onGet: (f) {
                                setState(() {
                                  file = f;
                                });
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border:
                            Border.all(width: 2, color: Color(0xFF0097FE)),
                          ),
                          child: SvgPicture.asset("assets/svg/edit1.svg",
                              color: Color(0xFF0097FE)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BtnApp(
                  title: "حفظ",
                  onTap: () {},
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
