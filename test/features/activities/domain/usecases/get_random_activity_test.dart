import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/features/activities/domain/entities/activity.dart';
import 'package:ideas/features/activities/domain/repositories/i_activity_repository.dart';
import 'package:ideas/features/activities/domain/usecases/get_random_activity.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements IActivityRepository {}

class FakeActivity extends Fake implements Activity {}

void main() {
  late MockRepository repository;
  late GetRandomActivity usecase;
  late FakeActivity activity;

  setUp(() {
    repository = MockRepository();
    usecase = GetRandomActivity(repository);
    activity = FakeActivity();
  });

  test('should call the repository when the usecase is called', () async {
    //Arrange
    when(() => repository.getRandomActivity()).thenAnswer((_) async => Right(activity));
    //Act
    var result = await usecase.call();
    //Assert
    expect(result, Right(activity));
    verify(() => repository.getRandomActivity());
    verifyNoMoreInteractions(repository);
  });
}
