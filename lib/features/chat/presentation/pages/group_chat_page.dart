import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:telechat/core/widgets/better_stream_builder.dart';

class GroupChatPage extends StatefulWidget {
  static const String routeName = '/groupChatPage';
  GroupChatPage({Key key}) : super(key: key);

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  AutoScrollController scrollController;
  ItemScrollController _itemScrollController;
  Stream<Iterable<ItemPosition>> _itemPositionStream;
  ItemPositionsListener _itemPositionListener;
  List<String> messages;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController();
    _itemScrollController = ItemScrollController();
    _itemPositionListener = ItemPositionsListener.create();
    _itemPositionStream =
        _valueListenableToStreamAdapter(_itemPositionListener.itemPositions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Chat',
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

  Stream<T> _valueListenableToStreamAdapter<T>(ValueListenable<T> listenable) {
    // ignore: close_sinks
    StreamController<T> _controller;

    void listener() {
      _controller.add(listenable.value);
    }

    void start() {
      listenable.addListener(listener);
    }

    void end() {
      listenable.removeListener(listener);
    }

    _controller = StreamController<T>(
      onListen: start,
      onPause: end,
      onResume: start,
      onCancel: end,
    );

    return _controller.stream;
  }

  Widget _wrapScrollTag({@required int index, @required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: Colors.amber.withOpacity(0.5),
      );

  Positioned _buildFloatingDateDivider(int itemCount) => Positioned(
        top: 20,
        left: 0,
        right: 0,
        child: BetterStreamBuilder<Iterable<ItemPosition>>(
          initialData: _itemPositionListener.itemPositions.value,
          stream: _itemPositionStream,
          comparator: (a, b) {
            if (a == null || b == null) {
              return false;
            }
            if (true) {
              // reverse == true;
              final aTop = _getTopElementIndex(a);
              final bTop = _getTopElementIndex(b);
              return aTop == bTop;
            } else {
              final aBottom = _getBottomElementIndex(a);
              final bBottom = _getBottomElementIndex(b);
              return aBottom == bBottom;
            }
          },
          builder: (context, values) {
            if (values.isEmpty || messages.isEmpty) {
              return const Offstage();
            }

            int index;
            if (true) {
              // reverse == true;
              index = _getTopElementIndex(values);
            } else {
              index = _getBottomElementIndex(values);
            }

            if (index == null) return const Offstage();

            if (index <= 2 || index >= itemCount - 3) {
              if (true) {
                // revers
                index = itemCount - 4;
              } else {
                index = 2;
              }
            }

            final message = messages[index - 2];
            // return widget.dateDividerBuilder != null
            //     ? widget.dateDividerBuilder(message.createdAt.toLocal())
            //     : DateDivider(dateTime: message.createdAt.toLocal());
            return Text('message.createdAt.toLocal()');
          },
        ),
      );

  int _getTopElementIndex(Iterable<ItemPosition> values) {
    final inView = values.where((position) => position.itemLeadingEdge < 1);
    if (inView.isEmpty) return null;
    return inView
        .reduce((max, position) =>
            position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
        .index;
  }

  int _getBottomElementIndex(Iterable<ItemPosition> values) {
    final inView = values.where((position) => position.itemLeadingEdge < 1);
    if (inView.isEmpty) return null;
    return inView
        .reduce((min, position) =>
            position.itemLeadingEdge < min.itemLeadingEdge ? position : min)
        .index;
  }
}
