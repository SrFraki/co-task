import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'index_provider.g.dart';

@Riverpod(keepAlive: true)
class IndexP extends _$IndexP{
  @override
  int build() => 0;
  void update(int value) => state = value;
}