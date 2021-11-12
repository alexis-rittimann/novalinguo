// import 'package:novalinguo/models/user.dart';

class ChatParams {
  final String userUid;
  final String peer;

  ChatParams(this.userUid, this.peer);

  String getChatGroupId() {
    if (userUid.hashCode <= peer.hashCode) {
      return '$userUid-${peer}';
    } else {
      return '${peer}-$userUid';
    }
  }
}
