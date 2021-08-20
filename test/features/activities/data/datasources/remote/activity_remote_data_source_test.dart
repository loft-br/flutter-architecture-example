import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/common/device/network_info.dart';
import 'package:ideas/common/errors/exceptions.dart';
import 'package:ideas/features/activities/data/datasources/remote/activity_remote_data_source.dart';
import 'package:ideas/features/activities/data/models/activity_model.dart';
import 'package:ideas/features/activities/shared/activity_type_mapper.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockClient extends Mock implements http.Client {}

void main() {
  late MockNetworkInfo networkInfo;
  late MockClient client;
  late ActivityRemoteDataSource dataSource;

  setUp(() {
    networkInfo = MockNetworkInfo();
    client = MockClient();
    dataSource = ActivityRemoteDataSource(client, networkInfo);
  });

  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
  });

  group('Offline tests', () {
    setUp(() {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('getRandomActivity - should throw a NetworkException when there is no connection', () async {
      //Arrange
      //Act
      //Assert
      expect(() => dataSource.getRandomActivity(), throwsA(isA<NetworkException>()));
    });

    test('getActivityByType - should throw a NetworkException when there is no connection', () async {
      //Arrange
      //Act
      //Assert
      expect(() => dataSource.getActivityByType(ActivityType.DIY), throwsA(isA<NetworkException>()));
    });
  });

  group('Online tests', () {
    setUp(() {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('getRandomActivity - should should an ActivityModel when the client returns OK', () async {
      //Arrange
      var json = fixture('activity.json');
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(json, HttpStatus.ok));
      //Act
      var result = await dataSource.getRandomActivity();
      //Assert
      expect(result, ActivityModel.fromJson(jsonDecode(json)));
    });

    test('getActivityByType - should should an ActivityModel when the client returns OK', () async {
      //Arrange
      var json = fixture('activity.json');
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(json, HttpStatus.ok));
      //Act
      var result = await dataSource.getActivityByType(ActivityType.DIY);
      //Assert
      expect(result, ActivityModel.fromJson(jsonDecode(json)));
    });

    test('getRandomActivity - should throw a ServerException when the client returns other than 200', () async {
      //Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', HttpStatus.internalServerError));
      //Act
      //Assert
      expect(() => dataSource.getRandomActivity(), throwsA(isA<ServerException>()));
    });

    test('getActivityByType - should throw a ServerException when the client returns other than 200', () async {
      //Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', HttpStatus.internalServerError));
      //Act
      //Assert
      expect(() => dataSource.getActivityByType(ActivityType.EDUCATION), throwsA(isA<ServerException>()));
    });
  });
}
