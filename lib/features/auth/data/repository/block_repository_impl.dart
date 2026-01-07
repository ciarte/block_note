import 'package:block_note/features/auth/data/datasource/block_datasource.dart';
import 'package:block_note/features/auth/data/model/block_model.dart';
import 'package:block_note/features/auth/domain/entity/block_entity.dart';
import 'package:block_note/features/auth/domain/repository/bloack_repository.dart';

class BlockRepositoryImpl implements BloackRepository {
  final BlockDatasource datasource;

  BlockRepositoryImpl({BlockDatasource? datasource})
      : datasource = datasource ?? BlockDatasource();

  @override
  Future<void> createBlockData(BlockEntity block) async {
    final model = BlockModel.fromEntity(block);
    await datasource.createBlock(model);
  }

  @override
  Stream<List<BlockEntity>> getBlocksByUser(String userId) {
    return datasource.streamBlocksByUser(userId).map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );
  }

  @override
  Future<void> updateBlock(BlockEntity block) async {
    final model = BlockModel.fromEntity(block);
    await datasource.updateBlock(model);
  }

  @override
  Future<void> deleteBlock(String blockId) async {
    await datasource.deleteBlock(blockId);
  }
}
