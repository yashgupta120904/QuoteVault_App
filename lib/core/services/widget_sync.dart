

import 'package:home_widget/home_widget.dart';

import '../../features/quotes/data/models/quote_model.dart';


class WidgetSyncService {
  static Future<void> syncQuoteOfDay(Quote quote) async {
    await HomeWidget.saveWidgetData('daily_quote', quote.text);
    await HomeWidget.saveWidgetData(
        'quote_author', quote.author ?? 'Unknown');


    // Daily gradient index
    final day = DateTime.now().day % 2;
    await HomeWidget.saveWidgetData('bg_index', day);

          await HomeWidget.updateWidget(
        name: 'HomeWidgetExampleProvider',
        androidName: 'HomeWidgetExampleProvider',
      );
  }
}

