package com.quichesoft.simplesms;

import android.content.Intent;
import android.net.Uri;

import java.util.HashMap;
import java.util.List;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * SimpleSmsPlugin
 */
public class SimpleSmsPlugin implements MethodCallHandler {

    private static final String SEND_SMS = "sendSms";
    private static final String METHOD_CHANNEL = "plugins.quichesoft.com/simpleSms";

    private final Registrar registrar;

    private SimpleSmsPlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), METHOD_CHANNEL);
        channel.setMethodCallHandler(new SimpleSmsPlugin(registrar));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals(SEND_SMS)) {
            HashMap<String, Object> arguments = (HashMap<String, Object>) call.arguments;
            sendSms((List<String>) arguments.get("addresses"), (String) arguments.get("message"));
        } else {
            result.notImplemented();
        }
    }

    private void sendSms(List<String> addresses, String message) {
        StringBuilder uri = new StringBuilder("sms:");
        for (String address : addresses) {
            uri.append(address);
            uri.append(", ");
        }

        Intent smsIntent = new Intent(Intent.ACTION_SENDTO);
        smsIntent.setType("vnd.android-dir/mms-sms");
        smsIntent.setData(Uri.parse(uri.toString()));
        smsIntent.putExtra("sms_body", message);
        registrar.activity().startActivity(smsIntent);
    }
}
