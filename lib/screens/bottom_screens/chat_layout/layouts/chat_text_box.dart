import '../../../../config.dart';

class ChatTextBox extends StatelessWidget {
  const ChatTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return GetBuilder<AppController>(builder: (appCtrl) {
        return const SubscribeTextBox();
      });
    });
  }
}
