import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.child,
    this.isFirst = false,
    this.sectionTitle,
  }) : super(key: key);

  final bool isFirst;
  final Widget child;
  final String? sectionTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isFirst
          ? const EdgeInsets.symmetric(vertical: 15.0)
          : const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.all(8.0),
      //todo change colour
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    sectionTitle as String,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
          child,
        ],
      ),
    );
  }
}
