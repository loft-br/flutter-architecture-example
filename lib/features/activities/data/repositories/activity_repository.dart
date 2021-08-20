import 'package:dartz/dartz.dart';

import '../../../../common/errors/exceptions.dart';
import '../../../../common/errors/failures.dart';
import '../../domain/entities/activity.dart';
import '../../domain/repositories/i_activity_repository.dart';
import '../../shared/activity_type_mapper.dart';
import '../datasources/remote/activity_remote_data_source.dart';
import '../models/activity_model.dart';

class ActivityRepository implements IActivityRepository {
  final IActivityRemoteDataSource remoteDataSource;

  ActivityRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, Activity>> getActivityByType(ActivityType type) async {
    try {
      var result = await remoteDataSource.getActivityByType(type);
      return Right(result.toEntity());
    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Activity>> getRandomActivity() async {
    try {
      var result = await remoteDataSource.getRandomActivity();
      return Right(result.toEntity());
    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
