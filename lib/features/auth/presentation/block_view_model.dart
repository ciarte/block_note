import 'package:block_note/features/auth/domain/entity/block_entity.dart';
import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/usecase/block_usecase.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

class BlockViewModel extends ChangeNotifier {
  final BlockUsecase blockUsecase;
  final UserEntity user;

  BlockViewModel({
    required this.blockUsecase,
    required this.user,
  }) {
    _loadLocalBlocks();
    _startFirestoreListener();
    _startConnectivityListener();
  }

  bool isLoading = true;
  String? errorMessage;
  IconData? iconData;
  List<BlockEntity> blocks = [];
  late Box<BlockEntity> _localBox;
  StreamSubscription<List<BlockEntity>>? _blocksSub;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  Set<String> pendingSyncIds = {};
  bool isPending(BlockEntity block) => pendingSyncIds.contains(block.id);

  void start() {
    _blocksSub?.cancel();

    _blocksSub = blockUsecase.stream(user.id).listen(
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

  Future<void> _loadLocalBlocks() async {
    _localBox = Hive.box<BlockEntity>('blocks');
    blocks = _localBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    isLoading = false;
    notifyListeners();
  }

  void _startFirestoreListener() {
    _blocksSub?.cancel();
    _blocksSub = blockUsecase.stream(user.id).listen((remoteBlocks) {
      for (var block in remoteBlocks) {
        _localBox.put(block.id, block);
        pendingSyncIds.remove(block.id);
      }
      blocks = _localBox.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    }, onError: (e) {
      errorMessage = 'Error syncing blocks';
      notifyListeners();
    });
  }

  void _startConnectivityListener() {
    _connectivitySub?.cancel();
    _connectivitySub = Connectivity().onConnectivityChanged.listen((result) {
      if (result.first != ConnectivityResult.none) {
        _syncPendingBlocks();
      }
    });
  }

  Future<void> _syncPendingBlocks() async {
    if (pendingSyncIds.isEmpty) return;

    final idsToRemove = <String>[];
    for (final id in pendingSyncIds) {
      final block = _localBox.get(id);
      if (block != null) {
        try {
          await blockUsecase.createBlock(block);
          idsToRemove.add(id);
        } catch (_) {}
      }
    }
    if (idsToRemove.isNotEmpty) {
      pendingSyncIds.removeAll(idsToRemove);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _blocksSub?.cancel();
    super.dispose();
  }

  Future<void> createBlock(
      BuildContext context, String title, String content) async {
    final block = BlockEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      userId: user.id,
      iconData: iconData?.codePoint ?? Icons.note.codePoint,
      createdAt: DateTime.now(),
    );

    _localBox.put(block.id, block);
    blocks.insert(0, block);
    notifyListeners();

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.first == ConnectivityResult.none) {
      pendingSyncIds.add(block.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'There is no internet connection. The note was saved locally and will be synced later..'),
          ),
        );
      }
      return;
    }
    try {
      await blockUsecase.createBlock(block);
      pendingSyncIds.remove(block.id);
    } catch (e) {
      pendingSyncIds.add(block.id);
      errorMessage = 'Error creating the note on the server';
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Error uploading the note to the server. It will sync later.'),
          ),
        );
      }
    }
  }

  Future<void> updateBlock(BlockEntity block) async {
    _localBox.put(block.id, block);
    final index = blocks.indexWhere((b) => b.id == block.id);
    if (index != -1) blocks[index] = block;
    notifyListeners();
    try {
      await blockUsecase.updateBlock(block);
      final index = blocks.indexWhere((b) => b.id == block.id);
      if (index != -1) {
        blocks[index] = block;
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Error updating block';
      notifyListeners();
    }
  }

  Future<void> deleteBlock(String blockId) async {
    _localBox.delete(blockId);
    blocks.removeWhere((b) => b.id == blockId);
    notifyListeners();
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
