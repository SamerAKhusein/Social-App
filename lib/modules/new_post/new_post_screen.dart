import 'package:flutter/material.dart';
import 'package:social/shared/components/components.dart';

class NewPostScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:
      defaultAppBar(
        context: context,
        title: 'Create Post',
      ),
    );
  }
}