import 'package:flutter/material.dart';

class PostDetailContent extends StatelessWidget {
  final content;
  const PostDetailContent(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text("$content"),
    );
  }
}
