import 'package:equatable/equatable.dart';

import '../../shared/activity_type_mapper.dart';

class Activity extends Equatable {
  final String activity;
  final double accessibility;
  final ActivityType type;
  final int participants;
  final double price;
  final String link;

  const Activity(this.activity, this.accessibility, this.type, this.participants, this.price, this.link);

  @override
  List<Object?> get props => [activity, accessibility, type, participants, price, link];
}
