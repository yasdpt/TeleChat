import 'package:flutter/material.dart';
import 'package:telechat/core/styles/colors.dart';

class ContactItem extends StatelessWidget {
  final String imageUrl;
  final String displayName;
  final String lastSeen;
  final VoidCallback onTap;
  const ContactItem({
    Key key,
    this.imageUrl,
    @required this.displayName,
    @required this.lastSeen,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                SizedBox(width: 14),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getRandomColor(),
                  ),
                  child: Center(
                    child: Text(
                      displayName[0].toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      displayName,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 15),
                    ),
                    Text(
                      lastSeen,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: cDarkGrey),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
