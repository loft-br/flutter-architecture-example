import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/common/errors/exceptions.dart';
import 'package:ideas/common/errors/failures.dart';
import 'package:ideas/features/activities/data/datasources/remote/activity_remote_data_source.dart';
import 'package:ideas/features/activities/data/models/activity_model.dart';
import 'package:ideas/features/activities/data/repositories/activity_repository.dart';
import 'package:ideas/features/activities/shared/activity_type_mapper.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements IActivityRemoteDataSource {}

void main() {
  late MockRemoteDataSource remoteDataSource;
  late ActivityRepository repository;
  late ActivityModel model;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    repository = ActivityRepository(remoteDataSource);
    model = ActivityModel.fromJson(jsonDecode(fixture('activity.json')));
  });

  group('Get Random Activity tests', () {
    test('should return an activity when the source returns correctly', () async {
      //Arrange
      when(() => remoteDataSource.getRandomActivity()).thenAnswer((_) async => model);
      //Act
      var result = await repository.getRandomActivity();
      //Assert
      expect(result, Right(model.toEntity()));
    });

    test('should return a NetworkFailure when the datasource throws a NetworkException', () async {
      //Arrange
      when(() => remoteDataSource.getRandomActivity()).thenThrow(const NetworkException());
      //Act
      var result = await repository.getRandomActivity();
      //Assert
      expect(result, const Left(NetworkFailure()));
    });

    test('should return a ServerFailure when the datasource throws a ServerException', () async {
      //Arrange
      when(() => remoteDataSource.getRandomActivity()).thenThrow(const ServerException());
      //Act
      var result = await repository.getRandomActivity();
      //Assert
      expect(result, const Left(ServerFailure()));
    });
  });

  group('Get Activity by type tests', () {
    setUpAll(() {
      registerFallbackValue<ActivityType>(ActivityType.BUSYWORK);
    });

    test('should return an activity when the source returns correctly', () async {
      //Arrange
      when(() => remoteDataSource.getActivityByType(any())).thenAnswer((_) async => model);
      //Act
      var result = await repository.getActivityByType(ActivityType.BUSYWORK);
      //Assert
      expect(result, Right(model.toEntity()));
    });

    test('should return a NetworkFailure when the datasource throws a NetworkException', () async {
      //Arrange
      when(() => remoteDataSource.getActivityByType(any())).thenThrow(const NetworkException());
      //Act
      var result = await repository.getActivityByType(ActivityType.BUSYWORK);
      //Assert
      expect(result, const Left(NetworkFailure()));
    });

    test('should return a ServerFailure when the datasource throws a ServerException', () async {
      //Arrange
      when(() => remoteDataSource.getActivityByType(any())).thenThrow(const ServerException());
      //Act
      var result = await repository.getActivityByType(ActivityType.BUSYWORK);
      //Assert
      expect(result, const Left(ServerFailure()));
    });
  });
}
