enum RefreshType { HOME }

class RefreshEvent {
  final RefreshType refreshType;

  RefreshEvent({required this.refreshType});
}
