package com.quanticheart.test_flutter_plugin

import android.content.Context.BATTERY_SERVICE
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.os.BatteryManager
import kotlin.streams.toList

/** TestFlutterPlugin */
class TestFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  private var appUsageApi = AppUsageApi()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "test_flutter_plugin")
    channel.setMethodCallHandler(this)
    this.flutterPluginBinding = flutterPluginBinding
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "getBatteryLevel" -> result.success(getBTLevel())
      "getUsedApps" -> result.success(appUsageApi.usedApps.stream().map { it.toJson() }.toList())
      "setAppTimeLimit" -> {
        if (!call.hasArgument("id") || !call.hasArgument("durationInMinutes")) {
          result.error(
            "BAD_REQUEST",
            "Missing 'id' or 'durationInMinutes' argument",
            Exception("Something went wrong")
          )
        }
        result.success(
          appUsageApi.setTimeLimit(
            call.argument<String>("id")!!,
            call.argument<Int>("durationInMinutes")!!
          )
        )
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun getBTLevel(): Double {
    // Call battery manager service
    val bm = flutterPluginBinding.applicationContext.getSystemService(BATTERY_SERVICE) as BatteryManager
    // Get the battery percentage and store it in a INT variable
    return bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY).toDouble()
  }
}