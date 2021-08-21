import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class PrivateChatPage extends StatefulWidget {
  static const String routeName = '/privateChatPage';
  const PrivateChatPage({Key key}) : super(key: key);

  @override
  _PrivateChatPageState createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  AutoScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController();
    // scrollController.scrollToIndex(
    //   14,
    //   preferPosition: AutoScrollPosition.end,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Private Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: GroupedListView<dynamic, String>(
          elements: [
            {
              'group': 'jafar',
              'name': '1',
            },
            {
              'group': 'jafar',
              'name': '2',
            },
            {
              'group': 'jafar',
              'name': '3',
            },
            {
              'group': 'jafar',
              'name': '4',
            },
            {
              'group': 'jafar',
              'name': '5',
            },
            {
              'group': 'yasin',
              'name': '6',
            },
            {
              'group': 'yasin',
              'name': '7',
            },
            {
              'group': 'yasin',
              'name': '8',
            },
            {
              'group': 'yasin',
              'name': '9',
            },
            {
              'group': 'mamad',
              'name': '10',
            },
            {
              'group': 'mamad',
              'name': '11',
            },
            {
              'group': 'mamad',
              'name': '12',
            },
            {
              'group': 'mamad',
              'name': '13',
            },
            {
              'group': 'mamad',
              'name': '14',
            },
            {
              'group': 'mamad',
              'name': '15',
            },
            {
              'group': 'aaaa',
              'name': '16',
            },
            {
              'group': 'aaaa',
              'name': '17',
            },
            {
              'group': 'aaaa',
              'name': '18',
            },
            {
              'group': 'aaaa',
              'name': '19',
            },
            {
              'group': 'aaaa',
              'name': '20',
            },
            {
              'group': 'aaaa',
              'name': '21',
            },
            {
              'group': 'aaaa',
              'name': '22',
            },
            {
              'group': 'aaaa',
              'name': '23',
            },
            {
              'group': 'aaaa',
              'name': '24',
            },
            {
              'group': 'aaaa',
              'name': '25',
            },
            {
              'group': 'aaaa',
              'name': '26',
            },
          ],
          controller: scrollController,
          groupBy: (element) => element['group'],
          groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
          // itemBuilder: (context, dynamic element) => Text(
          //   element['name'],
          // ),
          indexedItemBuilder: (context, element, index) => _wrapScrollTag(
            index: index,
            child: Container(
              height: index % 2 == 0 ? 100 : 58,
              color: index % 2 == 0 ? Colors.white : Colors.deepOrange,
              child: Center(
                child: Text(
                  element['name'],
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          reverse: true,
          useStickyGroupSeparators: true, // optional
          floatingHeader: true, // optional
          order: GroupedListOrder.DESC, // optional
          sort: false,
        ),
      ),
    );
  }

  Widget _wrapScrollTag({@required int index, @required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );
}
