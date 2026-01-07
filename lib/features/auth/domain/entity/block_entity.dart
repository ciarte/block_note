
class BlockEntity {
  final String id;
  final String title;
  final String content;
  final String userId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? iconData;

  BlockEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
    this.iconData,
  });

    Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'iconData': iconData,
    };
  }

  BlockEntity copyWith({
    String? title,
    String? content,
    DateTime? updatedAt,
    int? iconData,
  }) {
    return BlockEntity(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      iconData: iconData ?? this.iconData,
    );
  }
}