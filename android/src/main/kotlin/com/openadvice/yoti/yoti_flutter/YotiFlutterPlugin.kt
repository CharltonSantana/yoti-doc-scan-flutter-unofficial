package com.openadvice.yoti.yoti_flutter

import androidx.annotation.NonNull

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import com.yoti.mobile.android.yotisdkcore.YotiSdk;
import io.flutter.plugin.common.PluginRegistry

/** YotiFlutterPlugin */
class YotiFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  
  private lateinit var channel : MethodChannel

  private lateinit var context: Context
  private lateinit var activity: Activity
  private var activityBinding: ActivityPluginBinding? = null

  private lateinit var yotiSdk: YotiSdk

   private var result: MethodChannel.Result? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "yoti_flutter")
    channel.setMethodCallHandler(this)
    yotiSdk = YotiSdk(context)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "startYoti") {
      this.result = result

      yotiSdk
          .setSessionId("5344dec4-eb33-4cb3-b8ee-d12fd768ad3f")
          .setClientSessionToken("d0226374-4ab5-459e-a574-1f4694eb3560")
              .start(activity)

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(activityBinding: ActivityPluginBinding) {
    this.activity = activityBinding.activity
    activityBinding.addActivityResultListener(this);
  }

  override fun onDetachedFromActivity() {
    this.activityBinding?.removeActivityResultListener(this)
    this.activityBinding = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
      TODO("Not yet implemented")
  }

  override fun onDetachedFromActivityForConfigChanges() {
      TODO("Not yet implemented")
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
      if(requestCode == 9001) {
        val sessionStatusCode = yotiSdk.sessionStatusCode
        val sessionStatusDescription = yotiSdk.sessionStatusDescription


        if(sessionStatusCode == 0) {
          result?.success(sessionStatusCode);
        } else {
          result?.error(sessionStatusCode.toString(), sessionStatusDescription, null)
        }

      }
    
     return true;
  }
}
