import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/features/activities/domain/entities/activity.dart';
import 'package:ideas/features/activities/domain/repositories/i_activity_repository.dart';
import 'package:ideas/features/activities/domain/usecases/get_activity_by_type.dart';
import 'package:ideas/features/activities/shared/activity_type_mapper.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements IActivityRepository {}

class FakeActivity extends Fake implements Activity {}

void main() {
  late GetActivityByType usecase;
  late MockRepository repository;
  late FakeActivity activity;

  setUp(() {
    repository = MockRepository();
    usecase = GetActivityByType(repository);
    activity = FakeActivity();
  });

  setUpAll(() {
    registerFallbackValue<ActivityType>(ActivityType.BUSYWORK);
  });

  test('should call the repository when the usecase is called', () async {
    //Arrange
    when(() => repository.getActivityByType(any())).thenAnswer((_) async => Right(activity));
    //Act
    var result = await usecase.call(ActivityType.CHARITY);
    //Assert
    expect(result, Right(activity));
    verify(() => repository.getActivityByType(ActivityType.CHARITY));
    verifyNoMoreInteractions(repository);
  });
}
