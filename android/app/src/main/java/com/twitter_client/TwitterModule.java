package com.twitter_client;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.twitter.sdk.android.core.Callback;
import com.twitter.sdk.android.core.Result;
import com.twitter.sdk.android.core.TwitterException;
import com.twitter.sdk.android.core.TwitterSession;
import com.twitter.sdk.android.core.identity.TwitterAuthClient;

public class TwitterModule extends ReactContextBaseJavaModule implements ActivityEventListener {
    private TwitterAuthClient authClient;

    public TwitterModule(ReactApplicationContext reactContext) {
        super(reactContext);
        authClient = new TwitterAuthClient();
        reactContext.addActivityEventListener(this);
    }

    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
        authClient.onActivityResult(requestCode, resultCode, data);
    }

    @Override
    public void onNewIntent(Intent intent) {

    }

    @Override
    public String getName() {
        return "TwitterModule";
    }

    @ReactMethod
    public void auth(final Promise promise) {
        if (getCurrentActivity() != null) {
            authClient.authorize(getCurrentActivity(), new Callback<TwitterSession>() {
                @Override
                public void success(Result<TwitterSession> result) {
                    WritableMap map = Arguments.createMap();
                    map.putDouble("id", result.data.getUserId());
                    map.putString("name", result.data.getUserName());
                    promise.resolve(map);
                }

                @Override
                public void failure(TwitterException exception) {
                    promise.reject(exception);
                }
            });
        }
    }

}
