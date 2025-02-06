import 'package:dulinan/src/features/wisata/data/models/wisata_response.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'wisata_state.freezed.dart';

@freezed
class WisataState with _$WisataState {
  const factory WisataState.initial() = _Initial;
  const factory WisataState.loading() = _Loading;
  const factory WisataState.success(WisataResponse wisata) = _Success;
  const factory WisataState.error(AppExceptions exception) = _Error;
}
