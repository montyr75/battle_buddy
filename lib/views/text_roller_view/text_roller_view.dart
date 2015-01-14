library text_roller_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import '../../model/roller.dart';

@CustomTag('text-roller-view')
class TextRollerView extends PolymerElement {

  @observable String formula = "";

  TextRollerView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
  }

  void roll([Event e, var detail, Element target]) {
    asyncFire('core-signal', detail: {'name': 'output', 'data': Roller.rollFromFormula(formula)});
  }

  void clear() {
    formula = "";
  }

  void keySubmit(KeyboardEvent event, var detail, Element target) {
    if (event.keyCode == KeyCode.ENTER && formula.isNotEmpty) {
      roll();
    }
  }
  String get imagesPath => IMAGES_PATH;
}