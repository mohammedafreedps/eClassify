import 'dart:convert';

import 'package:eClassify/features/movies/model/video_model.dart';
import 'package:flutter/foundation.dart';



class ChannelModel {
  final String id;
  final String title;
  final String profilePictureUrl;
  final String subscriberCount;
  final String videoCount;
  final String uploadPlaylistId;
  List<VideoModel> videos;
  ChannelModel({
    required this.id,
    required this.title,
    required this.profilePictureUrl,
    required this.subscriberCount,
    required this.videoCount,
    required this.uploadPlaylistId,
    required this.videos,
  });

  ChannelModel copyWith({
    String? id,
    String? title,
    String? profilePictureUrl,
    String? subscriberCount,
    String? videoCount,
    String? uploadPlaylistId,
    List<VideoModel>? videos,
  }) {
    return ChannelModel(
      id: id ?? this.id,
      title: title ?? this.title,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      subscriberCount: subscriberCount ?? this.subscriberCount,
      videoCount: videoCount ?? this.videoCount,
      uploadPlaylistId: uploadPlaylistId ?? this.uploadPlaylistId,
      videos: videos ?? this.videos,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'profilePictureUrl': profilePictureUrl});
    result.addAll({'subscriberCount': subscriberCount});
    result.addAll({'videoCount': videoCount});
    result.addAll({'uploadPlaylistId': uploadPlaylistId});
    result.addAll({'videos': videos.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    return ChannelModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      profilePictureUrl: map['profilePictureUrl'] ?? '',
      subscriberCount: map['subscriberCount'] ?? '',
      videoCount: map['videoCount'] ?? '',
      uploadPlaylistId: map['uploadPlaylistId'] ?? '',
      videos: List<VideoModel>.from(
          map['videos']?.map((x) => VideoModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelModel.fromJson(String source) =>
      ChannelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChannelModel(id: $id, title: $title, profilePictureUrl: $profilePictureUrl, subscriberCount: $subscriberCount, videoCount: $videoCount, uploadPlaylistId: $uploadPlaylistId, videos: $videos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChannelModel &&
        other.id == id &&
        other.title == title &&
        other.profilePictureUrl == profilePictureUrl &&
        other.subscriberCount == subscriberCount &&
        other.videoCount == videoCount &&
        other.uploadPlaylistId == uploadPlaylistId &&
        listEquals(other.videos, videos);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        profilePictureUrl.hashCode ^
        subscriberCount.hashCode ^
        videoCount.hashCode ^
        uploadPlaylistId.hashCode ^
        videos.hashCode;
  }
}
