import 'package:flutter/material.dart';

class CoreWidgets {}

class StackedLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget contentWidget;
  const StackedLoadingOverlay(
      {super.key, required this.isLoading, required this.contentWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        contentWidget,
        isLoading
            ? Positioned.fill(
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  child: const Center(
                    child: SizedBox(
                        height: 250, width: 250, child: Icon(Icons.pending)),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
