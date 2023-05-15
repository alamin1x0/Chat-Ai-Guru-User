import 'dart:developer';
import '../../bot_api/api_services.dart';
import '../../config.dart';

class ContentWriterController extends GetxController {
  String? selectedValue = "businessIdea";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List contentOptionList = [];
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 50.0);
  Rx<List<ContentMessage>> messages = Rx<List<ContentMessage>>([]);
  final contentController = TextEditingController();
  RxString contentInput = ''.obs;
  RxInt itemCount = 0.obs;
  List<String> shareMessages = ['--THIS IS CONVERSATION with AiGuru--\n\n'];
  RxInt contentCount = 0.obs;
  final FlutterTts? flutterTts = FlutterTts();
  final contentScrollController = ScrollController();
  Rx<bool> isLoading = Rx<bool>(false);
  final isSpeechLoading = false.obs;
  final isSpeech = false.obs;

  dynamic htmlData;

  @override
  void onReady() {
    // TODO: implement onReady
    addCtrl.onInterstitialAdShow();
    contentOptionList = appArray.contentOptionList;
    update();

    super.onReady();
  }

  //on option tap function
  onOptionTap(index) {
    final dashboardCtrl = Get.find<DashboardController>();
    if (index == 0) {
      dashboardCtrl.onBottomTap(1);
    } else if (index == 1) {
      dashboardCtrl.onBottomTap(2);
    } else {
      dashboardCtrl.onBottomTap(3);
    }
    dashboardCtrl.update();
  }

  //stop speech method
  speechStopMethod() async {
    isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  //listview scroll down
  void scrollDown() {
    contentScrollController.animateTo(
      contentScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  //add text count
  addTextCount() async {
    contentCount.value++;
    // LocalStorage.saveTextCount(count: count.value);
  }

  void processContentWrite() async {
    int balance = appCtrl.envConfig["balance"];
    if(balance == 0){
      appCtrl.balanceTopUpDialog();
    }else {
      int imageCount =
      int.parse(appCtrl.envConfig["textCompletionCount"].toString());
      if (imageCount == 0) {
        Get.snackbar(appFonts.attention.tr, appFonts.yourContentWriting.tr);
      } else {
        imageCount = imageCount - 1;
        appCtrl.envConfig["textCompletionCount"] = imageCount.toString();
        appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
        appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
        speechStopMethod();
        addTextCount();
        isLoading.value = true;
        update();
        messages.value.add(
          ContentMessage(
            text: contentController.text,
            textMessageType: ContentMessageType.user,
          ),
        );

        var input = contentController.text;
        contentInput.value = contentController.text;
        contentController.clear();
        update();
        log(":IS LOADING : #${isLoading.value}");

        ApiServices.chatCompeletionResponse(input).then((value) {
          log("value : $value");
          htmlData = value;
          update();

          isLoading.value = false;
          update();
        });
        final subscribeCtrl = Get.isRegistered<SubscriptionFirebaseController>()
            ? Get.find<SubscriptionFirebaseController>()
            : Get.put(SubscriptionFirebaseController());
        await subscribeCtrl.removeBalance();
        contentController.clear();
        update();
      }
    }
  }

  onTapContentGenerate() {
    FocusScope.of(Get.context!).unfocus();
    if (contentController.text.isNotEmpty) {
       processContentWrite();
    } else {
      Get.snackbar(appFonts.attention.tr,
          appFonts.enterTextBoxValue.tr);
    }
  }

}
