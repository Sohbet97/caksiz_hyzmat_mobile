import 'package:mobile/features/category/models/category_model.dart';

// language: 0 = tm, 1 = ru, 2 = en
extension CategoryLocalizationExtension on CategoryModel {
  String localizedName(int language) {
    switch (language) {
      case 1:
        return nameRu != null && nameRu!.isNotEmpty ? nameRu! : nameTm;
      case 2:
        return nameEn != null && nameEn!.isNotEmpty ? nameEn! : nameTm;
      default:
        return nameTm;
    }
  }
}
