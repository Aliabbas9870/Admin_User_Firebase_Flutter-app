import 'package:flutter/material.dart';

class LayoutBuild extends StatefulWidget {
  const LayoutBuild({super.key});

  @override
  State<LayoutBuild> createState() => _LayoutBuildState();
}

class _LayoutBuildState extends State<LayoutBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        final hight = constraint.maxHeight;
        final width = constraint.maxWidth;
         if (constraint.maxWidth < 500) {
          // mobile layout 
          return mobileLayout();
        } else {

          // pc layout 
          return Container();
        }
      }),
    );
  }

  Container mobileLayout() => Container();
}
