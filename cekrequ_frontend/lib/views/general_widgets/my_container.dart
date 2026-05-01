// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  Alignment? alignment;
  Alignment? transformAlignment;
  Matrix4? transform;

  Widget? child;
  Clip clipBehavior;
  Color? color;
  
  BoxConstraints? boxConstraints;
  Decoration? foregroundDecoration;
  
  EdgeInsets? margin;
  EdgeInsets padding;

  double? height;
  double? width;
  bool isAntiAlias;


  MyContainer({
    super.key,
    this.alignment,
    this.boxConstraints,
    this.child,
    this.clipBehavior = Clip.none,
    this.color,
    this.foregroundDecoration,
    this.height,
    this.isAntiAlias = false,
    this.margin,
    this.padding = const EdgeInsets.all(15),
    this.transform,
    this.transformAlignment,
    this.width});

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      alignment: widget.alignment,
      clipBehavior: widget.clipBehavior,
      constraints: widget.boxConstraints,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
      foregroundDecoration: widget.foregroundDecoration,
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      isAntiAlias: widget.isAntiAlias,
      padding: widget.padding,
      transform: widget.transform,
      transformAlignment: widget.transformAlignment,
      child: widget.child
    );
  }
}