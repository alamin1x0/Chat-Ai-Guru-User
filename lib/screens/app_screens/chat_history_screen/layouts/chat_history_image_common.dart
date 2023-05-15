import '../../../../config.dart';

class ChatHistoryImageCommon extends StatelessWidget {
  final dynamic data;
  const ChatHistoryImageCommon({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: data["avatar"],
        height: Sizes.s44,
        width: Sizes.s50,
        fit: BoxFit.fill,
        imageBuilder: (context, imageProvider) => SizedBox(
            height: Sizes.s44,
            width: Sizes.s50,
            child: Column(children: [
              Image.network(data["avatar"].toString(),
                  height: Sizes.s40, width: Sizes.s40, fit: BoxFit.fill)
            ])),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.network(
            appCtrl.selectedCharacter["image"].toString(),
            height: Sizes.s40,
            width: Sizes.s40,
            fit: BoxFit.fill));
  }
}
