

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class OpacityWidgetParser extends WidgetParser{
  @override
  bool forWidget(String widgetName) {
    return "Opacity" == widgetName;
  }

  @override
  Widget parse(Map<String, dynamic> map, ClickListener listener) {
    return Opacity(
      opacity: map["opacity"],
      alwaysIncludeSemantics: map.containsKey("alwaysIncludeSemantics")? map["alwaysIncludeSemantics"] : false,
      child: DynamicWidgetBuilder.buildFromMap(map["child"], listener),
    );
  }
}