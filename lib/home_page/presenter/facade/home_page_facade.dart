import '../../../events/controller/event_controller.dart';
import '../../../persons/controller/person_controller.dart';

class HomePageFacade {
  final EventController eventController;
  final PersonController personController;
  HomePageFacade({
    required this.eventController,
    required this.personController,
  });

  void init() async {
    eventController.init();
    personController.init();
  }
}
