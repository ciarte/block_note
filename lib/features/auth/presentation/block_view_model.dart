
import 'package:block_note/features/auth/domain/entity/block_entity.dart';
import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/usecase/block_usecase.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BlockViewModel extends ChangeNotifier {
  final BlockUsecase blockUsecase;
  final UserEntity user;

  BlockViewModel({
    required this.blockUsecase,
    required this.user,
  });


  bool isLoading = true;
  String? errorMessage;
  IconData? iconData;
  List<BlockEntity> blocks = [];
  StreamSubscription<List<BlockEntity>>? _blocksSub;

  void start() {
    _blocksSub?.cancel();

    _blocksSub = blockUsecase.call(user.id).listen(
      (data) {
        blocks = data;
        isLoading = false;
        errorMessage = null;
        notifyListeners();
      },
      onError: (e) {
        errorMessage = 'Error loading blocks';
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _blocksSub?.cancel();
    super.dispose();
  }

  Future<void> createBlock(String title, String content) async {
    final block = BlockEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      userId: user.id,
      iconData: iconData?.codePoint ?? Icons.note.codePoint,
      createdAt: DateTime.now(),
    );

    try {
      await blockUsecase.createBlock(block);
    } catch (e) {
      errorMessage = 'Error creating block';
      notifyListeners();
    }
  }

  Future<void> updateBlock(BlockEntity block) async {
    try {
      await blockUsecase.updateBlock(block);
    } catch (e) {
      errorMessage = 'Error updating block';
      notifyListeners();
    }
  }

  Future<void> deleteBlock(String blockId) async {
    try {
      await blockUsecase.deleteBlock(blockId);
    } catch (e) {
      errorMessage = 'Error deleting block';
      notifyListeners();
    }
  }


  void selectIcon(IconData icon) {
    iconData = icon;
    notifyListeners();
  }
}
