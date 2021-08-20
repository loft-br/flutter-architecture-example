part of 'activity_bloc.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState.initial() = _Initial;
  const factory ActivityState.loading() = _Loading;
  const factory ActivityState.loaded(Activity activity) = _Loaded;
  const factory ActivityState.error(String message) = _Error;
}
