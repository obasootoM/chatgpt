class ChatModel {
  final String msg;
  final int index;

  ChatModel({required this.msg, required this.index});
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(msg: json['msg'], index: json['index']);
}
