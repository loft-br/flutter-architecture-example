import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/errors/failures.dart';
import '../../domain/entities/activity.dart';
import '../../domain/usecases/get_activity_by_type.dart';
import '../../domain/usecases/get_random_activity.dart';
import '../../shared/activity_type_mapper.dart';

part 'activity_bloc.freezed.dart';
part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetRandomActivity getRandomActivity;
  final GetActivityByType getActivityByType;

  ActivityBloc(this.getRandomActivity, this.getActivityByType) : super(const _Initial());

  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    yield* event.when(
      getRandomActivity: () async* {
        yield const ActivityState.loading();
        var result = await getRandomActivity();
        yield result.fold(
          (failure) => ActivityState.error(_mapFailureToString(failure)),
          (activity) => ActivityState.loaded(activity),
        );
      },
      getActivityByType: (type) async* {
        yield const ActivityState.loading();
        var result = await getActivityByType(type);
        yield result.fold(
          (failure) => ActivityState.error(_mapFailureToString(failure)),
          (activity) => ActivityState.loaded(activity),
        );
      },
    );
  }

  String _mapFailureToString(Failure failure) {
    return failure.maybeWhen(
      networkFailure: () => AppStrings.networkErrorMessage,
      orElse: () => AppStrings.serverErrorMessage,
    );
  }
}
