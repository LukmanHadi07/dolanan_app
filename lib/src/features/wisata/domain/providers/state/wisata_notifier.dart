// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dulinan/src/features/wisata/domain/providers/state/wisata_state.dart';
import 'package:dulinan/src/features/wisata/domain/repositories/wisata_repository.dart';

class WisataNotifier extends StateNotifier<WisataState> {
  final WisataRepository wisataRepository;

  WisataNotifier({
    required this.wisataRepository,
  }) : super(const WisataState.initial());

  Future<void> fetchWisata() async {
    state = const WisataState.loading();
    final resp = await wisataRepository.getWisata();
    state = await resp.fold((failure) => WisataState.error(failure), (wisata) {
      return WisataState.success(wisata);
    });
  }
}
