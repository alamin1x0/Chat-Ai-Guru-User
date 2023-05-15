import 'dart:convert';
import 'dart:developer';
import '../../config.dart';
import 'package:http/http.dart' as http;

class ImageGeneratorController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List imageSizeLists = [];
  List viewTypeLists = [];
  List imageLists = [];
  List noOfImagesLists = [];
  List imageStyleLists = [];
  List moodLists = [];
  List imageColorLists = [];

  bool isFilter = false, isLoader = false;

  String? imageValue;
  String? viewValue;
  String? noOfImagesValue;
  String? imageStyleValue;
  String? moodValue;
  String? imageColorValue;
  ImageModel? imageGPTModel;
  RxInt count = 0.obs;

  var url = Uri.parse('https://api.openai.com/v1/images/generations');

  final TextEditingController imageTextController = TextEditingController();

  Future getGPTImage(
      {String? imageText, String? size = "256x256"}) async {
    log("imageText: $imageText");

    try {
      int balance = appCtrl.envConfig["balance"];
      if(balance == 0){
        appCtrl.balanceTopUpDialog();
      }else {
        Get.snackbar(appFonts.generated.tr, appFonts.pleaseWaitFor.tr);
        bool isLocalChatApi = appCtrl.storage.read(session.isChatGPTKey) ??
            false;
        if (isLocalChatApi == false) {
          final firebaseCtrl =
          Get.isRegistered<SubscriptionFirebaseController>()
              ? Get.find<SubscriptionFirebaseController>()
              : Get.put(SubscriptionFirebaseController());
          firebaseCtrl.removeBalance();
        }
        String localApi = appCtrl.storage.read(session.chatGPTKey) ?? "";
        String apiKey = "";
        if (localApi == "") {
          apiKey = appCtrl.firebaseConfigModel!.chatGPTKey!;
        } else {
          apiKey = localApi;
        }
        log("API $apiKey");
        update();
        var request = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode(
            {
              'prompt': imageText,
              'n': 5,
              "size": size,
            },
          ),
        );
        log(request.body);
        if (request.statusCode == 200) {
          addCountImage();
          imageGPTModel = ImageModel.fromJson(jsonDecode(request.body));
          update();
          Get.forceAppUpdate();
        } else {
          debugPrint(jsonDecode(request.body));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addCountImage() async {
    count.value++;
    // LocalStorage.saveImageCount(count: count.value);
  }

  onTapFilter() {
    isFilter = !isFilter;
    update();
  }

  // on tap method
  onTabMethod() async {
    addCtrl.onInterstitialAdShow();
    isLoader = true;
    FocusScope.of(Get.context!).unfocus();
    await getGPTImage(imageText: imageTextController.text.trim());

    isLoader = false;
  }

  @override
  void onReady() {
    imageLists = appArray.imageGeneratorList;
    imageSizeLists = appArray.imageSizeList;
    viewTypeLists = appArray.viewTypeList;

    noOfImagesLists = appArray.noOfImagesList;
    imageStyleLists = appArray.imageStyleList;
    moodLists = appArray.moodList;
    imageColorLists = appArray.imageColorList;

    update();
    // TODO: implement onReady
    super.onReady();
  }
}
