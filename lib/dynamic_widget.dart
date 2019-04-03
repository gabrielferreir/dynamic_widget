library dynamic_widget;


import 'package:dynamic_widget/dynamic_widget/basic/align_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/aspectratio_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/baseline_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/button_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/center_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/container_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/expanded_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/fittedbox_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/image_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/indexedstack_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/opacity_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/padding_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/placeholder_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/row_column_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/sizedbox_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/stack_positioned_widgets_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/text_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/wrap_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/scrolling/gridview_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/scrolling/listview_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/scrolling/pageview_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:logging/logging.dart';

class DynamicWidgetBuilder{

  static final Logger log = Logger('DynamicWidget');

  static final parsers = [
    ContainerWidgetParser(),
    TextWidgetParser(),
    RaisedButtonParser(),
    RowWidgetParser(),
    ColumnWidgetParser(),
    AssetImageWidgetParser(),
    NetworkImageWidgetParser(),
    FileImageWidgetParser(),
    PlaceholderWidgetParser(),
    GridViewWidgetParser(),
    ListViewWidgetParser(),
    PageViewWidgetParser(),
    ExpandedWidgetParser(),
    PaddingWidgetParser(),
    CenterWidgetParser(),
    AlignWidgetParser(),
    AspectRatioWidgetParser(),
    FittedBoxWidgetParser(),
    BaselineWidgetParser(),
    StackWidgetParser(),
    PositionedWidgetParser(),
    IndexedStackWidgetParser(),
    ExpandedSizedBoxWidgetParser(),
    SizedBoxWidgetParser(),
    OpacityWidgetParser(),
    WrapWidgetParser()
  ];



  Widget build(String json, ClickListener listener){
    var map = jsonDecode(json);
    ClickListener _listener = listener == null? new NonResponseWidgetClickListener(): listener;
    var widget = buildFromMap(map, _listener);
    return widget;
  }

  static Widget buildFromMap(Map<String, dynamic> map, ClickListener listener){
    String widgetName = map['type'];

    for (var parser in parsers) {
      if (parser.forWidget(widgetName)) {
        return parser.parse(map, listener);
      }
    }

    log.warning("Not support type: $widgetName");
    return null;
  }

  static List<Widget> buildWidgets(List<dynamic> values, ClickListener listener){
    List<Widget> rt = [];
    for (var value in values) {
      rt.add(buildFromMap(value, listener));
    }
    return rt;
  }
}


/// extends this class to make a Flutter widget parser.
abstract class WidgetParser{

  /// parse the json map into a flutter widget.
  Widget parse(Map<String, dynamic> map, ClickListener listener);

  /// check the matched widget type. for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method as "Text" == widgetName, for more details, please see
  /// @TextWidgetParser
  bool forWidget(String widgetName);
}

abstract class ClickListener{

  void onClicked(String event);
}

class NonResponseWidgetClickListener implements ClickListener{

  static final Logger log = Logger('NonResponseWidgetClickListener');

  @override
  void onClicked(String event) {
    log.info("receiver click event: " + event);
    print("receiver click event: " + event);
  }

}
