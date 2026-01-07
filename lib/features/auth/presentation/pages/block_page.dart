import 'package:block_note/features/auth/presentation/auth_view_model.dart';
import 'package:block_note/features/auth/presentation/block_view_model.dart';
import 'package:block_note/features/auth/presentation/pages/login_page.dart';
import 'package:block_note/features/auth/presentation/pages/new_block_page.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: vm.blocks.length,
          itemBuilder: (_, i) {
            final block = vm.blocks[i];
                final color = _iconColor( IconData(block.iconData!, fontFamily: 'MaterialIcons'));
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
                child: ListTile(
                  leading: Icon(
                      IconData(block.iconData!, fontFamily: 'MaterialIcons'),
                      color: color),
                  title: Text(block.title),
                  subtitle: Text(block.content),
                  trailing: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever_outlined,
                        ),
                        onPressed: () => vm.deleteBlock(block.id),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                        ),
                        onPressed: () => vm.updateBlock(block),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
}
