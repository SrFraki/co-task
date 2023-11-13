// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_and_uids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TasksAndUidsImpl _$$TasksAndUidsImplFromJson(Map<String, dynamic> json) =>
    _$TasksAndUidsImpl(
      tasks:
          (json['tasks'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      uids: (json['groups_uids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TasksAndUidsImplToJson(_$TasksAndUidsImpl instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
      'groups_uids': instance.uids,
    };
