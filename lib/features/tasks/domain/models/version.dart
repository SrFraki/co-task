import 'package:freezed_annotation/freezed_annotation.dart';

part 'version.freezed.dart';
part 'version.g.dart';

@unfreezed
class Version with _$Version {
  factory Version({
    @JsonKey(name: 'version') @Default('') String version,
    @JsonKey(name: 'link') @Default('') String link
  }) = _Version;

  factory Version.fromJson(Map<String, dynamic> json) => _$VersionFromJson(json);
}
