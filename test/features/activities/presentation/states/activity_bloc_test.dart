import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/common/app_strings.dart';
import 'package:ideas/common/errors/failures.dart';
import 'package:ideas/features/activities/data/models/activity_model.dart';
import 'package:ideas/features/activities/domain/entities/activity.dart';
import 'package:ideas/features/activities/domain/usecases/get_activity_by_type.dart';
import 'package:ideas/features/activities/domain/usecases/get_random_activity.dart';
import 'package:ideas/features/activities/presentation/states/activity_bloc.dart';
import 'package:ideas/features/activities/shared/activity_type_mapper.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetRandomActivity extends Mock implements GetRandomActivity {}

class MockGetActivityByType extends Mock implements GetActivityByType {}

void main() {
  late MockGetRandomActivity getRandomActivity;
  late MockGetActivityByType getActivityByType;
  late ActivityBloc bloc;
  late Activity activity;

  setUp(() {
    getRandomActivity = MockGetRandomActivity();
    getActivityByType = MockGetActivityByType();
    bloc = ActivityBloc(getRandomActivity, getActivityByType);
    activity = ActivityModel.fromJson(jsonDecode(fixture('activity.json'))).toEntity();
  });

  setUpAll(() {
    registerFallbackValue<ActivityType>(ActivityType.BUSYWORK);
  });

  test('should emit Initial as initial state', () async {
    //Arrange
    //Act
    //Assert
    expect(bloc.state, const ActivityState.initial());
  });

  test('should emit Loading and Loaded states when the usecase returns a random activity', () async {
    //Arrange
    when(() => getRandomActivity()).thenAnswer((_) async => Right(activity));
    //Assert Later
    final states = [const ActivityState.loading(), ActivityState.loaded(activity)];
    expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(states));
    //Act
    bloc.add(const ActivityEvent.getRandomActivity());
  });

  test('should emit Loading and Loaded states when the usecase returns an Activity', () async {
    //Arrange
    when(() => getActivityByType.call(any())).thenAnswer((_) async => Right(activity));
    //Assert Later
    final states = [const ActivityState.loading(), ActivityState.loaded(activity)];
    expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(states));
    //Act
    bloc.add(const ActivityEvent.getActivityByType(ActivityType.BUSYWORK));
  });

  test('should emit Loading and Error states when the usecase returns a NetworkFailure', () async {
    //Arrange
    when(() => getRandomActivity.call()).thenAnswer((_) async => const Left(NetworkFailure()));
    //Assert Later
    final states = [const ActivityState.loading(), const ActivityState.error(AppStrings.networkErrorMessage)];
    expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(states));
    //Act
    bloc.add(const ActivityEvent.getRandomActivity());
  });

  test('should emit Loading and Error states when the usecase returns a ServerFailure', () async {
    //Arrange
    when(() => getRandomActivity.call()).thenAnswer((_) async => const Left(ServerFailure()));
    //Assert Later
    final states = [const ActivityState.loading(), const ActivityState.error(AppStrings.serverErrorMessage)];
    expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(states));
    //Act
    bloc.add(const ActivityEvent.getRandomActivity());
  });
}
