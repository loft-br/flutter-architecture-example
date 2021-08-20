import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/features/activities/data/utils/activity_api_consts.dart';
import 'package:ideas/features/activities/shared/activity_type_mapper.dart';

void main() {
  test('should convert correctly an existing type into the correspondent string', () async {
    //Arrange
    //Act
    var result = ActivityMapper.activityTypeToString(ActivityType.BUSYWORK);
    //Assert
    expect(result, ActivityApiConsts.busywork);
  });

  test('should convert correctly an string into an existing activity type', () async {
    //Arrange
    //Act
    var result = ActivityMapper.activityTypeFromString(ActivityApiConsts.busywork);
    //Assert
    expect(result, ActivityType.BUSYWORK);
  });
}
