import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:telechat/core/widgets/better_stream_builder.dart';
import 'package:telechat/features/private_chat/presentation/widgets/date_divider.dart';

import '../../../../core/consts/app_enums.dart';
import 'private_chat_item.dart';

class PrivateChatList extends StatefulWidget {
  final List<Map<String, dynamic>> chatList;
  final bool reverse;
  const PrivateChatList({
    Key key,
    @required this.chatList,
    this.reverse,
  }) : super(key: key);

  @override
  _PrivateChatListState createState() => _PrivateChatListState();
}

class _PrivateChatListState extends State<PrivateChatList> {
  ItemScrollController _scrollController;
  ItemPositionsListener _itemPositionListener;
  Stream<Iterable<ItemPosition>> _itemPositionStream;
  int initialIndex = 0;
  int _messageListLength;
  double initialAlignment = 0;

  @override
  void initState() {
    _scrollController = ItemScrollController();
    _itemPositionListener = ItemPositionsListener.create();
    _itemPositionStream =
        _valueListenableToStreamAdapter(_itemPositionListener.itemPositions);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newMessagesListLength = widget.chatList.length;
    // if (_messageListLength != null) {
    //   if (_bottomPaginationActive) {
    //     if (_itemPositionListener.itemPositions.value.isNotEmpty == true) {
    //       final first = _itemPositionListener.itemPositions.value.first;
    //       final diff = newMessagesListLength - _messageListLength;
    //       if (diff > 0) {
    //         initialIndex = first.index + diff;
    //         initialAlignment = first.itemLeadingEdge;
    //       }
    //     }
    //   } else if (!_topPaginationActive) {
    //     // Reset the index in-case we send any new message
    //     initialIndex = 0;
    //     initialAlignment = 0;
    //   }
    // }

    _messageListLength = newMessagesListLength;

    return Stack(
      alignment: Alignment.center,
      children: [
        ScrollablePositionedList.builder(
          key: ValueKey(initialIndex + initialAlignment),
          itemPositionsListener: _itemPositionListener,
          initialScrollIndex: initialIndex ?? 0,
          itemScrollController: _scrollController,
          initialAlignment: initialAlignment ?? 0,
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          itemCount: widget.chatList.length,
          reverse: true,
          itemBuilder: (context, index) {
            final chat = widget.chatList[index];
            if (chat['sender_id'] == 1) {
              return PrivateChatItem(
                messageSender: MessageSender.me,
                message: widget.chatList[index],
              );
            } else {
              return PrivateChatItem(
                messageSender: MessageSender.other,
                message: widget.chatList[index],
              );
            }
          },
        ),
        _buildFloatingDateDivider(widget.chatList.length),
      ],
    );
  }

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
            if (widget.reverse) {
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
            if (values.isEmpty || widget.chatList.isEmpty) {
              return const Offstage();
            }

            int index;
            if (widget.reverse) {
              index = _getTopElementIndex(values);
            } else {
              index = _getBottomElementIndex(values);
            }

            if (index == null) return const Offstage();

            if (index <= 2 || index >= itemCount - 3) {
              if (widget.reverse) {
                index = itemCount - 4;
              } else {
                index = 2;
              }
            }

            final message = widget.chatList[index - 2];
            return Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 8, end: 8, top: 6, bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  DateTime.parse(message['created_at']).toLocal().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.white),
                ),
              ),
            );
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
