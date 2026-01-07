import 'package:block_note/features/auth/data/model/block_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlockDatasource {
  final FirebaseFirestore firestore;

  BlockDatasource({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createBlock(BlockModel block) async {
    await firestore.collection('notes').doc(block.id).set({
      'createdAt': FieldValue.serverTimestamp(),
      ...block.toMap(),
    });
  }
  Stream<List<BlockModel>> streamBlocksByUser(String userId) {
    return firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BlockModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> updateBlock(BlockModel block) async {
    await firestore.collection('notes').doc(block.id).update({
      'title': block.title,
      'content': block.content,
      'iconData': block.iconData,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteBlock(String blockId) async {
    await firestore.collection('notes').doc(blockId).delete();
  }
}
