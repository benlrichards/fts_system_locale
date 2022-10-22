package com.fts_system_locale

import android.app.Application
import androidx.annotation.NonNull
import com.yariksoffice.lingver.Lingver

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

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
        Lingver.init(application, Locale.getDefault())
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fts_system_locale")
        channel.setMethodCallHandler(this)
    }

    private fun setAppLocale(locale: String?) {
        if (locale == null) {
            Lingver.getInstance().setFollowSystemLocale(application)
        } else {
            Lingver.getInstance().setLocale(application, locale)
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
