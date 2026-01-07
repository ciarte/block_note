import 'package:block_note/features/auth/domain/entity/block_entity.dart';

class BlockModel extends BlockEntity {
  BlockModel({
    required super.id,
    required super.title,
    required super.content,
    required super.userId,
    required super.createdAt,
    super.updatedAt,
    super.iconData,
  });

  factory BlockModel.fromMap(String id, Map<String, dynamic> map) {
    return BlockModel(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      userId: map['userId'],
      iconData: map['iconData'],
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt']?.toDate(),
    );
  }

  factory BlockModel.fromEntity(BlockEntity entity) {
    return BlockModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      userId: entity.userId,
      iconData: entity.iconData,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  BlockEntity toEntity() {
    return BlockEntity(
      id: id,
      title: title,
      content: content,
      userId: userId,
      iconData: iconData,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'userId': userId,
      'iconData': iconData,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
