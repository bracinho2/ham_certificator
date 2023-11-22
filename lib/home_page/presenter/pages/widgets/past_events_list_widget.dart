import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:guarani/guarani.dart';

import '../../../../events/controller/event_controller.dart';
import '../../../../events/view/states/event_states.dart';
import '../../../../participations/controller/participation_controller.dart';
import '../../../../participations/view/pages/participations_page.dart';

class PastEventsListWidget extends StatefulWidget {
  const PastEventsListWidget({
    super.key,
    required this.eventController,
  });

  final EventController eventController;

  @override
  State<PastEventsListWidget> createState() => _PastEventsListWidgetState();
}

class _PastEventsListWidgetState extends State<PastEventsListWidget> {
  EventController get _controller => widget.eventController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        if (value is EventSuccessState) {
          final events = value.events
              .where((event) => event.endAt.isBefore(DateTime.now()));
          return GuaraniEventListWidget(
            items: events
                .map(
                  (event) => GuaraniEventListItem(
                    name: event.name,
                    local: '${event.city} - ${event.state} - ${event.country}',
                    startDate: event.startAt,
                    imageUrl: event.imageUrl.isEmpty
                        ? 'assets/placeholder.jpg'
                        : event.imageUrl,
                    onTap: (_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParticipationsPage(
                            eventModel: event,
                            certificatesController:
                                GetIt.I.get<ParticipationController>(),
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
