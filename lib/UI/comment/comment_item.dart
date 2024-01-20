import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/Model/Entity/comment.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(comment.title),
              Text(comment.date),
            ],
          ),
          Text(comment.email),
          const SizedBox(height: 20),
          Text(comment.content),
        ],
      ),
    );
  }
}
