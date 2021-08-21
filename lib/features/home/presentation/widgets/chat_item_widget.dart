import 'package:flutter/material.dart';
import 'package:persian_tools/persian_tools.dart' as persianTools;

class ChatItemWidget extends StatelessWidget {
  
  const ChatItemWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String messageText = 'جعفر Hey whatsup 😁'; //'سلام چطوری؟ bitch سستت';
    //'Hey 😁 can i talk to you?😂 Hey can i talk to you Hey can i talk to you Hey can i talk to you can i talk to you can i talk to you ',
    //'سلام چطوری؟ bitch سستت',

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(12),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlue[300],
                    ),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(50),
                    //   child: Image.asset(
                    //     'assets/images/ic_avatar.png',
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
                    )),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(end: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                      const EdgeInsetsDirectional.only(top: 4),
                                  child: Text(
                                    'جعفر',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                    top: 4,
                                    end: 12,
                                  ),
                                  child: Directionality(
                                    textDirection:
                                        persianTools.hasPersian(messageText)
                                            ? persianTools
                                                    .hasPersian(messageText[0])
                                                ? TextDirection.rtl
                                                : TextDirection.ltr
                                            : TextDirection.ltr,
                                    child: Text(
                                      messageText,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(top: 4),
                                child: Text(
                                  '20:30',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                margin:
                                    const EdgeInsetsDirectional.only(top: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                child: Center(
                                  child: Text(
                                    '2',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
