class GuaraniCarouselItem {
  final String eventName;
  final String eventLocal;
  final String eventDate;
  final String eventMessage;
  final String imageUrl;
  final Function(GuaraniCarouselItem item) onTap;

  GuaraniCarouselItem({
    required this.eventName,
    required this.eventLocal,
    required this.eventDate,
    required this.eventMessage,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  String toString() {
    return 'GuaraniCarouselItem(eventName: $eventName, eventLocal: $eventLocal, eventDate: $eventDate, imageUrl: $imageUrl, onTap: $onTap)';
  }
}
