// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DbDataImpl _$$DbDataImplFromJson(Map<String, dynamic> json) => _$DbDataImpl(
      tasks: (json['tasks'] as List<dynamic>?)
              ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      names: (json['names'] as List<dynamic>?)
              ?.map((e) => Name.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      changeDay: json['changeDay'] as int? ?? 0,
    );

Map<String, dynamic> _$$DbDataImplToJson(_$DbDataImpl instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
      'names': instance.names,
      'changeDay': instance.changeDay,
    };

_$NameImpl _$$NameImplFromJson(Map<String, dynamic> json) => _$NameImpl(
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$$NameImplToJson(_$NameImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'token': instance.token,
    };
