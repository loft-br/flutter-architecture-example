import '../data/utils/activity_api_consts.dart';

enum ActivityType {
  EDUCATION,
  RECREATIONAL,
  SOCIAL,
  DIY,
  CHARITY,
  COOKING,
  RELAXATION,
  MUSIC,
  BUSYWORK,
  OTHER,
}

class ActivityMapper {
  static ActivityType activityTypeFromString(String type) {
    switch (type) {
      case ActivityApiConsts.education:
        return ActivityType.EDUCATION;
      case ActivityApiConsts.recreational:
        return ActivityType.RECREATIONAL;
      case ActivityApiConsts.social:
        return ActivityType.SOCIAL;
      case ActivityApiConsts.diy:
        return ActivityType.DIY;
      case ActivityApiConsts.charity:
        return ActivityType.CHARITY;
      case ActivityApiConsts.cooking:
        return ActivityType.COOKING;
      case ActivityApiConsts.relaxation:
        return ActivityType.RELAXATION;
      case ActivityApiConsts.music:
        return ActivityType.MUSIC;
      case ActivityApiConsts.busywork:
        return ActivityType.BUSYWORK;
      default:
        return ActivityType.OTHER;
    }
  }

  static String activityTypeToString(ActivityType type) {
    switch (type) {
      case ActivityType.EDUCATION:
        return ActivityApiConsts.education;
      case ActivityType.RECREATIONAL:
        return ActivityApiConsts.recreational;
      case ActivityType.SOCIAL:
        return ActivityApiConsts.social;
      case ActivityType.DIY:
        return ActivityApiConsts.diy;
      case ActivityType.CHARITY:
        return ActivityApiConsts.charity;
      case ActivityType.COOKING:
        return ActivityApiConsts.cooking;
      case ActivityType.RELAXATION:
        return ActivityApiConsts.relaxation;
      case ActivityType.MUSIC:
        return ActivityApiConsts.music;
      case ActivityType.BUSYWORK:
        return ActivityApiConsts.busywork;
      default:
        return '';
    }
  }
}
