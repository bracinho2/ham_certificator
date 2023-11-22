import 'package:flutter/material.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/core/extensions/date_time_extension.dart';

import '../../../../events/controller/event_controller.dart';
import '../../../../events/view/states/event_states.dart';

class CarouselEventsWidget extends StatefulWidget {
  const CarouselEventsWidget({
    super.key,
    required this.eventController,
  });

  final EventController eventController;

  @override
  State<CarouselEventsWidget> createState() => _CarouselEventsWidgetState();
}

class _CarouselEventsWidgetState extends State<CarouselEventsWidget> {
  EventController get _controller => widget.eventController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        if (value is EventLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (value is EventSuccessState) {
          final events = value
              .events; //.where((event) => event.endAt.isBefore(DateTime.now()));

          return GuaraniCarouselWidget(
            items: events
                .map(
                  (e) => GuaraniCarouselItem(
                    eventName: e.name,
                    eventLocal: '${e.city} - ${e.state} - ${e.country}',
                    eventDate: e.startAt.toHumanDate(),
                    eventMessage: e.startAt.isBefore(DateTime.now())
                        ? 'Evento Realizado'
                        : 'Vem aí',
                    imageUrl: e.imageUrl.isEmpty
                        ? 'assets/placeholder.jpg'
                        : e.imageUrl,
                    onTap: (value) {},
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
