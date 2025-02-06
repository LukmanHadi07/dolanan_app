import 'package:dulinan/src/features/wisata/data/datasources/wisata_remote_data_source.dart';
import 'package:dulinan/src/features/wisata/data/repositories/wisata_repository_impl.dart';
import 'package:dulinan/src/features/wisata/domain/providers/state/wisata_notifier.dart';
import 'package:dulinan/src/features/wisata/domain/providers/state/wisata_state.dart';
import 'package:dulinan/src/features/wisata/domain/repositories/wisata_repository.dart';
import 'package:dulinan/src/shared/data/remote/network_service.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wisataRemoteDataSourceProvider =
    Provider.family<WisataDataSource, NetworkService>((ref, networkService) =>
        WisataRemoteDataSource(networkService: networkService));

final wisataRepositoryProvider = Provider<WisataRepository>((ref) {
  final NetworkService networkService = ref.watch(networkServiceProvider);
  final WisataDataSource wisataDataSource =
      ref.watch(wisataRemoteDataSourceProvider(networkService));
  return WisataRepositoryImpl(wisataDataSource: wisataDataSource);
});

final wisataStateNotifierProvider =
    StateNotifierProvider<WisataNotifier, WisataState>((ref) {
  final WisataRepository wisataRepository = ref.watch(wisataRepositoryProvider);
  return WisataNotifier(wisataRepository: wisataRepository);
});
