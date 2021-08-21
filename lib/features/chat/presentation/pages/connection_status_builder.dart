// import 'package:flutter/material.dart';
// import 'package:supabase/supabase.dart';
// import 'package:telechat/core/consts/app_config.dart';
// import 'package:telechat/core/widgets/better_stream_builder.dart';

// /// Widget that builds itself based on the latest snapshot of interaction with
// /// a [Stream] of type [ConnectionStatus].
// ///
// /// The widget will use the closest [StreamChatClient.wsConnectionStatusStream]
// /// in case no stream is provided.
// class ConnectionStatusBuilder extends StatelessWidget {
//   /// Creates a new ConnectionStatusBuilder
//   const ConnectionStatusBuilder({
//     Key key,
//     @required this.statusBuilder,
//     this.connectionStatusStream,
//     this.errorBuilder,
//     this.loadingBuilder,
//   }) : super(key: key);

//   /// The asynchronous computation to which this builder is currently connected.
//   final Stream<ConnectionStatus> connectionStatusStream;

//   /// The builder that will be used in case of error
//   final Widget Function(BuildContext context, Object error) errorBuilder;

//   /// The builder that will be used in case of loading
//   final WidgetBuilder loadingBuilder;

//   /// The builder that will be used in case of data
//   final Widget Function(BuildContext context, ConnectionStatus status)
//       statusBuilder;

//   @override
//   Widget build(BuildContext context) {
//     SupabaseClient sClient =
//         SupabaseClient(AppConfig.supaBaseUrl, AppConfig.supaBaseKey);
//     sClient.realtime.channels;
    
//     final stream = connectionStatusStream ??
//         StreamChat.of(context).client.wsConnectionStatusStream;
//     final client = StreamChat.of(context).client;
//     return BetterStreamBuilder<ConnectionStatus>(
//       initialData: client.wsConnectionStatus,
//       stream: stream,
//       loadingBuilder: loadingBuilder,
//       errorBuilder: (context, error) {
//         if (errorBuilder != null) {
//           return errorBuilder(context, error);
//         }
//         return const Offstage();
//       },
//       builder: statusBuilder,
//     );
//   }
// }

// /// Used to notify the WS connection status
// enum ConnectionStatus {
//   /// WS is connected and everything is good
//   connected,

//   /// WS is connecting (usually reconnecting)
//   connecting,

//   /// WS is disconnected and it's not reconnecting
//   disconnected,
// }
