
import 'package:block_note/features/auth/domain/entity/block_entity.dart';
import 'package:block_note/features/auth/domain/repository/bloack_repository.dart';

class BlockUsecase {
  final BloackRepository repository;

  BlockUsecase(this.repository);

  Stream<List<BlockEntity>> call(String userId) {
    return repository.getBlocksByUser(userId);
  }

  Future<void> createBlock(BlockEntity block) async {
    return await repository.createBlockData(block);
  }

  Future<void> updateBlock(BlockEntity block) async {
    return await repository.updateBlock(block);
  }

  Future<void> deleteBlock(String blockId) async {
    return await repository.deleteBlock(blockId);
  }
}   