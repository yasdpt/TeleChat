// To parse this JSON data, do
//
//     final privateMessage = privateMessageFromMap(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class PrivateMessage extends Equatable {
  PrivateMessage({
    @required this.privateMessageId,
    @required this.msg,
    @required this.chatHash,
    @required this.fileUrl,
    @required this.meta,
    @required this.senderId,
    @required this.replyMessageId,
    @required this.forwardedFromId,
    @required this.isSeen,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.deleteCode,
    @required this.replyMessageText,
    @required this.user,
  });

  final int privateMessageId;
  final String msg;
  final String chatHash;
  final String fileUrl;
  final String meta;
  final int senderId;
  final dynamic replyMessageId;
  final dynamic forwardedFromId;
  final bool isSeen;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int deleteCode;
  final dynamic replyMessageText;
  final User user;

  factory PrivateMessage.fromJson(String str) =>
      PrivateMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrivateMessage.fromMap(Map<String, dynamic> json) => PrivateMessage(
        privateMessageId: json["private_message_id"],
        msg: json["msg"],
        chatHash: json["chat_hash"],
        fileUrl: json["file_url"],
        meta: json["meta"],
        senderId: json["sender_id"],
        replyMessageId: json["reply_message_id"],
        forwardedFromId: json["forwarded_from_id"],
        isSeen: json["is_seen"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deleteCode: json["delete_code"],
        replyMessageText: json["reply_message_text"],
        user: User.fromMap(json["telechat_users"]),
      );

  Map<String, dynamic> toMap() => {
        "private_message_id": privateMessageId,
        "msg": msg,
        "chat_hash": chatHash,
        "file_url": fileUrl,
        "meta": meta,
        "sender_id": senderId,
        "reply_message_id": replyMessageId,
        "forwarded_from_id": forwardedFromId,
        "is_seen": isSeen,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delete_code": deleteCode,
        "reply_message_text": replyMessageText,
        "telechat_users": user.toMap(),
      };

  @override
  List<Object> get props => [
        privateMessageId,
        msg,
        chatHash,
        fileUrl,
        meta,
        senderId,
        replyMessageId,
        forwardedFromId,
        isSeen,
        createdAt,
        updatedAt,
        deleteCode,
        replyMessageText,
        user,
      ];
}

class User extends Equatable {
  User({
    @required this.userId,
    @required this.username,
    @required this.password,
    @required this.email,
    @required this.phone,
    @required this.isBanned,
    @required this.profileImage,
    @required this.lastSeen,
    @required this.nickName,
    @required this.bio,
    @required this.isAccountDeleted,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int userId;
  final String username;
  final String password;
  final String email;
  final String phone;
  final bool isBanned;
  final String profileImage;
  final String lastSeen;
  final String nickName;
  final String bio;
  final bool isAccountDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phone: json["phone"],
        isBanned: json["is_banned"],
        profileImage: json["profile_image"],
        lastSeen: json["last_seen"],
        nickName: json["nick_name"],
        bio: json["bio"],
        isAccountDeleted: json["is_account_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "is_banned": isBanned,
        "profile_image": profileImage,
        "last_seen": lastSeen,
        "nick_name": nickName,
        "bio": bio,
        "is_account_deleted": isAccountDeleted,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object> get props => [
        userId,
        username,
        password,
        email,
        phone,
        isBanned,
        profileImage,
        lastSeen,
        nickName,
        bio,
        isAccountDeleted,
        createdAt,
        updatedAt,
      ];
}
