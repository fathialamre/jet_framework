import 'package:flutter/material.dart';

class PostsPageDetails extends StatelessWidget {
  const PostsPageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: const Center(
        child: Text('Posts Page'),
      ),
    );
  }
}
