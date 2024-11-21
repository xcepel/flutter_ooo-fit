import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/temperature.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Event {
  final String id;
  final DateTime? createdAt;
  final DateTime eventDatetime;
  final String name;
  // outfit can be added later, after event creation?
  final String? outfitId;
  // temperature can be fetched later if event is too far in the future?
  final List<String> styleIds;
  final Temperature temperature;
  final String userId;

  const Event(
      {required this.id,
      this.createdAt,
      required this.name,
      required this.eventDatetime,
      required this.outfitId,
      required this.styleIds,
      required this.temperature,
      required this.userId});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
