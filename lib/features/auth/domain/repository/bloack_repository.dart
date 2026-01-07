
import 'package:block_note/features/auth/domain/entity/block_entity.dart';

abstract class BloackRepository {
  Future<void> createBlockData(BlockEntity block);
  Stream<List<BlockEntity>> getBlocksByUser(String userId);
  Future<void> updateBlock(BlockEntity block);
  Future<void> deleteBlock(String blockId);
}