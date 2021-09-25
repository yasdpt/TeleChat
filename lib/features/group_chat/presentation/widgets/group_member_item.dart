import 'package:flutter/material.dart';
import 'package:persian_tools/persian_tools.dart' as persianTools;

class GroupMemberItem extends StatelessWidget {
  final VoidCallback onTap;

  const GroupMemberItem({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String messageText = 'Last seen recently';

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(12),
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[300],
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(50),
                //   child: Image.asset(
                //     'assets/images/ic_avatar.jpg',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Center(
                  child: Text(
                    'M',
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 4),
                      child: Text(
                        'جعفر',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                        top: 4,
                        end: 12,
                      ),
                      child: Directionality(
                        textDirection: persianTools.hasPersian(messageText)
                            ? persianTools.hasPersian(messageText[0])
                                ? TextDirection.rtl
                                : TextDirection.ltr
                            : TextDirection.ltr,
                        child: Text(
                          messageText,
                          style: Theme.of(context).textTheme.headline5,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
