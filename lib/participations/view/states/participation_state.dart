import '../../model/participation_model.dart';

abstract class ParticipationState {}

class ParticipationLoadingState extends ParticipationState {}

class ParticipationSuccessState extends ParticipationState {
  final List<ParticipationModel> participations;

  ParticipationSuccessState({
    required this.participations,
  });
}

class ParticipationErrorState extends ParticipationState {}
