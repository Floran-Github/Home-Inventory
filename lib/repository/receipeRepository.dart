import 'package:home_inventory/model/receipe/receipeListModel.dart';
import 'package:home_inventory/services/recipeAPIService.dart';

class ReceipeRepository {
  final RecipeAPI _services = RecipeAPI();

  // getting list of food

  Future<List<ReceipeModel>> getReceipes() async {
    final response = await _services.recipeList();

    return response;
  }
}
