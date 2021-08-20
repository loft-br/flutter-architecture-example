part of 'activity_bloc.dart';

@freezed
class ActivityEvent with _$ActivityEvent {
  const factory ActivityEvent.getRandomActivity() = _GetRandomActivity;
  const factory ActivityEvent.getActivityByType(ActivityType type) = _GetActivityByType;
}
