import 'package:dartz/dartz.dart';

import '../../../../common/errors/failures.dart';
import '../../shared/activity_type_mapper.dart';
import '../entities/activity.dart';

abstract class IActivityRepository {
  Future<Either<Failure, Activity>> getRandomActivity();
  Future<Either<Failure, Activity>> getActivityByType(ActivityType type);
}
