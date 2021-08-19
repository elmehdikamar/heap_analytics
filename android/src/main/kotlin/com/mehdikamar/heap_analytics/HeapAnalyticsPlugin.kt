package com.mehdikamar.heap_analytics

import android.content.Context
import androidx.annotation.NonNull
import com.heapanalytics.android.Heap

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** HeapAnalyticsPlugin */
class HeapAnalyticsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "heap_analytics")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "initHeap" -> initHeap(call.argument("appId"), result)
            "track" -> track(call.argument("event"), call.argument("properties"), result)
            "identify" -> identify(call.argument("id"), result)
            "addUserProperties" -> addUserProperties(call.argument("properties"), result)
            "resetIdentity" -> resetIdentity()
            else -> result.notImplemented()
        }
    }

    private fun initHeap(appId: String?, result: Result) {
        if (appId != null) {
            Heap.init(context, appId)
        } else result.error("BAD_ARGS", "No appId provided", null)
    }

    private fun track(eventName: String?, properties: HashMap<String, String>?, result: Result) {
        if (eventName != null && properties != null) {
            Heap.track(eventName, properties)
        } else result.error("BAD_ARGS", "No event name provided", null)

    }

    private fun identify(id: String?, result: Result) {
        if (id != null) {
            Heap.identify(id)
        } else result.error("BAD_ARGS", "No identity provided", null)
    }

    private fun addUserProperties(properties: HashMap<String, String>?, result: Result) {
        if (properties != null) {
            Heap.addUserProperties(properties)
        } else result.error("BAD_ARGS", "No properties provided", null)
    }

    private fun resetIdentity() {
        Heap.resetIdentity()
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
