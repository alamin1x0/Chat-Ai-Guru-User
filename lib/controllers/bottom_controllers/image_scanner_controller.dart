import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../config.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageScannerController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List imageScannerList = [];
  int selectedIndex = 0;
  final ImagePicker picker = ImagePicker();
  XFile? pickedFile;
  CroppedFile? croppedFile;
  List<XFile>? imageFileList;
  dynamic pickImageError;
  final textRecognizer = TextRecognizer();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 350,
        maxHeight: 300,
      );
      setImageFileListFromFile(pickedFile!);
      update();
      cropImage(pickedFile!.path, context!);
    } catch (e) {
      pickImageError = e;
    }
    update();
  }

  Widget image(context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (croppedFile != null) {
      final path = croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.9 * screenWidth,
          maxHeight: 300,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (pickedFile != null) {
      final path = pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.9 * screenWidth,
          maxHeight: 300,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> cropImage(imageFileList, context) async {
    if (imageFileList != null) {
      final croppedFileNew = await ImageCropper().cropImage(
        sourcePath: imageFileList,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: appCtrl.appTheme.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Image',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      scanImage(croppedFileNew!.path, context);
      croppedFile = croppedFileNew;
      update();
    }
  }

  Future<void> scanImage(pickFile, context) async {
    try {
      final file = File(pickFile);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);
      int balance = appCtrl.envConfig["balance"];
      if (recognizedText.text.isNotEmpty) {
        if (balance == 0) {
          appCtrl.balanceTopUpDialog();
          update();
        } else {
          Get.toNamed(routeName.chatLayout,
              arguments: {"recText": recognizedText.text});
          final chatCtrl = Get.isRegistered<ChatLayoutController>()
              ? Get.find<ChatLayoutController>()
              : Get.put(ChatLayoutController());
          chatCtrl.getChatId();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred when scanning text'),
          ),
        );
      }
    } catch (e) {
        log("$e");
    }
  }

  void setImageFileListFromFile(XFile? value) {
    imageFileList = value == null ? null : <XFile>[value];
  }

  onScanFrom(index, context) {
    // selectedIndex = index;
    log(index);
    if (index == "0") {
      _onImageButtonPressed(ImageSource.camera, context: context);
    } else {
      _onImageButtonPressed(ImageSource.gallery, context: context);
    }
    update();
  }

  @override
  void onReady() {
    imageScannerList = appArray.imageScannerList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
