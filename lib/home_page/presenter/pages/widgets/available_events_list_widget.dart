import 'package:flutter/material.dart';
import 'package:guarani/guarani.dart';

import '../../../../events/controller/event_controller.dart';
import '../../../../events/view/pages/event_page.dart';
import '../../../../events/view/states/event_states.dart';


class AvailableEventsListWidget extends StatefulWidget {
  const AvailableEventsListWidget({
    super.key,
    required this.eventController,
  });

  final EventController eventController;

  @override
  State<AvailableEventsListWidget> createState() =>
      _AvailableEventsListWidgetState();
}

class _AvailableEventsListWidgetState extends State<AvailableEventsListWidget> {
  EventController get _controller => widget.eventController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        if (value is EventSuccessState) {
          final events = value.events
              .where((event) => event.endAt.isAfter(DateTime.now()));
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
                      if (event.hasPageDetails) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventPage(
                              eventModel: event,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Dados do evento indisponíveis.',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        );
                      }
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
