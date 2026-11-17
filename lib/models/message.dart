class Message {
  final String text;
  final bool isUser;

  const Message({
    required this.text,
    required this.isUser,
  });

  String get role => isUser ? 'user' : 'assistant';

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': text,
    };
  }
}