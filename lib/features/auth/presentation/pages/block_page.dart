import 'package:block_note/features/auth/domain/entity/block_entity.dart';
import 'package:block_note/features/auth/presentation/auth_view_model.dart';
import 'package:block_note/features/auth/presentation/block_view_model.dart';
import 'package:block_note/features/auth/presentation/pages/login_page.dart';
import 'package:block_note/features/auth/presentation/pages/new_block_page.dart';
import 'package:block_note/utils/formater.dart';
import 'package:block_note/utils/inputs_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BlockPage extends StatelessWidget {
  static const String name = 'block_page';
  const BlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BlockViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final authVm = context.read<AuthViewModel>();
              await authVm.logout();
              if (!context.mounted) return;
              context.goNamed(LoginPage.name);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: context.read<BlockViewModel>(),
                child: NewBlockPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: vm.blocks.length,
        itemBuilder: (_, i) {
          final block = vm.blocks[i];
          bool pending = vm.isPending(block);
          final color = _iconColor(
              IconData(block.iconData!, fontFamily: 'MaterialIcons'));
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: color.withValues(alpha: 0.3),
                border: Border(
                  left: BorderSide(color: color, width: 8),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(IconData(block.iconData!, fontFamily: 'MaterialIcons'),
                        color: color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Text(
                                  (block.title).toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                if (pending)
                                  Icon(
                                    Icons
                                        .signal_wifi_statusbar_connected_no_internet_4,
                                    size: 10,
                                  ),
                              ],
                            ),
                            Text(block.content,
                                maxLines: 3, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        block.updatedAt != null
                            ? Text('Updated: ${dateFormat(block.updatedAt!)}',
                                style: const TextStyle(fontSize: 12),
                                softWrap: true)
                            : Text('Date: ${dateFormat(block.createdAt)}',
                                style: const TextStyle(fontSize: 12),
                                softWrap: true),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: Icon(
                                Icons.delete_forever_outlined,
                              ),
                              onPressed: () => vm.deleteBlock(block.id),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: Icon(
                                Icons.edit_outlined,
                              ),
                              onPressed: () => _showEditDialog(context, block),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _iconColor(IconData c) {
    switch (c) {
      case Icons.hail_rounded:
        return Colors.blue;
      case Icons.cabin:
        return Colors.green;
      case Icons.monetization_on:
        return Colors.yellow;
      case Icons.build_rounded:
        return Colors.purple;
      case Icons.cake:
        return Colors.pink;
      case Icons.sailing:
        return Colors.teal;
      case Icons.work_history_outlined:
        return Colors.orange;
      case Icons.phone_forwarded_outlined:
        return Colors.red;
      case Icons.favorite_border_outlined:
        return Colors.redAccent;
      case Icons.place_outlined:
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  void _showEditDialog(
    BuildContext context,
    BlockEntity block,
  ) {
    final titleController = TextEditingController(text: block.title);
    final contentController = TextEditingController(text: block.content);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              textInput('Title', 'Please enter a title', titleController,
                  maxLength: 20),
              const SizedBox(height: 12),
              textInput(
                  'Content', 'Please enter a description', contentController,
                  maxLength: 90),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Save'),
              onPressed: () {
                final vm = context.read<BlockViewModel>();

                vm.updateBlock(
                  block.copyWith(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                  ),
                );

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
