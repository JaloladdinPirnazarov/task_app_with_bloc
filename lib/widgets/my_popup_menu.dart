import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';

class MyPopupMenu extends StatelessWidget {
  final VoidCallback cancelOrderDelete;
  final VoidCallback likeOrDislike;
  final Task task;
  const MyPopupMenu({
    required this.task,
    required this.cancelOrderDelete,
    required this.likeOrDislike,
    super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: !task.isDeleted! ? ((context) => [
        PopupMenuItem(
          child: TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.edit),
              label: const Text("Edit")),
          onTap: (){},
        ),
        PopupMenuItem(
          onTap: likeOrDislike,
          child: TextButton.icon(
              onPressed: null,
              icon: !task.isFavourite!
                  ? const Icon(Icons.bookmark_add_outlined)
                  : const Icon(Icons.bookmark_remove),
              label: !task.isFavourite!
              ? const Text("Add to Bookmarks")
              : const Text("Remove from Bookmarks"),),
        ),
        PopupMenuItem(
          onTap: cancelOrderDelete,
          child: TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.delete),
            label: const Text("Delete"),
          ),
        ),
      ]): (context)=>[
        PopupMenuItem(
          onTap: (){},
          child: TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.restore_from_trash),
            label: const Text("Restore"),
          ),
        ),
        PopupMenuItem(
          onTap: cancelOrderDelete,
          child: TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.delete_forever),
            label: const Text("Delete Forever"),
          ),
        ),
      ]
    );
  }
}
