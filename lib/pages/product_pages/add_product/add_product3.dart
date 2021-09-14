import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:top_zone/controllers/products_controller.dart';
import 'package:top_zone/models/assets_model.dart';
import 'package:top_zone/models/brands_model.dart';
import 'package:top_zone/widgets/custom_dialogs.dart';
import 'package:top_zone/widgets/global_back_btn.dart';
import 'package:top_zone/widgets/global_btn.dart';
import 'package:top_zone/widgets/global_textfield.dart';

class AddProduct3 extends StatefulWidget {
  const AddProduct3({Key key}) : super(key: key);

  @override
  _AddProduct3State createState() => _AddProduct3State();
}




class _AddProduct3State extends State<AddProduct3> {





  final productsController = Get.find<ProductsController>();
  FocusNode focusNode = FocusNode();
  TextEditingController detailsController = TextEditingController();
  final List years = List.generate(23, (index) => index + 2000);
  List<SimilerAs> similerAs = [];
//  File _image;
  ImageSource source = ImageSource.gallery;

/*-----------------------------------  Get The Image Function  -----------------------------------*/


  List<Asset> images = <Asset>[];
  List<File> fileImageArray = [];
  Future convertImagesToFiles() async {
    images.forEach((imageAsset) async {
      final filePath =
      await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

      File tempFile = File(filePath);
      if (tempFile.existsSync()) {
        fileImageArray.add(tempFile);
      }
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8, // you can select maximum images from here
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#2896DB",
          actionBarTitle: "Zone",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#2978b5",
        ),
      );
    } on Exception catch (e) {
      throw e;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }



//  Future getImage() async {
//    final pickedFile = await ImagePicker.pickImage(source: source);
//
//    setState(() {
//      if (pickedFile != null) {
//        _image = File(pickedFile.path);
//        picImage = 'تم اختيار الصورة بنجاح';
//      } else {
//        print('No image selected.');
//      }
//    });
//  }

  String picImage =  'صورة توضيحية للوصف';

/*-----------------------------------  Get Source Function  -----------------------------------*/
// function the shows dialog to choose which source would you get the image from
// ImageSource.camera ----OR---- ImageSource.gallery
//  _getSource(context) async {
//    await showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(15),
//          ),
//          title: const Text('Choose Source'),
//          actions: [
//            /*------------------------  ImageSource.camera Btn  ------------------------*/
//            TextButton(
//              onPressed: () {
//                setState(() {
//                  source = ImageSource.camera;
//                });
//                Navigator.of(context).pop();
//              },
//              child: const Text('Camera'),
//            ),
//            /*------------------------  ImageSource.gallery Btn  ------------------------*/
//            TextButton(
//              onPressed: () {
//                setState(() {
//                  source = ImageSource.gallery;
//                });
//                Navigator.of(context).pop();
//              },
//              child: const Text('Gallery'),
//            ),
//          ],
//        );
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'اضافة منتج',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GlobalBackBtn(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.black,
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                width: Get.mediaQuery.size.width * 0.9,
                child: GlobalTextField.outlineBorder(
                  focusNode: focusNode,
                  controller: detailsController,
                  borderColor: Colors.black,
                  borderRadius: 15,
                  fillColor: Colors.white,
                  hint: 'وصف المنتج',
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.3),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    Text(
                      images.length<1 ?
                      picImage : "تم اضافة الصور",
                      style: TextStyle(
                        color: (images.length >= 1)
                            ? Get.theme.colorScheme.secondary
                            : Colors.black,
                        fontWeight: (images.length >= 1)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    MaterialButton(
                      onPressed: () async {
                        await loadAssets();
                        await convertImagesToFiles();
                      },
                      child: Text('ارفاق'),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              images.length <1 ? Container (): Container(
                height: 150,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    (images.length < 1) == true
                        ? Container()
                        : Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        height: 120,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return _oneImgFileAsset(images[index], index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'يتطابق مع',
                      style: Get.textTheme.subtitle1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        focusNode.unfocus();
                        SimilerAs similerItem = SimilerAs();
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(25)),
                          ),
                          context: context,
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            height: Get.mediaQuery.size.height * 0.5,
                            child: FutureBuilder<List<BrandsModel>>(
                                future: productsController.getProductbrands(),
                                builder: (context, snapshot) {
                                  return (snapshot.hasData)
                                      ? ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) =>
                                              GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                similerItem.brandID =
                                                    snapshot.data[index].id;
                                                similerItem.brandeName =
                                                    snapshot.data[index].name;
                                              });

                                              Navigator.of(context).pop();
                                              showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              25)),
                                                ),
                                                context: context,
                                                builder: (context) => Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: double.infinity,
                                                  height: Get.mediaQuery.size
                                                          .height *
                                                      0.5,
                                                  child: FutureBuilder<
                                                          AssetsModel>(
                                                      future: productsController
                                                          .getProductassets2(
                                                              snapshot
                                                                  .data[index]
                                                                  .id),
                                                      builder:
                                                          (context, snapshott) {
                                                        return (snapshott
                                                                .hasData)
                                                            ? ListView.builder(
                                                                itemCount:
                                                                    snapshott
                                                                        .data
                                                                        .data
                                                                        .length,
                                                                itemBuilder: (context,
                                                                        indexx) =>
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      similerItem.assetId = snapshott
                                                                          .data
                                                                          .data[
                                                                              indexx]
                                                                          .id;
                                                                      similerItem.assetname = snapshott
                                                                          .data
                                                                          .data[
                                                                              indexx]
                                                                          .name;
                                                                    });

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showModalBottomSheet(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.vertical(top: Radius.circular(25)),
                                                                      ),
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              Container(
                                                                        padding:
                                                                            const EdgeInsets.all(15),
                                                                        width: double
                                                                            .infinity,
                                                                        height: Get.mediaQuery.size.height *
                                                                            0.5,
                                                                        child: ListView
                                                                            .builder(
                                                                          itemCount:
                                                                              years.length,
                                                                          itemBuilder: (context, i) =>
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                similerItem.modelId = years[i];
                                                                                similerItem.modelname = years[i].toString();
                                                                              });

                                                                              setState(() {
                                                                                similerAs.add(similerItem);
                                                                              });
                                                                              Navigator.of(context).pop();
                                                                              customSnackBar('تم اختيار موديل السياره بنجاح', CupertinoIcons.checkmark_seal);
                                                                            },
                                                                            child:
                                                                                Card(
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(18),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(26.0),
                                                                                child: Text(
                                                                                  '${years[i]}',
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                    customSnackBar(
                                                                        'تم اختيار فئة السياره بنجاح',
                                                                        CupertinoIcons
                                                                            .checkmark_seal);
                                                                  },
                                                                  child: Card(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              18),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          26.0),
                                                                      child:
                                                                          Text(
                                                                        '${snapshott.data.data[indexx].name}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Center(
                                                                child:
                                                                    SpinKitThreeBounce(
                                                                duration: const Duration(
                                                                    milliseconds:
                                                                        1200),
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                                size: 25,
                                                              ));
                                                      }),
                                                ),
                                              );
                                              customSnackBar(
                                                  'تم اختيار نوع السياره بنجاح',
                                                  CupertinoIcons
                                                      .checkmark_seal);
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(26),
                                                child: Text(
                                                  '${snapshot.data[index].name}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: SpinKitThreeBounce(
                                          duration: const Duration(
                                              milliseconds: 1200),
                                          color:
                                              Get.theme.colorScheme.secondary,
                                          size: 25,
                                        ));
                                }),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (similerAs.isNotEmpty)
                ListView.builder(
                  itemCount: similerAs.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(index.isEven ? 14 : 0),
                        border: index.isEven ? Border.all(width: 1.3) : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${similerAs[index].brandeName}",
                            // style: lightStyle.copyWith(fontSize: 14),
                          ),
                          Text(
                            "${similerAs[index].assetname} (${similerAs[index].modelId})",
                            // style: lightStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(height: 40),
              Obx(
                () => (productsController.addProductLoading.value)
                    ? SpinKitThreeBounce(
                        duration: const Duration(milliseconds: 1200),
                        color: Get.theme.colorScheme.secondary,
                        size: 25,
                      )
                    : GlobalBtn(
                        title: 'اعلان المنتج',
                        onTap: () async {
                          productsController.details.value =
                              detailsController.text;
                          //productsController.descphoto.value = _image;
                          List<int> brandid = [];
                          similerAs.forEach((element) {
                            brandid.add(element.brandID);
                          });
                          productsController.brands.value = brandid;

                          List<int> assets = [];
                          similerAs.forEach((element) {
                            assets.add(element.assetId);
                          });
                          productsController.assets.value = assets;

                          List<int> model = [];
                          similerAs.forEach((element) {
                            model.add(element.modelId);
                          });
                          productsController.models.value = model;
                          await productsController.addProduct();
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _oneImgFileAsset(Asset img, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AssetThumb(
                    asset: img,
                    width: 300,
                    height: 300,
                    spinner: Center(
                        child: SpinKitThreeBounce(
                          duration: const Duration(milliseconds: 1200),
                          color: Get.theme.colorScheme.secondary,
                          size: 25,
                        )),
                  )),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  images.removeAt(index);
                });
              },
              child: Material(
                color: Colors.white,
                elevation: 2,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: const Icon(Icons.close, size: 18, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SimilerAs {
  String brandeName;
  int brandID;
  String assetname;
  int assetId;
  String modelname;
  int modelId;

  SimilerAs(
      {this.brandeName,
      this.brandID,
      this.assetname,
      this.assetId,
      this.modelname,
      this.modelId});
}




// http://topzoneksa.com