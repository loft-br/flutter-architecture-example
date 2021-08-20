import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/features/activities/data/models/activity_model.dart';
import 'package:ideas/features/activities/domain/entities/activity.dart';
import 'package:ideas/features/activities/shared/activity_type_mapper.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late Activity entity;
  late ActivityModel model;

  setUp(() {
    const acessibility = 0.12;
    const price = 0.05;
    entity = const Activity('Listen to a new podcast', acessibility, ActivityType.RELAXATION, 1, price, '');
    model = ActivityModel('4124860', 'Listen to a new podcast', acessibility, ActivityType.RELAXATION, 1, price, '');
  });

  group('Entity and models convertions', () {
    test('should convert correctly from entity to model', () async {
      //Arrange
      //Act
      var result = ActivityModel.fromEntity(entity);
      //Assert
      expect(result, model);
    });

    test('should convert correctly from model to entity', () async {
      //Arrange
      //Act
      var result = model.toEntity();
      //Assert
      expect(result, entity);
    });
  });

  test('should convert from a json correctly', () async {
    //Arrange
    var json = fixture('activity.json');
    //Act
    var result = ActivityModel.fromJson(jsonDecode(json));
    //Assert
    expect(result, model);
  });
}
