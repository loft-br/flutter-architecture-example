import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../utils/activity_api_consts.dart';

import '../../../../../common/device/network_info.dart';
import '../../../../../common/errors/exceptions.dart';
import '../../../shared/activity_type_mapper.dart';
import '../../models/activity_model.dart';

abstract class IActivityRemoteDataSource {
  Future<ActivityModel> getRandomActivity();
  Future<ActivityModel> getActivityByType(ActivityType type);
}

class ActivityRemoteDataSource implements IActivityRemoteDataSource {
  final http.Client client;
  final INetworkInfo networkInfo;

  ActivityRemoteDataSource(this.client, this.networkInfo);

  @override
  Future<ActivityModel> getActivityByType(ActivityType type) async {
    var result = await networkInfo.isConnected;
    if (!result) {
      throw const NetworkException();
    } else {
      final response = await client.get(Uri(
        scheme: ActivityApiConsts.scheme,
        host: ActivityApiConsts.host,
        pathSegments: [...ActivityApiConsts.pathSegments.split('/')],
        queryParameters: {'type': ActivityMapper.activityTypeToString(type)},
      ));
      switch (response.statusCode) {
        case HttpStatus.ok:
          return ActivityModel.fromJson(jsonDecode(utf8.decode(response.body.runes.toList())));
        default:
          throw const ServerException();
      }
    }
  }

  @override
  Future<ActivityModel> getRandomActivity() async {
    var result = await networkInfo.isConnected;
    if (!result) {
      throw const NetworkException();
    } else {
      final response = await client.get(Uri(
        scheme: ActivityApiConsts.scheme,
        host: ActivityApiConsts.host,
        pathSegments: [...ActivityApiConsts.pathSegments.split('/')],
      ));
      switch (response.statusCode) {
        case HttpStatus.ok:
          return ActivityModel.fromJson(jsonDecode(utf8.decode(response.body.runes.toList())));
        default:
          throw const ServerException();
      }
    }
  }
}
