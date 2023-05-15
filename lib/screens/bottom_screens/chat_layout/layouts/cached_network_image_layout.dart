import '../../../../config.dart';

class CachedNetworkImageLayout extends StatelessWidget {
  const CachedNetworkImageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(
      builder: (chatCtrl) {
        return CachedNetworkImage(
            imageUrl: chatCtrl.argImage!,
            width: Sizes.s50,
            height: Sizes.s50,
            fit: BoxFit.fill,
            imageBuilder: (context, imageProvider) => Container(
                height: Sizes.s50,
                width: Sizes.s50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:
                        NetworkImage(chatCtrl.argImage!)))),
            placeholder: (context, url) =>
            const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Container(
                height: Sizes.s50,
                width: Sizes.s50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(appCtrl
                            .selectedCharacter["image"])))));
      }
    );
  }
}
