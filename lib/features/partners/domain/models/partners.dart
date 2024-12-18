// lib/features/partners/models/partner.dart
class Partner {
  final String name;
  final String logoPath;
  final String websiteUrl;
  final String type;

  const Partner({
    required this.name,
    required this.logoPath,
    required this.websiteUrl,
    required this.type,
  });
}