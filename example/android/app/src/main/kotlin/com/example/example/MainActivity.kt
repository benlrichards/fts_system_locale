package com.example.example

import android.content.ActivityNotFoundException
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Locale.setDefault(Locale.US)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.example").setMethodCallHandler { call, result ->
            when(call.method){
                "navigateToActivity" -> {
                    val intent = Intent(this, SecondActivity::class.java)
                    try {
                        startActivity(intent)
                        result.success("Activity started")
                    }  catch (e:ActivityNotFoundException){
                        result.error("Activty not found", e.message, null)
                    }

                }
                else -> result.notImplemented()
            }
        }
    }
}
