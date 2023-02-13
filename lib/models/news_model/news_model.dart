import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  int? id;
  String? title;
  String? description;
  String? image;
  DateTime? dtPublishing;
  DateTime? dtUpdating;

  NewsModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.dtPublishing,
    this.dtUpdating,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  @override
  String toString() {
    return '{"id": $id, "title": "$title", "description": "$description", "image": "$image", "dtPublishing": "${dtPublishing ?? ""}", "dtUpdating": "${dtUpdating ?? ""}"}';
  }
}
