library output_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';

@CustomTag('output-view')
class Output_view extends PolymerElement {

  @observable List<String> messages = toObservable([]);

  Output_view.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
  }

  void clear(Event e, var detail, Element target) {
    messages.clear();
  }

  void addMsg(Event e, String msg, Element target) {
    messages.add(msg);
  }

  // a sample event handler function
  void eventHandler(Event event, var detail, Element target) {
    log.info("$runtimeType::eventHandler()");
  }
}