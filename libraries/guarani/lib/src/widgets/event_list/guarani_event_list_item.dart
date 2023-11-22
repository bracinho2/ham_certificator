class GuaraniEventListItem {
  GuaraniEventListItem({
    required this.name,
    required this.local,
    required this.startDate,
    required this.imageUrl,
    required this.onTap,
  });
  final String name;
  final String local;
  final DateTime startDate;
  final String imageUrl;
  final Function(GuaraniEventListItem item) onTap;

  @override
  String toString() {
    return 'GuaraniEventListItem(name: $name, local: $local, startDate: $startDate, imageUrl: $imageUrl, onTap: $onTap)';
  }
}
