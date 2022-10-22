package com.fts_system_locale

import android.app.Application
import android.app.LocaleManager
import android.content.Context
import android.os.Build
import android.os.LocaleList
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.getSystemService
import androidx.core.os.LocaleListCompat
import com.yariksoffice.lingver.Lingver

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*
import javax.xml.transform.OutputKeys.VERSION

/** FtsSystemLocalePlugin */
class FtsSystemLocalePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var application: Application

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        application = flutterPluginBinding.applicationContext as Application
        Locale.setDefault(Locale("en"))
        Lingver.init(application, Locale.getDefault())
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fts_system_locale")
        channel.setMethodCallHandler(this)
    }

    private fun setAppLocale(locale: String?) {
        if (locale == null) {
            Lingver.getInstance().setFollowSystemLocale(application)
            if (Build.VERSION.SDK_INT >= 33) {
                val localeList = LocaleList(Locale.getDefault())
                val localeManager = getSystemService(application, LocaleManager::class.java)
                localeManager?.applicationLocales = localeList
                Log.d("Locale", "Locale set to ${Locale.getDefault()} for Android 13+")
            }
        } else {
            Lingver.getInstance().setLocale(application, locale)
            if (Build.VERSION.SDK_INT >= 33) {
                val localeList = LocaleList(Locale(locale))
                val localeManager = getSystemService(application, LocaleManager::class.java)
                localeManager?.applicationLocales = localeList
                Log.d("Locale", "Locale set to $locale for Android 13+")

            }
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "setLocale" -> {
                val locale = call.argument<String>("locale")
                setAppLocale(locale)
                result.success("Locale set to $locale")
            }
            else -> result.notImplemented()
        }

    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
