

enum ContentMessageType { user, bot }

class ContentMessage {
  ContentMessage({
    required this.text,
    required this.textMessageType,
  });

  final String text;
  final ContentMessageType textMessageType;
}