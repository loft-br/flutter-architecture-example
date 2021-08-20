// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel(
    json['key'] as String,
    json['activity'] as String,
    (json['accessibility'] as num).toDouble(),
    ActivityMapper.activityTypeFromString(json['type'] as String),
    json['participants'] as int,
    (json['price'] as num).toDouble(),
    json['link'] as String,
  );
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'activity': instance.activity,
      'accessibility': instance.accessibility,
      'type': ActivityMapper.activityTypeToString(instance.type),
      'participants': instance.participants,
      'price': instance.price,
      'link': instance.link,
    };
