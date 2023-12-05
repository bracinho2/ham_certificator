import '../../../persons/controller/person_controller.dart';

class HomePageFacade {
  final PersonController personController;
  HomePageFacade({
    required this.personController,
  });

  void init() async {
    personController.init();
  }
}
