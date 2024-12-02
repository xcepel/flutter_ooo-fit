import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';

final get = GetIt.instance;

class IocContainer {
  static void setup() {
    // Register all DatabaseServices
    get.registerSingleton(
      DatabaseService<Style>('styles',
          fromJson: Style.fromJson, toJson: (style) => style.toJson()),
    );
    get.registerSingleton(
      DatabaseService<Piece>('pieces',
          fromJson: Piece.fromJson, toJson: (piece) => piece.toJson()),
    );
    get.registerSingleton(
      DatabaseService<Outfit>('outfits',
          fromJson: Outfit.fromJson, toJson: (outfit) => outfit.toJson()),
    );
    get.registerSingleton(
      DatabaseService<Event>('events',
          fromJson: Event.fromJson, toJson: (event) => event.toJson()),
    );

    get.registerSingleton(StyleService(get<DatabaseService<Style>>()));

    get.registerSingleton(
        PieceService(get<DatabaseService<Piece>>(), get<StyleService>()));

    get.registerSingleton(OutfitService(get<DatabaseService<Outfit>>(),
        get<StyleService>(), get<PieceService>()));

    get.registerSingleton(EventService(get<DatabaseService<Event>>(),
        get<StyleService>(), get<OutfitService>()));
  }
}
