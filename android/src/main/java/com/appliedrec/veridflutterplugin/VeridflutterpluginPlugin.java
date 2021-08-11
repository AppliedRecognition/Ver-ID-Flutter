package com.appliedrec.veridflutterplugin;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.os.Looper;
import android.util.Base64;
import android.util.Base64InputStream;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.exifinterface.media.ExifInterface;

import com.appliedrec.verid.core2.Face;
import com.appliedrec.verid.core2.RecognizableFace;
import com.appliedrec.verid.core2.VerID;
import com.appliedrec.verid.core2.VerIDFactory;
import com.appliedrec.verid.core2.VerIDFactoryDelegate;
import com.appliedrec.verid.core2.VerIDImageBitmap;
import com.appliedrec.verid.core2.session.AuthenticationSessionSettings;
import com.appliedrec.verid.core2.session.LivenessDetectionSessionSettings;
import com.appliedrec.verid.core2.session.RegistrationSessionSettings;
import com.appliedrec.verid.core2.session.VerIDSessionResult;
import com.appliedrec.verid.core2.session.VerIDSessionSettings;
import com.appliedrec.verid.ui2.IVerIDSession;
import com.appliedrec.verid.ui2.VerIDSession;
import com.appliedrec.verid.ui2.VerIDSessionDelegate;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.ByteArrayInputStream;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * VeridflutterpluginPlugin
 */
public class VeridflutterpluginPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

  private static final String CHANNEL = "veridflutterplugin";
  private static boolean TESTING_MODE = false;
  public static String TAG = VeridflutterpluginPlugin.class.getSimpleName();

  private Result mResult = null;
  private Activity activity = null;
  private VerID verID;
  private String packageName;

  public void onAttachedToActivity(ActivityPluginBinding binding) {
    //TODO - test with unit tests
    //save reference to activity for use in load
    this.activity = binding.getActivity();
  }

  public void onDetachedFromActivityForConfigChanges() {
    //TODO - test with unit tests
    this.activity = null;
  }

  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    //TODO - test with unit tests
    this.activity = binding.getActivity();
  }

  public void onDetachedFromActivity() {
    //TODO - test with unit tests
    this.activity = null;
  }

  // END LIFECYCLE METHODS
  //! The MethodChannel that will the communication between Flutter and native Android
  //
  //! This local reference serves to register the plugin with the Flutter Engine and unregister it
  //! when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL);
    channel.setMethodCallHandler(this);
    onAttachedToEngine(flutterPluginBinding.getApplicationContext());
  }

  private void onAttachedToEngine(Context applicationContext) {
    this.packageName = applicationContext.getPackageName();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
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
    final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
    VeridflutterpluginPlugin plugin = new VeridflutterpluginPlugin();
    channel.setMethodCallHandler(plugin);
  }

  @Override
  public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
    mResult = result;
    String FACE_MOCK = "{\"x\":-8.384888,\"y\":143.6514,\"width\":331.54974,\"height\":414.43723,\"yaw\":-0.07131743," +
            "\"pitch\":-6.6307373,\"roll\":-2.5829313,\"quality\":9.658932," +
            "\"leftEye\":[101,322.5],\"rightEye\":[213,321]," +
            "\"data\":\"TESTING_DATA\"," +
            "\"faceTemplate\":{\"data\":\"FACE_TEMPLATE_TEST_DATA\",\"version\":1}}";
    String ATTACHMENT_MOCK = "{\"attachments\": [" +
            "{\"recognizableFace\": " + FACE_MOCK + ", \"image\": \"TESTING_IMAGE\", \"bearing\": \"STRAIGHT\"}" +
            "]}";

    switch (call.method) {
      case "setTestingMode":
        if (call.argument("testingMode")) {
          try {
            TESTING_MODE = call.argument("testingMode");
            result.success("OK");
          } catch (final Exception e) {
            e.printStackTrace();
            result.error("1", "Not valid argument provided", null);
          }

        } else {
          result.error("1", "Not valid argument provided", null);
        }
        break;
      case "load":
        try {
          loadVerIDAndRun(call, result, new Runnable() {
            @Override
            public void run() {
              result.success("OK");
            }
          });
        } catch (Exception ex) {
          Log.d(TAG, ex.getMessage());
        }
        break;
      case "unload":
        verID = null;
        result.success("OK");
        break;
      case "registerUser": {
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
            loadVerIDAndStartSession(call, result, settings);
          } catch (Exception ex) {
            Log.d(TAG, ex.getMessage());
          }
        }
        break;
      }
      case "authenticate": {
        String jsonSettings = call.argument("settings");
        AuthenticationSessionSettings tempSettings = null;
        if (TESTING_MODE) {
          result.success(ATTACHMENT_MOCK);
        } else {
          if (jsonSettings != null) {
            Gson gson = new Gson();
            tempSettings = gson.fromJson(jsonSettings, AuthenticationSessionSettings.class);
          } else {
            result.error("authenticationCannotParseSettings", "Unable to parse session settings", null);
          }
          final AuthenticationSessionSettings settings = tempSettings;
          loadVerIDAndStartSession(call, result, settings);
        }
        break;
      }
      case "captureLiveFace": {
        String jsonSettings = call.argument("settings");
        LivenessDetectionSessionSettings tempSettings = null;
        if (TESTING_MODE) {
          result.success(ATTACHMENT_MOCK);
        } else {
          if (jsonSettings != null) {
            Gson gson = new Gson();
            tempSettings = gson.fromJson(jsonSettings, LivenessDetectionSessionSettings.class);
          } else {
            result.error("captureLiveFaceError", "Unable to parse session settings", null);
          }
          final LivenessDetectionSessionSettings settings = tempSettings;
          loadVerIDAndStartSession(call, result, settings);
        }
        break;
      }
      case "getRegisteredUsers":
        loadVerIDAndRun(call, result, new Runnable() {
          @Override
          public void run() {
            new Thread(new Runnable() {
              public void run() {
                try {
                  String[] users = verID.getUserManagement().getUsers();
                  Gson gson = new Gson();
                  String usersFound;
                  if (TESTING_MODE) {
                    usersFound = "[\"user1\", \"user2\", \"user3\"]";
                  } else {
                    usersFound = gson.toJson(users, String[].class);
                  }
                  final String jsonUsers = usersFound;
                  getMainThread(new Runnable() {
                    @Override
                    public void run() {
                      result.success(jsonUsers);
                    }
                  });
                } catch (final Exception e) {
                  e.printStackTrace();
                  getMainThread(new Runnable() {
                    @Override
                    public void run() {
                      result.error("errorLoadingRegisteredUsers", e.getLocalizedMessage(), null);
                    }
                  });
                }
              }
            }).start();
          }
        });
        break;
      case "deleteUser": {
        final String userId = call.argument("userId");
        if (userId != null) {
          loadVerIDAndRun(call, result, new Runnable() {
            @Override
            public void run() {
              new Thread(new Runnable() {
                @Override
                public void run() {
                  try {
                    verID.getUserManagement().deleteUsers(new String[]{userId});
                    getMainThread(new Runnable() {
                      @Override
                      public void run() {
                        result.success("OK");
                      }
                    });
                  } catch (final Exception e) {
                    e.printStackTrace();
                    getMainThread(new Runnable() {
                      @Override
                      public void run() {
                        result.error("deleteUserError", e.getLocalizedMessage(), null);
                      }
                    });
                  }
                }
              }).start();
            }
          });
        } else {
          result.error("deleteUserError", "User id must not be null", null);
        }
        break;
      }
      case "compareFaces":
        final String t1 = call.argument("face1");
        final String t2 = call.argument("face2");
        loadVerIDAndRun(call, result, new Runnable() {
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
              getMainThread(new Runnable() {
                @Override
                public void run() {
                  result.success(jsonResponse);
                }
              });
            } catch (final Exception e) {
              e.printStackTrace();
              getMainThread(new Runnable() {
                @Override
                public void run() {
                  result.error("compareFacesError", e.getLocalizedMessage(), null);
                }
              });
            }
          }
        });
        break;
      case "detectFaceInImage":
        final String image = call.argument("image");
        loadVerIDAndRun(call, result, new Runnable() {
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
              VerIDImageBitmap verIDImage = new VerIDImageBitmap(bitmap, ExifInterface.ORIENTATION_NORMAL);
              Face[] faces = verID.getFaceDetection().detectFacesInImage(verIDImage.createFaceDetectionImage(), 1, 0);
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
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  // BASE CODE FOR MODS

  protected void loadVerIDAndStartSession(@NonNull final MethodCall call, final Result result, final VerIDSessionSettings settings) {
    loadVerIDAndRun(call, result, new Runnable() {
      @Override
      public void run() {
        Activity activity = VeridflutterpluginPlugin.this.activity;
        if (activity == null) {
          result.error("loadVerIdAndStartActivityError", "Activity is null", null);
          return;
        }
        if (activity.isDestroyed()) {
          result.error("loadVerIdAndStartActivityError", "Activity is destroyed", null);
          return;
        }
        mResult = result;
        VerIDSession session = new VerIDSession(verID, settings);
        session.setDelegate(new SessionDelegate());
        session.start();
      }
    });
  }

  protected void loadVerIDAndRun(@NonNull final MethodCall call, final Result result, final Runnable runnable) {
    final Activity activity = this.activity;
    if (activity == null) {
      result.error("activityIsNull in " + packageName, "flutter activity is null", null);
      return;
    }
    if (activity.isDestroyed()) {
      result.error("activityIsNull in " + packageName, "flutter activity is destroyed", null);
      return;
    }
    if (verID != null) {
      runnable.run();
    } else {
      String password = call.argument("password");
      VerIDFactory verIDFactory = new VerIDFactory(activity, new VerIDFactoryDelegate() {
        @Override
        public void onVerIDCreated(VerIDFactory factory, VerID verID) {
          VeridflutterpluginPlugin.this.verID = verID;
          runnable.run();
        }

        @Override
        public void onVerIDCreationFailed(VerIDFactory factory, Exception error) {
          result.error("verIdFactoryException in " + packageName, "Ver-ID Factory Exception: " + error.getLocalizedMessage(), null);
        }
      });
      if (password != null) {
        verIDFactory.setVeridPassword(password);
      }
      verIDFactory.createVerID();
    }
  }

  private void getMainThread(Runnable runnable) {
    new Handler(Looper.getMainLooper()).post(runnable);
  }

  // Session Delegate

  class SessionDelegate implements VerIDSessionDelegate {

    @Override
    public void onSessionFinished(IVerIDSession<?> session, final VerIDSessionResult result) {
      if (!result.getError().isPresent() && mResult != null) {
        getMainThread(new Runnable() {
          @Override
          public void run() {
            Gson gson = new Gson();
            final String response = gson.toJson(result, VerIDSessionResult.class);
            final Activity activity = VeridflutterpluginPlugin.this.activity;
            if (activity == null) {
              mResult.error("Flutter activity is null", null, null);
              return;
            }
            if (activity.isDestroyed()) {
              mResult.error("Activity is destroyed", null, null);
              return;
            }
            mResult.success(response);
            mResult = null;
          }
        });
      } else {
        if (mResult != null) {
          getMainThread(new Runnable() {
            @Override
            public void run() {
              mResult.error("onSessionFinished", "Session canceled", result.getError().toString());
            }
          });
        }
      }
    }
  }
}

