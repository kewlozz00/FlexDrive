String? validateSearchQuery(String? value) {
  final query = value?.trim() ?? '';

  if (query.isEmpty) {
    return null;
  }

  if (query.length < 2) {
    return 'Enter at least 2 characters';
  }

  return null;
}
