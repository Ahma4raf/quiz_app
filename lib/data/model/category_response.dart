import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app/data/model/category_model.dart';
part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: "trivia_categories")
  final List<CategoryModel> categories;
  CategoryResponse(this.categories);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
