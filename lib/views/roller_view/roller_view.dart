library roller_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/filter.dart';
import '../../utils/filters.dart';
import '../../model/global.dart';
import '../../model/roller.dart';

@CustomTag('roller-view')
class RollerView extends PolymerElement {

  static const String DIE_IMAGE_PATH = "${IMAGES_PATH}dice/red/";

  @published int sides;
  @observable String dieImagePath;      // path to individual die image (resolved in attached())

  // UI bindings
  int qty;
  int mod;
  int rep = 1;       // how many times should the formula be rolled?

  // filters and transformers can be referenced as fields
  final Transformer asInteger = new StringToInt();

  RollerView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached() -- ${sides}-sided die");

    // if "sides" is provided as an attribute, it should be available at this point
    dieImagePath = "${DIE_IMAGE_PATH}d${sides}.png";

    clear();
  }

  void roll([Event event, var detail, Element target]) {
    // massage the numbers coming in from the UI
    qty = qty == null || qty < 1 ? 1 : qty;
    sides = sides == null || sides < 2 ? 2 : sides;
    mod = mod == null ? 0 : mod;
    rep = rep == null || rep < 1 ? 1 : rep;

    // fire "output" events for each roll
    for (int i = 0; i < rep; i++) {
      asyncFire('core-signal', detail: {'name': 'output', 'data': Roller.roll(qty, sides, mod)});
    }
  }

  void clear() {
    qty = null;
    mod = null;
    rep = 1;
  }

  void keySubmit(KeyboardEvent event, var detail, Element target) {
    if (event.keyCode == KeyCode.ENTER) {
      roll();
    }
  }
}