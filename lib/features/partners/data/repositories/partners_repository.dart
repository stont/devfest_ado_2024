// lib/features/partners/data/repositories/partners_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/partner.dart';
import '../../domain/models/partners.dart';
import '../../models/partners.dart';

part 'partners_repository.g.dart';

@riverpod
class PartnersRepository extends _$PartnersRepository {
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Partner>> build() {
    return _firestore
        .collection('partners')
        .orderBy('type')
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Partner.fromJson({
          'id': doc.id,
          ...doc.data(),
        });
      }).toList();
    });
  }
}