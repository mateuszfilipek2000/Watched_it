import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.child,
    this.isFirst = false,
    this.sectionTitle,
    this.width = double.infinity,
  }) : super(key: key);

  final bool isFirst;
  final Widget child;
  final String? sectionTitle;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isFirst
          ? const EdgeInsets.symmetric(vertical: 10.0)
          : const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(8.0),
      color: Theme.of(context).colorScheme.surface,
      width: this.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle == null
              ? Container()
              : Padding(
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
