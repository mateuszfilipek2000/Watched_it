import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.child,
    this.isFirst = false,
    this.sectionTitle,
    this.width = double.infinity,
    this.fullWidth = false,
    this.fullHeight = false,
  }) : super(key: key);

  final bool isFirst;
  final Widget child;
  final String? sectionTitle;
  final double? width;
  final bool fullWidth;
  final bool fullHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isFirst
          ? const EdgeInsets.symmetric(vertical: 10.0)
          : const EdgeInsets.only(bottom: 10.0),
      padding: fullWidth
          ? fullHeight
              ? null
              : const EdgeInsets.only(bottom: 8.0)
          : fullHeight
              ? const EdgeInsets.symmetric(horizontal: 8.0)
              : const EdgeInsets.all(8.0),
      color: Theme.of(context).colorScheme.surface,
      width: this.width,
      child: sectionTitle == null
          ? child
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    sectionTitle!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                child,
              ],
            ),
    );
  }
}
