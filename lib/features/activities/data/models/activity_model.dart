import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/activity.dart';
import '../../shared/activity_type_mapper.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel extends Equatable {
  final String key;
  final String activity;
  final double accessibility;
  @JsonKey(fromJson: ActivityMapper.activityTypeFromString, toJson: ActivityMapper.activityTypeToString)
  final ActivityType type;
  final int participants;
  final double price;
  final String link;

  const ActivityModel(this.key, this.activity, this.accessibility, this.type, this.participants, this.price, this.link);

  @override
  List<Object?> get props => [activity, accessibility, type, participants, price, link];

  factory ActivityModel.fromEntity(Activity entity) => ActivityModel(
        '',
        entity.activity,
        entity.accessibility,
        entity.type,
        entity.participants,
        entity.price,
        entity.link,
      );

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);
}

extension ActivityModelExtension on ActivityModel {
  Activity toEntity() => Activity(activity, accessibility, type, participants, price, link);
}
