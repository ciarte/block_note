import 'package:hive/hive.dart';
import 'block_entity.dart';

class BlockEntityAdapter extends TypeAdapter<BlockEntity> {
  @override
  final int typeId = 0;

  @override
  BlockEntity read(BinaryReader reader) {
    return BlockEntity(
      id: reader.readString(),
      title: reader.readString(),
      content: reader.readString(),
      userId: reader.readString(),
      iconData: reader.readInt(),
      createdAt: DateTime.parse(reader.readString()),
      updatedAt: reader.readBool() ? DateTime.parse(reader.readString()) : null,
    );
  }

  @override
  void write(BinaryWriter writer, BlockEntity obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.content);
    writer.writeString(obj.userId);
    writer.writeInt(obj.iconData ?? 0);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeBool(obj.updatedAt != null);
    if (obj.updatedAt != null) writer.writeString(obj.updatedAt!.toIso8601String());
  }
}
