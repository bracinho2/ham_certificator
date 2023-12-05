import 'package:ham_certificator/events/model/event_model.dart';

abstract class EventPageState {}

class EventPageLoadingState extends EventPageState {}

class EventPageSuccessState extends EventPageState {
  final EventModel event;
  EventPageSuccessState({required this.event});
}

class EventPageErrorState extends EventPageState {}
