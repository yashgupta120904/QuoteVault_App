package com.example.quotevault

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class HomeWidgetExampleProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            // Ensure R.layout.widget_layout matches your filename in res/layout
            val views = RemoteViews(context.packageName, R.layout.home_widget).apply {
                // Get data saved from Flutter
                val quote = widgetData.getString("daily_quote", "Stay inspired! 💪")
                val author = widgetData.getString("quote_author", "QuoteVault")
                
                // Map to the IDs in your XML
                setTextViewText(R.id.quoteText, quote)
                setTextViewText(R.id.authorText, "- $author")
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
