// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:telechat/features/chat/data/models/private_message.dart';
// import 'package:telechat/features/chat/presentation/widgets/private_chat_list_view.dart';

// import 'better_stream_builder.dart';

// /// [MessageListCore] is a simplified class that allows fetching a list of
// /// messages while exposing UI builders.
// ///
// /// A [MessageListController] is used to paginate data.
// ///
// /// ```dart
// /// class ChannelPage extends StatelessWidget {
// ///   const ChannelPage({
// ///     Key key,
// ///   }) : super(key: key);
// ///
// ///   @override
// ///   Widget build(BuildContext context) {
// ///     return Scaffold(
// ///       body: Column(
// ///         children: <Widget>[
// ///           Expanded(
// ///             child: MessageListCore(
// ///         emptyBuilder: (context) {
// ///           return Center(
// ///             child: Text('Nothing here...'),
// ///           );
// ///         },
// ///         loadingBuilder: (context) {
// ///           return Center(
// ///             child: CircularProgressIndicator(),
// ///           );
// ///         },
// ///         messageListBuilder: (context, list) {
// ///           return MessagesPage(list);
// ///         },
// ///         errorBuilder: (context, err) {
// ///           return Center(
// ///             child: Text('Error'),
// ///           );
// ///         },
// ///             ),
// ///           ),
// ///         ],
// ///       ),
// ///     );
// ///   }
// /// }
// /// ```
// ///
// ///
// /// Make sure to have a [StreamChannel] ancestor in order to provide the
// /// information about the channels.
// ///
// /// The widget uses a [ListView.custom] to render the list of channels.
// ///
// class MessageListCore extends StatefulWidget {
//   /// Instantiate a new [MessageListView].
//   const MessageListCore({
//     Key key,
//     @required this.loadingBuilder,
//     @required this.emptyBuilder,
//     @required this.messageListBuilder,
//     @required this.errorBuilder,
//     this.parentMessage,
//     this.messageListController,
//     this.messageFilter,
//     this.paginationLimit = 20,
//   }) : super(key: key);

//   /// A [MessageListController] allows pagination.
//   /// Use [ChannelListController.paginateData] pagination.
//   final MessageListController messageListController;

//   /// Function called when messages are fetched
//   final Widget Function(BuildContext, List<PrivateMessage>) messageListBuilder;

//   /// Function used to build a loading widget
//   final WidgetBuilder loadingBuilder;

//   /// Function used to build an empty widget
//   final WidgetBuilder emptyBuilder;

//   /// Limit used to paginate messages
//   final int paginationLimit;

//   /// Callback triggered when an error occurs while performing the given
//   /// request.
//   ///
//   /// This parameter can be used to display an error message to users in the
//   /// event of a connection failure.
//   final ErrorBuilder errorBuilder;

//   /// If the current message belongs to a `thread`, this property represents the
//   /// first message or the parent of the conversation.
//   final PrivateMessage parentMessage;

//   /// Predicate used to filter messages
//   final bool Function(PrivateMessage) messageFilter;

//   @override
//   MessageListCoreState createState() => MessageListCoreState();
// }

// /// The current state of the [MessageListCore].
// class MessageListCoreState extends State<MessageListCore> {
//   //StreamChannelState _streamChannel;

//   bool get _upToDate => _streamChannel.channel.state.isUpToDate ?? true;

//   bool get _isThreadConversation => widget.parentMessage != null;

//   User get _currentUser => _streamChannel.channel.client.state.currentUser;

//   var _messages = <PrivateMessage>[];

//   @override
//   Widget build(BuildContext context) {
//     final messagesStream = _isThreadConversation
//         ? _streamChannel.channel.state.threadsStream
//             .where((threads) => threads.containsKey(widget.parentMessage.privateMessageId))
//             .map((threads) => threads[widget.parentMessage.privateMessageId])
//         : _streamChannel.channel.state.messagesStream;

//     final initialData = _isThreadConversation
//         ? _streamChannel.channel.state.threads[widget.parentMessage.privateMessageId]
//         : _streamChannel.channel.state.messages;

//     bool defaultFilter(PrivateMessage m) {
//       final isMyMessage = m.user.userId == _currentUser.userId;
//       if (!isMyMessage) return false;
//       return true;
//     }

//     return BetterStreamBuilder<List<PrivateMessage>>(
//       initialData: initialData,
//       comparator: const ListEquality().equals,
//       stream: messagesStream.map(
//         (messages) =>
//             messages.where(widget.messageFilter ?? defaultFilter).toList(
//                   growable: false,
//                 ),
//       ),
//       errorBuilder: widget.errorBuilder,
//       loadingBuilder: widget.loadingBuilder,
//       builder: (context, data) {
//         final messageList = data.reversed.toList(growable: false) ?? [];
//         if (messageList.isEmpty && !_isThreadConversation) {
//           if (_upToDate) {
//             return widget.emptyBuilder(context);
//           }
//         } else {
//           _messages = messageList;
//         }
//         return widget.messageListBuilder(context, _messages);
//       },
//     );
//   }

//   /// Fetches more messages with updated pagination and updates the widget.
//   ///
//   /// Optionally pass the fetch direction, defaults to [QueryDirection.top]
//   /// Optionally pass a limit, defaults to 20
//   Future<void> paginateData({
//     QueryDirection direction = QueryDirection.top,
//   }) {
//     if (!_isThreadConversation) {
//       return _streamChannel.queryMessages(
//         direction: direction,
//         limit: widget.paginationLimit,
//       );
//     } else {
//       return _streamChannel.getReplies(
//         widget.parentMessage.privateMessageId,
//         limit: widget.paginationLimit,
//       );
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     final newStreamChannel = StreamChannel.of(context);

//     if (newStreamChannel != _streamChannel) {
//       if (_streamChannel == null /*only first time*/ && _isThreadConversation) {
//         newStreamChannel.getReplies(
//           widget.parentMessage.privateMessageId,
//           limit: widget.paginationLimit,
//         );
//       }
//       _streamChannel = newStreamChannel;
//     }

//     super.didChangeDependencies();
//   }

//   @override
//   void didUpdateWidget(covariant MessageListCore oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (widget.messageListController != oldWidget.messageListController) {
//       _setupController();
//     }

//     if (widget.parentMessage.privateMessageId != widget.parentMessage.privateMessageId) {
//       if (_isThreadConversation) {
//         _streamChannel.getReplies(
//           widget.parentMessage.privateMessageId,
//           limit: widget.paginationLimit,
//         );
//       }
//     }
//   }

//   @override
//   void initState() {
//     _setupController();

//     super.initState();
//   }

//   void _setupController() {
//     if (widget.messageListController != null) {
//       widget.messageListController.paginateData = paginateData;
//     }
//   }

//   @override
//   void dispose() {
//     if (!_upToDate) {
//       _streamChannel.reloadChannel();
//     }
//     super.dispose();
//   }
// }

// /// Controller used for paginating data in [ChannelListView]
// class MessageListController {
//   /// Call this function to load further data
//   Future<void> Function({QueryDirection direction}) paginateData;
// }
