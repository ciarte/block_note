import 'package:block_note/features/auth/presentation/block_view_model.dart';
import 'package:block_note/utils/inputs_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBlockPage extends StatelessWidget {
  NewBlockPage({super.key});

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BlockViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('New Block')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textInput(
              maxLength: 20,
              'Title:',
              'Must have a title',
              titleController,
            ),
            textInput(
              maxLength: 90,
              'Content:',
              'Must have a content',
              contentController,
            ),
            Consumer<BlockViewModel>(builder: (_, vm, __) {
              return SizedBox(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  children: [
                    _iconToSelect(Icons.hail_rounded, vm),
                    _iconToSelect(Icons.cabin, vm),
                    _iconToSelect(Icons.monetization_on, vm),
                    _iconToSelect(Icons.build_rounded, vm),
                    _iconToSelect(Icons.cake, vm),
                    _iconToSelect(Icons.sailing, vm),
                    _iconToSelect(Icons.work_history_outlined, vm),
                    _iconToSelect(Icons.phone_forwarded_outlined, vm),
                    _iconToSelect(Icons.favorite_border_outlined, vm),
                    _iconToSelect(Icons.place_outlined, vm),
                  ],
                ),
              );
            }),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  await vm.createBlock(
                      context, titleController.text, contentController.text);
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: Text('create note')),
          ],
        ),
      ),
    );
  }

  GestureDetector _iconToSelect(IconData iconData, BlockViewModel vm) {
    final isSelected = vm.iconData == iconData;
    return GestureDetector(
      onTap: () => vm.selectIcon(iconData),
      child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
            borderRadius: BorderRadius.circular(isSelected ? 12 : 8),
          ),
          child: Icon(iconData,
              color: isSelected ? Colors.blue : Colors.grey, size: 60)),
    );
  }
}
