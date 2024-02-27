// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      user: json['user'] as int? ?? -1,
      task: json['task'] as String? ?? '',
      finalized: json['finalized'] as bool? ?? false,
      accumulatedWeeks: json['accumulatedWeeks'] as int? ?? 0,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'task': instance.task,
      'finalized': instance.finalized,
      'accumulatedWeeks': instance.accumulatedWeeks,
    };
