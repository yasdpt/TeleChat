import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/widgets/better_stream_builder.dart';
import '../../../../core/widgets/message_list_core.dart';
import '../../data/models/private_message.dart';
import 'date_divider.dart';
import 'private_chat_item.dart';
import 'swipeable.dart';
import 'system_message.dart';

/// Widget builder for message
/// [defaultMessageWidget] is the default [MessageWidget] configuration
/// Use [defaultMessageWidget.copyWith] to easily customize it
typedef MessageBuilder = Widget Function(
  BuildContext,
  MessageDetails,
  List<PrivateMessage>,
  PrivateChatItem defaultMessageWidget,
);

/// Widget builder for parent message
/// [defaultMessageWidget] is the default [MessageWidget] configuration
/// Use [defaultMessageWidget.copyWith] to easily customize it
typedef ParentMessageBuilder = Widget Function(
  BuildContext,
  PrivateMessage,
  PrivateChatItem defaultMessageWidget,
);

/// Widget builder for system message
typedef SystemMessageBuilder = Widget Function(
  BuildContext,
  PrivateMessage,
);

/// Widget builder for thread
typedef ThreadBuilder = Widget Function(
    BuildContext context, PrivateMessage parent);

/// Callback for thread taps
typedef ThreadTapCallback = void Function(PrivateMessage, Widget);

/// Callback on message swiped
typedef OnMessageSwiped = void Function(PrivateMessage);

/// Callback on message tapped
typedef OnMessageTap = void Function(PrivateMessage);

typedef ErrorBuilder = Widget Function(BuildContext context, Object error);

/// Callback on reply tapped
typedef ReplyTapCallback = void Function(PrivateMessage);

/// Class for message details
class MessageDetails {
  /// Constructor for creating [MessageDetails]
  MessageDetails(
    int currentUserId,
    this.message,
    List<PrivateMessage> messages,
    this.index,
  ) {
    isMyMessage = message.user?.userId == currentUserId;
    isLastUser = index + 1 < messages.length &&
        message.user?.userId == messages[index + 1].user?.userId;
    isNextUser = index - 1 >= 0 &&
        message.user.userId == messages[index - 1].user?.userId;
  }

  /// True if the message belongs to the current user
  bool isMyMessage;

  /// True if the user message is the same of the previous message
  bool isLastUser;

  /// True if the user message is the same of the next message
  bool isNextUser;

  /// The message
  final PrivateMessage message;

  /// The index of the message
  final int index;
}

class PrivateChatListView extends StatefulWidget {
  /// Function used to build a custom message widget
  final MessageBuilder messageBuilder;

  /// Whether the view scrolls in the reading direction.
  ///
  /// Defaults to true.
  ///
  /// See [ScrollView.reverse].
  final bool reverse;

  /// Limit used during pagination
  final int paginationLimit;

  /// Function used to build a custom system message widget
  final SystemMessageBuilder systemMessageBuilder;

  /// Function used to build a custom parent message widget
  final ParentMessageBuilder parentMessageBuilder;

  /// Function used to build a custom thread widget
  final ThreadBuilder threadBuilder;

  /// Function called when tapping on a thread
  /// By default it calls [Navigator.push] using the widget
  /// built using [threadBuilder]
  final ThreadTapCallback onThreadTap;

  /// If true will show a scroll to bottom message when there are new
  /// messages and the scroll offset is not zero
  final bool showScrollToBottom;

  /// Parent message in case of a thread
  final PrivateMessage parentMessage;

  /// Builder used to render date dividers
  final Widget Function(DateTime) dateDividerBuilder;

  /// Index of an item to initially align within the viewport.
  final int initialScrollIndex;

  /// Determines where the leading edge of the item at [initialScrollIndex]
  /// should be placed.
  final double initialAlignment;

  /// Controller for jumping or scrolling to an item.
  final ItemScrollController scrollController;

  /// Provides a listenable iterable of [itemPositions] of items that are on
  /// screen and their locations.
  final ItemPositionsListener itemPositionListener;

  /// The ScrollPhysics used by the ListView
  final ScrollPhysics scrollPhysics;

  /// Called when message item gets swiped
  final OnMessageSwiped onMessageSwiped;

  /// If true the list will highlight the initialMessage if there is any.
  ///
  /// Also See [StreamChannel]
  final bool highlightInitialMessage;

  /// Color used while highlighting initial message
  final Color messageHighlightColor;

  /// Flag for showing tile on header
  final bool showConnectionStateTile;

  /// Flag for showing the floating date divider
  final bool showFloatingDateDivider;

  /// Function called when messages are fetched
  final Widget Function(BuildContext, List<PrivateMessage>) messageListBuilder;

  /// Function used to build a header widget
  final WidgetBuilder headerBuilder;

  /// Function used to build a footer widget
  final WidgetBuilder footerBuilder;

  /// Function used to build a loading widget
  final WidgetBuilder loadingBuilder;

  /// Function used to build an empty widget
  final WidgetBuilder emptyBuilder;

  /// Callback triggered when an error occurs while performing the
  /// given request.
  /// This parameter can be used to display an error message to
  /// users in the event
  /// of a connection failure.
  final ErrorBuilder errorBuilder;

  /// Predicate used to filter messages
  final bool Function(PrivateMessage) messageFilter;

  /// Called when any message is tapped except a system message
  /// (use [onSystemMessageTap] instead)
  final OnMessageTap onMessageTap;

  /// Called when system message is tapped
  final OnMessageTap onSystemMessageTap;

  /// A List of user types that have permission to pin messages
  final List<String> pinPermissions;

  /// Builder used to build the thread separator in case it's a thread view
  final WidgetBuilder threadSeparatorBuilder;

  /// A [MessageListController] allows pagination.
  /// Use [ChannelListController.paginateData] pagination.
  // final MessageListController messageListController;

  PrivateChatListView({
    Key key,
    this.showScrollToBottom = true,
    this.messageBuilder,
    this.parentMessageBuilder,
    this.parentMessage,
    this.threadBuilder,
    this.onThreadTap,
    this.dateDividerBuilder,
    this.scrollPhysics = const ClampingScrollPhysics(),
    this.initialScrollIndex,
    this.initialAlignment,
    this.scrollController,
    this.itemPositionListener,
    this.onMessageSwiped,
    this.highlightInitialMessage = false,
    this.messageHighlightColor,
    this.showConnectionStateTile = false,
    this.headerBuilder,
    this.footerBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.systemMessageBuilder,
    this.messageListBuilder,
    this.errorBuilder,
    this.messageFilter,
    this.onMessageTap,
    this.onSystemMessageTap,
    this.pinPermissions = const [],
    this.showFloatingDateDivider = true,
    this.threadSeparatorBuilder,
    //this.messageListController,
    this.reverse = true,
    this.paginationLimit = 20,
  }) : super(key: key);

  @override
  _PrivateChatListViewState createState() => _PrivateChatListViewState();
}

class _PrivateChatListViewState extends State<PrivateChatListView> {
  ItemScrollController _scrollController;
  void Function(PrivateMessage) _onThreadTap;
  bool _showScrollToBottom = false;
  ItemPositionsListener _itemPositionListener;
  Stream<Iterable<ItemPosition>> _itemPositionStream;
  int _messageListLength;
  // StreamChannelState streamChannel;
  // StreamChatThemeData _streamTheme;

  int get _initialIndex {
    if (widget.initialScrollIndex != null) return widget.initialScrollIndex;
    // if (streamChannel.initialMessageId != null) {
    //   final messages = streamChannel.channel.state.messages;
    //   final totalMessages = messages.length;
    //   final messageIndex =
    //       messages.indexWhere((e) => e.id == streamChannel.initialMessageId);
    //   final index = totalMessages - messageIndex;
    //   if (index != 0) return index - 1;
    //   return index;
    // }
    return 0;
  }

  double get _initialAlignment {
    if (widget.initialAlignment != null) return widget.initialAlignment;
    return 0;
  }

  bool _isInitialMessage(int id) => 1 == id; // INITIAL MESSAGE ID

  bool get _upToDate => false; // TODO: streamChannel.channel.state.isUpToDate;

  bool get _isThreadConversation => widget.parentMessage != null;

  bool _topPaginationActive = false;
  bool _bottomPaginationActive = false;

  int initialIndex;
  double initialAlignment;

  List<PrivateMessage> messages = <PrivateMessage>[];

  bool initialMessageHighlightComplete = false;

  bool _inBetweenList = false;

  // final _defaultController = MessageListController();

  // MessageListController get _messageListController =>
  //     widget.messageListController ?? _defaultController;

  @override
  Widget build(BuildContext context) {
    // MessageListCore(
    //   paginationLimit: widget.paginationLimit,
    //   messageFilter: widget.messageFilter,
    //   loadingBuilder: widget.loadingBuilder ??
    //       (context) => const Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //   emptyBuilder: widget.emptyBuilder ??
    //       (context) => Center(
    //             child: Text(
    //               "context.translations.emptyChatMessagesText",
    //               style: Theme.of(context).textTheme.headline3,
    //             ),
    //           ),
    //   messageListBuilder:
    //       widget.messageListBuilder ?? (context, list) => _buildListView(list),
    //   messageListController: _messageListController,
    //   parentMessage: widget.parentMessage,
    //   errorBuilder: widget.errorBuilder ??
    //       (BuildContext context, Object error) => Center(
    //             child: Text(
    //               "context.translations.genericErrorText",
    //               style: Theme.of(context).textTheme.headline3,
    //             ),
    //           ),
    // );

    return widget.messageListBuilder ?? _buildListView(messages);
  }

  Widget _buildListView(List<PrivateMessage> data) {
    messages = data;
    final newMessagesListLength = messages.length;

    if (_messageListLength != null) {
      if (_bottomPaginationActive || (_inBetweenList && _upToDate)) {
        if (_itemPositionListener.itemPositions.value.isNotEmpty == true) {
          final first = _itemPositionListener.itemPositions.value.first;
          final diff = newMessagesListLength - _messageListLength;
          if (diff > 0) {
            initialIndex = first.index + diff;
            initialAlignment = first.itemLeadingEdge;
          }
        }
      } else if (!_topPaginationActive && _upToDate) {
        // Reset the index in-case we send any new message
        initialIndex = 0;
        initialAlignment = 0;
      }
    }

    _messageListLength = newMessagesListLength;

    final itemCount = messages.length //+ // total messages
        // 2 + // top + bottom loading indicator
        // 2 + // header + footer
        // 1 // parent message
        ;

    final child = Stack(
      alignment: Alignment.center,
      children: [
        ScrollablePositionedList.separated(
          key: ValueKey(initialIndex + initialAlignment),
          itemPositionsListener: _itemPositionListener,
          initialScrollIndex: initialIndex ?? 0,
          initialAlignment: initialAlignment ?? 0,
          physics: widget.scrollPhysics,
          itemScrollController: _scrollController,
          reverse: widget.reverse,
          addAutomaticKeepAlives: false,
          itemCount: itemCount,

          // Item Count -> 8 (1 parent, 2 header+footer, 2 top+bottom, 3 messages)
          // eg:     |Type|         rev(|Index(item)|)     rev(|Index(separator)|)    |Index(item)|    |Index(separator)|
          //     ParentMessage  ->        7                                             (count-1)
          //        Separator(ThreadSeparator)          ->           6                                      (count-2)
          //     Header         ->        6                                             (count-2)
          //        Separator(Header -> 8??T -> 0||52)  ->           5                                      (count-3)
          //     TopLoader      ->        5                                             (count-3)
          //        Separator(0)                        ->           4                                      (count-4)
          //     Message        ->        4                                             (count-4)
          //        Separator(2||8)                     ->           3                                      (count-5)
          //     Message        ->        3                                             (count-5)
          //        Separator(2||8)                     ->           2                                      (count-6)
          //     Message        ->        2                                             (count-6)
          //        Separator(0)                        ->           1                                      (count-7)
          //     BottomLoader   ->        1                                             (count-7)
          //        Separator(Footer -> 8??30)          ->           0                                      (count-8)
          //     Footer         ->        0                                             (count-8)

          separatorBuilder: (context, i) {
            if (i == itemCount - 2) {
              if (widget.parentMessage == null) {
                return const Offstage();
              }
              return _buildThreadSeparator();
            }
            if (i == itemCount - 3) {
              if (widget.headerBuilder == null) {
                if (_isThreadConversation) return const Offstage();
                return const SizedBox(height: 52);
              }
              return const SizedBox(height: 8);
            }
            if (i == 0) {
              if (widget.footerBuilder == null) {
                return const SizedBox(height: 30);
              }
              return const SizedBox(height: 8);
            }

            if (i == 1 || i == itemCount - 4) return const Offstage();

            PrivateMessage message, nextMessage;
            if (widget.reverse) {
              message = messages[i - 1];
              nextMessage = messages[i - 2];
            } else {
              message = messages[i - 2];
              nextMessage = messages[i - 1];
            }
            if (!Jiffy(message.createdAt.toLocal()).isSame(
              nextMessage.createdAt.toLocal(),
              Units.DAY,
            )) {
              final divider = widget.dateDividerBuilder != null
                  ? widget.dateDividerBuilder(
                      nextMessage.createdAt.toLocal(),
                    )
                  : DateDivider(
                      dateTime: nextMessage.createdAt.toLocal(),
                    );
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: divider,
              );
            }
            final timeDiff = Jiffy(nextMessage.createdAt.toLocal()).diff(
              message.createdAt.toLocal(),
              Units.MINUTE,
            );

            final isNextUserSame =
                message.user.userId == nextMessage.user.userId;
            //final isThread = message.replyCount > 0;
            final isDeleted = message.deleteCode == 3;
            if (timeDiff >= 1 || !isNextUserSame || isDeleted) {
              return const SizedBox(height: 8);
            }
            return const SizedBox(height: 2);
          },
          itemBuilder: (context, i) {
            // if (i == itemCount - 1) {
            //   if (widget.parentMessage == null) {
            //     return const Offstage();
            //   }
            //   return buildParentMessage(widget.parentMessage);
            // }

            // if (i == itemCount - 2) {
            //   return widget.headerBuilder?.call(context) ?? const Offstage();
            // }

            // if (i == itemCount - 3) {
            //   return _buildLoadingIndicator();
            // }

            // if (i == 1) {
            //   return _buildLoadingIndicator();
            // }

            // if (i == 0) {
            //   return widget.footerBuilder?.call(context) ?? const Offstage();
            // }

            //const bottomMessageIndex = 2; // 1 -> loader // 0 -> footer

            final message = messages[i];
            Widget messageWidget;

            // if (i == bottomMessageIndex) {
            //   messageWidget = _buildBottomMessage(
            //     context,
            //     message,
            //     messages,
            //     streamChannel,
            //     i - 2,
            //   );
            // } else {
            //   messageWidget = buildMessage(message, messages, i - 2);
            // }

            messageWidget = buildMessage(message, messages, i);
            return messageWidget;
          },
        ),
        if (widget.showScrollToBottom) _buildScrollToBottom(),
        if (widget.showFloatingDateDivider)
          _buildFloatingDateDivider(itemCount),
      ],
    );

    final backgroundColor = Theme.of(context).backgroundColor;

    if (backgroundColor != null) {
      return ColoredBox(
        color: backgroundColor,
        child: child,
      );
    }

    return child;
  }

  Widget _buildThreadSeparator() {
    if (widget.threadSeparatorBuilder != null) {
      return widget.threadSeparatorBuilder.call(context);
    }

    //final replyCount = widget.parentMessage.replyCount!;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green, Colors.amber]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          "context.translations.threadSeparatorText(replyCount)",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
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
            if (values.isEmpty || messages.isEmpty) {
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

            final message = messages[index - 2];
            return widget.dateDividerBuilder != null
                ? widget.dateDividerBuilder(message.createdAt.toLocal())
                : DateDivider(dateTime: message.createdAt.toLocal());
          },
        ),
      );

  // Future<void> _paginateData(
  //   StreamChannelState channel,
  //   QueryDirection direction,
  // ) =>
  //     _messageListController.paginateData!(direction: direction);

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

  // Widget _buildScrollToBottom() => StreamBuilder<Tuple2<bool, int>>(
  //       stream: Rx.combineLatest2(
  //         streamChannel.channel.state.isUpToDateStream.distinct(),
  //         streamChannel.channel.state.unreadCountStream.distinct(),
  //         (bool isUpToDate, int unreadCount) => Tuple2(isUpToDate, unreadCount),
  //       ),
  //       builder: (_, snapshot) {
  //         if (snapshot.hasError) {
  //           return const Offstage();
  //         } else if (!snapshot.hasData) {
  //           return const Offstage();
  //         }
  //         final isUpToDate = snapshot.data.item1;
  //         final showScrollToBottom = !isUpToDate || _showScrollToBottom;
  //         if (!showScrollToBottom) {
  //           return const Offstage();
  //         }
  //         final unreadCount = snapshot.data!.item2;
  //         final showUnreadCount = unreadCount > 0 &&
  //             streamChannel!.channel.state!.members.any((e) =>
  //                 e.userId ==
  //                 streamChannel!.channel.client.state.currentUser!.id);
  //         return Positioned(
  //           bottom: 8,
  //           right: 8,
  //           width: 40,
  //           height: 40,
  //           child: Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //               FloatingActionButton(
  //                 backgroundColor: _streamTheme.colorTheme.barsBg,
  //                 onPressed: () {
  //                   if (unreadCount > 0) {
  //                     streamChannel.channel.markRead();
  //                   }
  //                   if (!_upToDate) {
  //                     _bottomPaginationActive = false;
  //                     _topPaginationActive = false;
  //                     streamChannel.reloadChannel();
  //                   } else {
  //                     setState(() => _showScrollToBottom = false);
  //                     _scrollController.scrollTo(
  //                       index: 0,
  //                       duration: const Duration(seconds: 1),
  //                       curve: Curves.easeInOut,
  //                     );
  //                   }
  //                 },
  //                 child: Icon(MdiIcons.chevronDown, color: Colors.white)
  //               ),
  //               if (showUnreadCount)
  //                 Positioned(
  //                   width: 20,
  //                   height: 20,
  //                   left: 10,
  //                   top: -10,
  //                   child: CircleAvatar(
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(3),
  //                       child: Text(
  //                         '$unreadCount',
  //                         style: const TextStyle(
  //                           fontSize: 11,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         );
  //       },
  //     );

  Widget _buildScrollToBottom() {
    // final isUpToDate = snapshot.data.item1;
    // final showScrollToBottom = !isUpToDate || _showScrollToBottom;
    // if (!showScrollToBottom) {
    //   return const Offstage();
    // }
    // final unreadCount = snapshot.data.item2;
    // final showUnreadCount = unreadCount > 0 &&
    //     streamChannel.channel.state.members.any((e) =>
    //         e.userId ==
    //         streamChannel!.channel.client.state.currentUser.id);
    return Positioned(
      bottom: 8,
      right: 8,
      width: 40,
      height: 40,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                // if (unreadCount > 0) {
                //   streamChannel.channel.markRead();
                // }
                if (!_upToDate) {
                  _bottomPaginationActive = false;
                  _topPaginationActive = false;
                  //streamChannel.reloadChannel();
                } else {
                  setState(() => _showScrollToBottom = false);
                  _scrollController.scrollTo(
                    index: 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Icon(MdiIcons.chevronDown, color: Colors.white)),
          if (true)
            Positioned(
              width: 20,
              height: 20,
              left: 10,
              top: -10,
              child: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    'unreadCount',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() => _LoadingIndicator(
        isThreadConversation: _isThreadConversation,
      );

  // Widget _buildBottomMessage(
  //   BuildContext context,
  //   PrivateMessage message,
  //   List<PrivateMessage> messages,
  //   StreamChannelState streamChannel,
  //   int index,
  // ) {
  //   final messageWidget = buildMessage(message, messages, index);

  //   return VisibilityDetector(
  //     key: ValueKey<String>('BOTTOM-MESSAGE-${message.id}'),
  //     onVisibilityChanged: (visibility) {
  //       final isVisible = visibility.visibleBounds != Rect.zero;
  //       if (isVisible) {
  //         final channel = streamChannel.channel;
  //         if (_upToDate &&
  //             channel.config?.readEvents == true &&
  //             channel.state!.unreadCount > 0) {
  //           streamChannel.channel.markRead();
  //         }
  //       }
  //       if (mounted) {
  //         if (_showScrollToBottom == isVisible) {
  //           setState(() => _showScrollToBottom = !isVisible);
  //         }
  //       }
  //     },
  //     child: messageWidget,
  //   );
  // }

  Widget buildParentMessage(
    PrivateMessage message,
  ) {
    final isMyMessage = message.user.userId == 2; // TODO: SET USER ID
    //final isOnlyEmoji = message.msg.isOnlyEmoji;
    final currentUser = 2; // TODO: SET USER ID
    final members =
        []; //StreamChannel.of(context).channel.state?.members ?? [];
    final currentUserMember =
        members.firstWhere((e) => e.user.id == currentUser);

    final defaultMessageWidget = PrivateChatItem();

    if (widget.parentMessageBuilder != null) {
      return widget.parentMessageBuilder.call(
        context,
        widget.parentMessage,
        defaultMessageWidget,
      );
    }

    return defaultMessageWidget;
  }

  Widget buildMessage(
    PrivateMessage message,
    List<PrivateMessage> messages,
    int index,
  ) {
    if ((message.meta == 'system' || message.meta == 'error') &&
        message.msg.isNotEmpty == true) {
      return widget.systemMessageBuilder?.call(context, message) ??
          SystemMessage(
            key: ValueKey<String>('MESSAGE-${message.privateMessageId}'),
            // message: message,
            // onMessageTap: (message) {
            //   if (widget.onSystemMessageTap != null) {
            //     widget.onSystemMessageTap!(message);
            //   }
            //   FocusScope.of(context).unfocus();
            // },
          );
    }

    final userId = 2; // TODO: SET USER ID
    final isMyMessage = message.user.userId == userId;
    final nextMessage = index - 1 >= 0 ? messages[index - 1] : null;
    final isNextUserSame =
        nextMessage != null && message.user.userId == nextMessage.user.userId;

    num timeDiff = 0;
    if (nextMessage != null) {
      timeDiff = Jiffy(nextMessage.createdAt.toLocal()).diff(
        message.createdAt.toLocal(),
        Units.MINUTE,
      );
    }

    //final channel = streamChannel.channel;
    // final readList = channel.state.read.where((read) {
    //       if (read.user.id == userId) return false;
    //       return read.lastRead.isAfter(message.createdAt) ||
    //           read.lastRead.isAtSameMomentAs(message.createdAt);
    //     }).toList() ??
    //     [];

    //final allRead = readList.length >= (channel.memberCount ?? 0) - 1;
    final hasFileAttachment = false; //message.fileUrl != null;
    // message.attachments.any((it) => it.type == 'file') == true;

    //final isThreadMessage =
    //    message.replyMessageId != null && message.showInChannel == true;

    //final hasReplies = message.replyCount! > 0;

    final attachmentBorderRadius = hasFileAttachment ? 12.0 : 14.0;

    // final showTimeStamp = (_isThreadConversation) && (timeDiff >= 1 || !isNextUserSame);

    // final showUsername = !isMyMessage &&
    //     (_isThreadConversation) && (timeDiff >= 1 || !isNextUserSame);

    // final showUserAvatar = isMyMessage
    //     ? DisplayWidget.gone
    //     : (timeDiff >= 1 || !isNextUserSame)
    //         ? DisplayWidget.show
    //         : DisplayWidget.hide;

    final showSendingIndicator =
        isMyMessage && (index == 0 || timeDiff >= 1 || !isNextUserSame);

    //final showInChannelIndicator = !_isThreadConversation && isThreadMessage;
    //final showThreadReplyIndicator = !_isThreadConversation && hasReplies;
    //final isOnlyEmoji = message.msg.isOnlyEmoji;

    //final hasUrlAttachment =
    //  message.attachments.any((it) => it.ogScrapeUrl != null) == true;

    final borderSide = BorderSide.none;

    //final currentUser = 2; // TODO: SET USER ID
    //final members = [];
    // final currentUserMember =
    //     members.firstWhere((e) => e.user.id == currentUser);

    Widget messageWidget = PrivateChatItem();

    if (widget.messageBuilder != null) {
      messageWidget = widget.messageBuilder(
        context,
        MessageDetails(
          userId,
          message,
          messages,
          index,
        ),
        messages,
        messageWidget as PrivateChatItem,
      );
    }

    var child = messageWidget;
    if (!(message.deleteCode == 3) &&
        !(message.meta == 'system') &&
        widget.onMessageSwiped != null) {
      child = Container(
        decoration: const BoxDecoration(),
        clipBehavior: Clip.hardEdge,
        child: Swipeable(
          onSwipeEnd: () {
            FocusScope.of(context).unfocus();
            widget.onMessageSwiped?.call(message);
          },
          backgroundIcon: Icon(MdiIcons.checkAll),
          child: child,
        ),
      );
    }

    if (initialMessageHighlightComplete &&
        widget.highlightInitialMessage &&
        _isInitialMessage(message.privateMessageId)) {
      final colorTheme = Theme.of(context).primaryColor;
      final highlightColor = widget.messageHighlightColor ?? colorTheme;
      child = TweenAnimationBuilder<Color>(
        tween: ColorTween(
            begin: highlightColor,
            end: Colors.amber //colorTheme.barsBg.withOpacity(0),
            ),
        duration: const Duration(seconds: 3),
        onEnd: () => initialMessageHighlightComplete = true,
        builder: (_, color, child) => Container(
          color: color,
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: child,
        ),
      );
    }
    return child;
  }

  StreamSubscription _messageNewListener;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ItemScrollController();
    _itemPositionListener =
        widget.itemPositionListener ?? ItemPositionsListener.create();
    _itemPositionStream =
        _valueListenableToStreamAdapter(_itemPositionListener.itemPositions);

    // _getOnThreadTap();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //final newStreamChannel = StreamChannel.of(context);
    //_streamTheme = StreamChatTheme.of(context);

    // if (newStreamChannel != streamChannel) {
    //   //streamChannel = newStreamChannel;
    //   _messageNewListener?.cancel();
    //   initialIndex = _initialIndex;
    initialAlignment = _initialAlignment;

    //   _messageNewListener =
    //       streamChannel!.channel.on(EventType.messageNew).listen((event) {
    //     if (_upToDate) {
    //       _bottomPaginationActive = false;
    //       _topPaginationActive = false;
    //     }
    //     if (event.message.user.id ==
    //         streamChannel.channel.client.state.currentUser.id) {
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         _scrollController.jumpTo(
    //           index: 0,
    //         );
    //       });
    //     }
    //   });

    //   if (_isThreadConversation) {
    //     streamChannel.getReplies(widget.parentMessage.privateMessageId);
    //   }
  }

  // super.didChangeDependencies();
}

// void _getOnThreadTap() {
//   if (widget.onThreadTap != null) {
//     _onThreadTap = (PrivateMessage message) {
//       widget.onThreadTap(
//           message,
//           widget.threadBuilder != null
//               ? widget.threadBuilder!(context, message)
//               : null);
//     };
//   } else if (widget.threadBuilder != null) {
//     _onThreadTap = (PrivateMessage message) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => BetterStreamBuilder<PrivateMessage>(
//             stream: streamChannel!.channel.state.messagesStream.map(
//                 (messages) =>
//                     messages!.firstWhere((m) => m.id == message.privateMessageId)),
//             initialData: message,
//             builder: (_, data) => StreamChannel(
//               channel: streamChannel.channel,
//               child: widget.threadBuilder(context, data),
//             ),
//           ),
//         ),
//       );
//     };
//   }
// }

@override
void dispose() {
  // if (!_upToDate) {
  //   streamChannel.reloadChannel();
  // }
  // _messageNewListener?.cancel();
  // super.dispose();
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    Key key,
    @required this.isThreadConversation,
  }) : super(key: key);

  final bool isThreadConversation;

  @override
  Widget build(BuildContext context) {
    // final stream = direction == QueryDirection.top
    //     ? streamChannel.queryTopMessages
    //     : streamChannel.queryBottomMessages;
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ),
    );
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
