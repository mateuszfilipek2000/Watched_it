import 'package:flutter/material.dart';

class SearchableTextButtonList extends StatelessWidget {
  const SearchableTextButtonList(
      {Key? key, required this.names, this.height = 40.0})
      : super(key: key);

  final List<String> names;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: names.length,
        itemBuilder: (context, index) {
          //TODO ADD SAERCH BASED ON GENRE ON BUTTON CLICK ??? ADD SEARCH QUERY AS AN ARGUMENT TO SEARCH PAGE ???
          return SearchTextButton(
            height: height,
            text: names[index],
            onPressed: () {},
          );
        },
      ),
    );
  }
}

class SearchTextButton extends StatelessWidget {
  const SearchTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.height,
  }) : super(key: key);

  final String text;
  final Function onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5.0),
      height: height,
      child: OutlinedButton(
        onPressed: () => onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
