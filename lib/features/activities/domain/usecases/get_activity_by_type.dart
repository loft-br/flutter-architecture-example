import 'package:dartz/dartz.dart';

import '../../../../common/errors/failures.dart';
import '../../shared/activity_type_mapper.dart';
import '../entities/activity.dart';
import '../repositories/i_activity_repository.dart';

class GetActivityByType {
  final IActivityRepository repository;

  GetActivityByType(this.repository);

  Future<Either<Failure, Activity>> call(ActivityType type) async {
    return await repository.getActivityByType(type);
  }
}
