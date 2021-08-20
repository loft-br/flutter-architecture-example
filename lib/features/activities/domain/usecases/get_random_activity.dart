import 'package:dartz/dartz.dart';

import '../../../../common/errors/failures.dart';
import '../entities/activity.dart';
import '../repositories/i_activity_repository.dart';

class GetRandomActivity {
  final IActivityRepository repository;

  GetRandomActivity(this.repository);

  Future<Either<Failure, Activity>> call() async {
    return await repository.getRandomActivity();
  }
}
