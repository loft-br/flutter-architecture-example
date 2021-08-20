import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di.dart';
import '../../domain/entities/activity.dart';
import '../../shared/activity_type_mapper.dart';
import '../states/activity_bloc.dart';

class ActivityScreen extends StatefulWidget implements AutoRouteWrapper {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    var bloc = sl<ActivityBloc>();
    return BlocProvider.value(value: bloc, child: this);
  }
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _type = '';
  var bloc = sl<ActivityBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Idea generator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<ActivityBloc, ActivityState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (activity) async {
              await _showActivityDialog(activity);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            orElse: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(const ActivityEvent.getRandomActivity());
                    },
                    child: const Text(
                      'Give me a random idea',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('or get a specific one: '),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: _type,
                        items: _getAllActivityTypes()
                            .map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            _type = item as String;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          var _activityType = ActivityMapper.activityTypeFromString(_type);
                          bloc.add(ActivityEvent.getActivityByType(_activityType));
                        },
                        child: const Text(
                          'Go',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> _getAllActivityTypes() {
    var list = <String>[];
    for (var element in ActivityType.values) {
      list.add(ActivityMapper.activityTypeToString(element));
    }
    return list;
  }

  Future<void> _showActivityDialog(Activity activity) async {
    var type = ActivityMapper.activityTypeToString(activity.type);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(activity.activity),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Type :$type'),
                Text('Price: ${activity.price.toString()}'),
                Text('Acessibility: ${activity.accessibility.toString()}'),
                Text('Participants: ${activity.participants.toString()}'),
                Text('Link: ${activity.link}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('BACK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
