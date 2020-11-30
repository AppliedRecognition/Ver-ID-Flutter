package com.appliedrec.veridflutterplugin;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry;

//################## LEGACY IMPORTS
import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.util.Base64;
import android.util.Base64InputStream;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

import com.appliedrec.verid.core.AuthenticationSessionSettings;
import com.appliedrec.verid.core.Face;
import com.appliedrec.verid.core.FaceDetectionRecognitionFactory;
import com.appliedrec.verid.core.LivenessDetectionSessionSettings;
import com.appliedrec.verid.core.RecognizableFace;
import com.appliedrec.verid.core.RegistrationSessionSettings;
import com.appliedrec.verid.core.VerID;
import com.appliedrec.verid.core.VerIDFactory;
import com.appliedrec.verid.core.VerIDFactoryDelegate;
import com.appliedrec.verid.core.VerIDImage;
import com.appliedrec.verid.core.VerIDSessionResult;
import com.appliedrec.verid.ui.VerIDSessionActivity;
import com.appliedrec.verid.ui.VerIDSessionIntent;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

//import org.apache.cordova.CallbackContext;
//import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayInputStream;

//required for visibility into activity lifecycle event subscriptions
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

//required for name of package
import io.flutter.plugin.common.BinaryMessenger;

//logging
import android.util.Log;

//##################

/** VeridflutterpluginPlugin */
public class VeridflutterpluginPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  public static String TAG = VeridflutterpluginPlugin.class.getSimpleName();

  private Result mResult = null;

  //################### Base CODE
  protected static final int REQUEST_CODE_REGISTER = 1;
  protected static final int REQUEST_CODE_AUTHENTICATE = 2;
  protected static final int REQUEST_CODE_DETECT_LIVENESS = 3;
  protected static boolean TESTING_MODE = false;

  protected VerID verID;
  //######### START LIFECYCLE METHODS
  private Activity activeUIActivityRef = null;

  /*
  final MethodChannel channel;
  final Activity activity;

  public VeridflutterpluginPlugin(MethodChannel channel, Activity activity) {
    this.channel = channel;
    this.activity = activity;
  }

   */

  //########## used to get base app name
  private Context applicationContext;
  private String baseImportPackageName;

  public void onAttachedToActivity(ActivityPluginBinding binding) {
    //TODO - test with unit tests
    //save reference to activity for use in load
    this.activeUIActivityRef = binding.getActivity();
  }

  public void onDetachedFromActivityForConfigChanges() {
    //TODO - test with unit tests
    this.activeUIActivityRef = null;
  }

  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    //TODO - test with unit tests
    this.activeUIActivityRef = binding.getActivity();
  }

  public void onDetachedFromActivity() {
    //TODO - test with unit tests
    this.activeUIActivityRef = null;
  }

  //######### END LIFECYCLE METHODS
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;



  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "veridflutterplugin");
    channel.setMethodCallHandler(this);
    onAttachedToEngine(flutterPluginBinding.getApplicationContext());
  }

  private void onAttachedToEngine(Context applicationContext) {
    this.applicationContext = applicationContext;
    this.baseImportPackageName = applicationContext.getPackageName();
  }
  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "veridflutterplugin");
    channel.setMethodCallHandler(new VeridflutterpluginPlugin());
  }

  private JSONArray getLegacyArgs(MethodCall call) {
    String password = call.arguments == null ? null : (String) call.argument("password");
    String settings = call.arguments == null ? null : (String) call.argument("settings");
    String userID = call.arguments == null ? null : (String) call.argument("userId");
    String face1 = call.arguments == null ? null : (String) call.argument("face1");
    String face2 = call.arguments == null ? null : (String) call.argument("face2");
    String image = call.arguments == null ? null : (String) call.argument("image");
    JSONArray args = null;
    try {
      args = new JSONArray("[]");
      if (null != password) {
        JSONObject passObj = new JSONObject("{}");
        passObj.put("password", password);
        args.put(passObj);
      }
      if (null != settings) {
        JSONObject passObj = new JSONObject("{}");
        passObj.put("settings", settings);
        args.put(passObj);
      }
      if (null != userID) {
        JSONObject passObj = new JSONObject("{}");
        passObj.put("userId", userID);
        args.put(passObj);
      }
      if (null != face1) {
        JSONObject passObj = new JSONObject("{}");
        passObj.put("face1", face1);
        args.put(passObj);
      }
      if (null != face2) {
        JSONObject passObj = new JSONObject("{}");
        passObj.put("face2", face2);
        args.put(passObj);
      }
      if (null != image) {
        JSONObject passObj = new JSONObject("{}");
        passObj.put("image", image);
        args.put(passObj);
      }
    } catch (JSONException ex) {
      Log.d(TAG, "Error creating JSON structure" + call.toString());
    }
    return  args;
  }

  @Override
  public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
    final Activity activity = this.activeUIActivityRef;
    final JSONArray args = getLegacyArgs(call);
    if (call.method.equals("setTestingMode")) {
      if (call.argument("testingMode")) {
        try {
          boolean testingMode = call.argument("testingMode");
          TESTING_MODE = testingMode;
          result.success("");
        } catch (final Exception e) {
          e.printStackTrace();
          result.error("1", "Not valid argument provided", null);
        }

      } else {
        result.error("1", "Not valid argument provided", null);
      }
    } else if(call.method.equals("load")) {
      try {
        //currently, we only use password as a parameter
        loadVerIDAndRun(args, result, new Runnable() {
          @Override
          public void run() {
            result.success("{ msg: \"OK\" }");
          }
        });
      } catch (Exception ex) {
        Log.d(TAG, ex.getMessage());
      }
    } else if(call.method.equals("unload")) {
      verID = null;
      result.success("");
    } else if(call.method.equals("registerUser")) {
      RegistrationSessionSettings tempSettings = null;
      String jsonSettings = call.argument("settings");
      if (TESTING_MODE) {
        result.success(ATTACHMENT_MOCK);
      } else {
        try {
          if (jsonSettings != null) {
            Gson gson = new Gson();
            tempSettings = gson.fromJson(jsonSettings, RegistrationSessionSettings.class);
          } else {
            result.error("cannotParseRegistrationSession", "Cannot parge registration session.", null);
          }
          final RegistrationSessionSettings settings = tempSettings;
          loadVerIDAndStartActivity(args, result, new IntentFactory() {
            @Override
            public Intent createIntent() {
              return new VerIDSessionIntent<>(activity, verID, settings);
            }
          }, REQUEST_CODE_REGISTER);
        } catch (Exception ex) {
          Log.d(TAG, ex.getMessage());
        }
      }
    } else if (call.method.equals("authenticate")) {
      String jsonSettings = getArg(args, "x", String.class);
      AuthenticationSessionSettings tempSettings  = null;
      if (TESTING_MODE) {
        result.success(ATTACHMENT_MOCK);
      } else {
        if (jsonSettings != null) {
          Gson gson = new Gson();
          tempSettings = gson.fromJson(jsonSettings, AuthenticationSessionSettings.class);
        } else {
          result.error("authenticationCannotParseSettings","Unable to parse session settings", null);
        }
        final AuthenticationSessionSettings settings = tempSettings;
        loadVerIDAndStartActivity(args, result, new IntentFactory() {
          @Override
          public Intent createIntent() {
            return new VerIDSessionIntent<>(activity, verID, settings);
          }
        }, REQUEST_CODE_AUTHENTICATE);
      }
    } else if(call.method.equals("captureLiveFace")) {
      String jsonSettings = getArg(args, "settings", String.class);
      LivenessDetectionSessionSettings tempSettings = null;
      if (TESTING_MODE) {
        result.success(ATTACHMENT_MOCK);
      } else  {
        if (jsonSettings != null) {
          Gson gson = new Gson();
          tempSettings = gson.fromJson(jsonSettings, LivenessDetectionSessionSettings.class);
        } else {
          result.error("captureLiveFaceError","Unable to parse session settings", null);
        }
        final LivenessDetectionSessionSettings settings = tempSettings;
        loadVerIDAndStartActivity(args, result, new IntentFactory() {
          @Override
          public Intent createIntent() {
            return new VerIDSessionIntent<>(activity, verID, settings);
          }
        }, REQUEST_CODE_DETECT_LIVENESS);
      }
    } else if(call.method.equals("getRegisteredUsers")) {
      loadVerIDAndRun(args, result, new Runnable() {
        @Override
        public void run() {
          try {
            String[] users = verID.getUserManagement().getUsers();
            Gson gson = new Gson();
            String usersFound = "";
            if (TESTING_MODE) {
              usersFound = "[\"user1\", \"user2\", \"user3\"]";
            } else {
              usersFound = gson.toJson(users, String[].class);
            }
            final String jsonUsers = usersFound;
            result.success(jsonUsers);
          } catch (final Exception e) {
            e.printStackTrace();
            result.error("errorLoadingRegisteredUsers", e.getLocalizedMessage(), null);
          }
        }
      });
    } else if (call.method.equals("deleteUser")) {
      final String userId = getArg(args, "userId", String.class);
      if (userId != null) {
        loadVerIDAndRun(args, result, new Runnable() {
          @Override
          public void run() {
            try {
              verID.getUserManagement().deleteUsers(new String[]{userId});
              result.success("");
            } catch (final Exception e) {
              e.printStackTrace();
              result.error("deleteUserError", e.getLocalizedMessage(), null);
            }
          }
        });
      } else {
        result.error("deleteUserError", "User id must not be null", null);
      }
    } else if (call.method.equals("compareFaces")) {
      final String t1 = getArg(args, "face1", String.class);
      final String t2 = getArg(args, "face2", String.class);
      loadVerIDAndRun(args, result, new Runnable() {
        @Override
        public void run() {
          try {
            Gson gson = new Gson();
            RecognizableFace face1 = gson.fromJson(t1, RecognizableFace.class);
            RecognizableFace face2 = gson.fromJson(t2, RecognizableFace.class);
            final float score = verID.getFaceRecognition().compareSubjectFacesToFaces(new RecognizableFace[]{face1}, new RecognizableFace[]{face2});
            final JsonObject response = new JsonObject();
            response.addProperty("score", score);
            response.addProperty("authenticationThreshold", verID.getFaceRecognition().getAuthenticationThreshold());
            response.addProperty("max", verID.getFaceRecognition().getMaxAuthenticationScore());
            final String jsonResponse = gson.toJson(response);
            result.success(jsonResponse);
          } catch (final Exception e) {
            e.printStackTrace();
            result.error("compareFacesError", e.getLocalizedMessage(), null);
          }
        }
      });
    } else if (call.method.equals("detectFaceInImage")) {
      final String image = getArg(args, "image", String.class);
      loadVerIDAndRun(args, result, new Runnable() {
        @Override
        public void run() {
          try {
            if (image == null) {
              throw new Exception("Image argument is null");
            }
            if (!image.startsWith("data:image/")) {
              throw new Exception("Invalid image argument");
            }
            int dataIndex = image.indexOf("base64,");
            if (dataIndex == -1) {
              throw new Exception("Invalid image argument");
            }
            dataIndex += 7;
            if (dataIndex >= image.length()) {
              throw new Exception("Invalid image length");
            }
            ByteArrayInputStream inputStream = new ByteArrayInputStream(image.substring(dataIndex).getBytes("UTF-8"));
            Base64InputStream base64InputStream = new Base64InputStream(inputStream, Base64.NO_WRAP);
            Bitmap bitmap = BitmapFactory.decodeStream(base64InputStream);
            if (bitmap == null) {
              throw new Exception("Bitmap decoding error");
            }
            VerIDImage verIDImage = new VerIDImage(bitmap);
            Face[] faces = verID.getFaceDetection().detectFacesInImage(verIDImage, 1, 0);
            if (faces.length == 0) {
              throw new Exception("Face not found");
            }
            RecognizableFace[] recognizableFaces = verID.getFaceRecognition().createRecognizableFacesFromFaces(faces, verIDImage);
            Gson gson = new Gson();
            final String encodedFace = gson.toJson(recognizableFaces[0]);
            result.success(encodedFace);
          } catch (final Exception e) {
            result.error("faceEncodingProblem", e.getLocalizedMessage(), null);
          }
        }
      });
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    applicationContext = null;
    channel = null;
  }



  //####################BASE CODE FOR MODS


  @Override
  public boolean onActivityResult(int requestCode, final int resultCode, final Intent intent) {
    synchronized (this) {
      if (mResult != null && (requestCode == REQUEST_CODE_REGISTER || requestCode == REQUEST_CODE_AUTHENTICATE || requestCode == REQUEST_CODE_DETECT_LIVENESS)) {
        VerIDSessionResult result;
        Gson gson = new Gson();
        if (resultCode == Activity.RESULT_OK && intent != null) {
          result = intent.getParcelableExtra(VerIDSessionActivity.EXTRA_RESULT);
        } else if (resultCode == Activity.RESULT_CANCELED) {
          result = null;
        } else {
          result = new VerIDSessionResult(new Exception("Unknown failure"));
        }
        final String response = gson.toJson(result, VerIDSessionResult.class);

        if (mResult == null) {
          return false;
        }
        final Activity activity = this.activeUIActivityRef;
        if (activity == null) {
          mResult.error("onActivityResultError", "Flutter activity is null", null);
          return false;
        }
        if (activity.isDestroyed()) {
          mResult.error("onActivityResultError", "Activity is destroyed", null);
          return false;
        }
        mResult.success(response);
        mResult = null;
        return true;
      }
    }
    return false;
  }

  /*
  @Override
  public void onRestoreStateForActivityResult(Bundle state, CallbackContext callbackContext) {
    super.onRestoreStateForActivityResult(state, callbackContext);
    mCallbackContext = callbackContext;
  }
  */

  protected interface IntentFactory {
    Intent createIntent();
  }

  protected void loadVerIDAndStartActivity(JSONArray args, final Result result, final IntentFactory intentFactory, final int requestCode) {
    //cordova.setActivityResultCallback(this);
    loadVerIDAndRun(args, result, new Runnable() {
      @Override
      public void run() {
        Activity activity = VeridflutterpluginPlugin.this.activeUIActivityRef;
        if (activity == null) {
          result.error("loadVerIdAndStartActivityError", "Activity is null", null);
          return;
        }
        if (activity.isDestroyed()) {
          result.error("loadVerIdAndStartActivityError", "Activity is destroyed", null);
          return;
        }
        activity.startActivityForResult(intentFactory.createIntent(), requestCode);
      }
    });
  }

  protected void loadVerIDAndRun(final JSONArray args, final Result result, final Runnable runnable) {
    final Activity activity = this.activeUIActivityRef;
    if (activity == null || activity.isDestroyed()) {
      result.error("activityIsNull in " + baseImportPackageName,"flutter activity is null", null);
      Log.e(TAG, "flutter activity is null");
      return;
    }

    if (activity.isDestroyed()) {
      result.error("activityIsNull in " + baseImportPackageName,"flutter activity is destroyed", null);
      Log.e(TAG, "flutter activity is destroyed");
      return;
    }
    if (verID != null) {
      runnable.run();
    } else {
      String password = getArg(args, "password", String.class);
      VerIDFactory verIDFactory = new VerIDFactory(activity, new VerIDFactoryDelegate() {
        @Override
        public void veridFactoryDidCreateEnvironment(VerIDFactory verIDFactory, VerID verID) {
          VeridflutterpluginPlugin.this.verID = verID;
          runnable.run();
        }

        @Override
        public void veridFactoryDidFailWithException(VerIDFactory verIDFactory, Exception e) {
          result.error("verIdFactoryException in " + baseImportPackageName, "Ver-ID Factory Exception: " + e.getLocalizedMessage(), null);
        }
      });
      if (password != null) {
        verIDFactory.setVeridPassword(password);
      }
      verIDFactory.createVerID();
    }
  }

  protected  <T> T getArg(JSONArray args, String key, Class<T> type) {
    for (int i=0; args != null && i<args.length(); i++) {
      JSONObject arg = null;
      try {
        arg = args.getJSONObject(i);
      } catch (JSONException e) {
        e.printStackTrace();
      }
      if (arg != null && arg.has(key)) {
        try {
          return (T)arg.get(key);
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    }
    return null;
  }

  private final String FACE_MOCK = "{\"x\":-8.384888,\"y\":143.6514,\"width\":331.54974,\"height\":414.43723,\"yaw\":-0.07131743," +
          "\"pitch\":-6.6307373,\"roll\":-2.5829313,\"quality\":9.658932," +
          "\"leftEye\":[101,322.5],\"rightEye\":[213,321]," +
          "\"data\":\"TESTING_DATA\"," +
          "\"faceTemplate\":{\"data\":\"FACE_TEMPLATE_TEST_DATA\",\"version\":1}}";
  private final String ATTACHMENT_MOCK = "{\"attachments\": ["+
          "{\"recognizableFace\": " + FACE_MOCK + ", \"image\": \"TESTING_IMAGE\", \"bearing\": \"STRAIGHT\"}" +
          "]}";
  //###############################
}

