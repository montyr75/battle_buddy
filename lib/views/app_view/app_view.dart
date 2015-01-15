library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import 'package:polymer_expressions/filter.dart';
import '../../utils/filters.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  // initialize system log
  bool _logInitialized = initLog();

  @observable String bindingTest = "Binding is working...";

  final List<int> rollers = const [
      4,
      6,
      8,
      10,
      12,
      20,
      100
  ];

  // filters and transformers can be referenced as class fields
  final Transformer asInteger = new StringToInt();

  // non-visual initialization can be done here
  AppView.created() : super.created();

  // life-cycle method called by the Polymer framework when the element is attached to the DOM
  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
  }

  void eventHandler(Event event, var detail, Element target) {
    log.info("$runtimeType::eventHandler()");

    asyncFire('core-signal', detail: {'name': 'output', 'data': 'Foo!'});
  }

  void submit(Event event, var detail, Element target) {
    // prevent app reload on <form> submission
    event.preventDefault();
  }
}

