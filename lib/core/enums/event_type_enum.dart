enum EventTypeEnum {
  party('party'),
  fieldDay('field_day');

  final String value;

  const EventTypeEnum(this.value);

  static EventTypeEnum fromString(String value) => EventTypeEnum.values
      .firstWhere((e) => e.value.toLowerCase() == value.toLowerCase(),
          orElse: () => EventTypeEnum.party);
}

enum ParticipationTypeEnum {
  hamradio('hamradio'),
  friend('friend');

  final String value;

  const ParticipationTypeEnum(this.value);

  static ParticipationTypeEnum fromString(String value) =>
      ParticipationTypeEnum.values.firstWhere(
          (e) => e.value.toLowerCase() == value.toLowerCase(),
          orElse: () => ParticipationTypeEnum.hamradio);
}
