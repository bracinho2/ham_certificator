enum HamCertificatorStorageCollectionsENUM {
  events('events');

  final String value;

  const HamCertificatorStorageCollectionsENUM(this.value);

  static HamCertificatorStorageCollectionsENUM fromString(String value) =>
      HamCertificatorStorageCollectionsENUM.values.firstWhere(
        (e) => e.value.toLowerCase() == value.toLowerCase(),
        orElse: () => HamCertificatorStorageCollectionsENUM.events,
      );
}
