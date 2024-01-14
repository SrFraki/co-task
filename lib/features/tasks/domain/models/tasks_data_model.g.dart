// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TasksDataImpl _$$TasksDataImplFromJson(Map<String, dynamic> json) =>
    _$TasksDataImpl(
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      areCompleted: (json['areComplted'] as List<dynamic>)
          .map((e) => e as List<dynamic>)
          .toList(),
      namesAndUids: (json['names_and_uid'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$TasksDataImplToJson(_$TasksDataImpl instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
      'areComplted': instance.areCompleted,
      'names_and_uid': instance.namesAndUids,
    };
