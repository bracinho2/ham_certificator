import 'package:ham_certificator/events/model/event_model.dart';

abstract class HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageSuccessState extends HomePageState {
  final List<EventModel> events;

  HomePageSuccessState({
    required this.events,
  });
}

class HomePageErrorState extends HomePageState {}
