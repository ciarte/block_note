import 'package:block_note/features/auth/presentation/block_view_model.dart';
import 'package:block_note/utils/colors_icon.dart';
import 'package:block_note/utils/inputs_widgets.dart';
import 'package:block_note/widgets/card_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBlockPage extends StatelessWidget {
  NewBlockPage({super.key});

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Block')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textInput(
                maxLength: 20,
                'Title:',
                'Must have a title',
                titleController,
              ),
              const SizedBox(height: 12),
              textInput(
                maxLength: 90,
                'Content:',
                'Must have a content',
                contentController,
              ),
              const SizedBox(height: 20),
              Text('Select Icon:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Consumer<BlockViewModel>(
                builder: (_, vm, __) {
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
                },
              ),
              const SizedBox(height: 20),
              Text('Preview:', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Consumer<BlockViewModel>(
                builder: (_, vm, __) {
                  return CardPreviewWidget(
                      title: titleController.text,
                      content: contentController.text,
                      iconData: vm.iconData?.codePoint ?? Icons.note.codePoint);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final vm = context.read<BlockViewModel>();
                  await vm.createBlock(
                    context,
                    titleController.text,
                    contentController.text,
                  );
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: const Text('Create Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _iconToSelect(IconData iconData, BlockViewModel vm) {
    final isSelected = vm.iconData == iconData;
    final color =
        iconColor(IconData(iconData.codePoint, fontFamily: 'MaterialIcons'));
    return GestureDetector(
      onTap: () => vm.selectIcon(iconData),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? color : Colors.grey),
          borderRadius: BorderRadius.circular(isSelected ? 12 : 8),
        ),
        child: Icon(
          iconData,
          color: isSelected ? color : Colors.grey,
          size: 60,
        ),
      ),
    );
  }
}
