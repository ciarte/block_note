
import 'package:block_note/utils/colors_icon.dart';
import 'package:block_note/utils/formater.dart';
import 'package:flutter/material.dart';

class CardPreviewWidget extends StatelessWidget {
  const CardPreviewWidget({
    super.key,
    required this.title,
    required this.content,
    required this.iconData,
  });

  final String title;
  final String content;
  final int iconData;

  @override
  Widget build(BuildContext context) {
    final color = iconColor(IconData(iconData, fontFamily: 'MaterialIcons'));
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: color.withValues(alpha: 0.3),
        border: Border(left: BorderSide(color: color, width: 8)),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 80,
        child: Row(
          children: [
            Icon(IconData(iconData, fontFamily: 'MaterialIcons'), color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(content, maxLines: 3, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${dateFormat(DateTime.now())}',
                  style: const TextStyle(fontSize: 12),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.delete_forever_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
