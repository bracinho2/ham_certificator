
import '../../model/event_model.dart';

abstract class EventState {}

class EventLoadingState extends EventState {}

class EventSuccessState extends EventState {
  final List<EventModel> events;

  EventSuccessState(
    this.events,
  );
}

class EventErrorState extends EventState {}
