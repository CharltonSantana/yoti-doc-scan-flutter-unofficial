# Yoti Doc Scan Package for Flutter (Unofficial)

Yoti is an identity checking platform that allows organisations to verify who people are, online and in person. The Yoti Doc Scan SDK allows the user to take a photo of their identifying document which we verify instantly and prepare a response which your system can then retrieve. Further information can be found in the [documentation](https://developers.yoti.com/yoti/getting-started-docscan).

## Prerequisites

A supporting Yoti Doc Scan SDK backend installation is required. Learn more about the backend SDK in the [Getting Started guide](https://developers.yoti.com/yoti/getting-started-docscan).


# Usage

The SDK exposes a single method, `startYoti()`, which handles communication between your app and the Yoti app on a user's device.

Import the SDK with:
```dart
import 'package:yoti_flutter/yoti_flutter.dart';
```

Call the `startYoti` method with your session ID and client session token. 
The method accepts two callbacks: one invoked on success, and the other when the result is a failure.
```dart
final _yotiFlutterPlugin = YotiFlutter();


try {
    var response = await _yotiFlutterPlugin.startYoti(
        "<Session ID>",
        "<Session Token>");

    print(response); // 0 - Result with success

} catch (error) {
    // Session Cancelled / Error
    print('Platform err: ${error.toString()}');
}
  
```

Your error will receive a consistent response with two parameters: `code` (number) and `description` (string).
The `code` is always populated with one of the values in the results table below.

| Code              | Message                      | Retry possible for the same session                    |
| ----------------- | ---------------------------- | ---------------------------------- |
| 0                 | Result with success          | No                                 |
| 1000              | No error occurred - the end-user cancelled the session for an unknown reason           | Yes |
| 2000              | Unauthorised request (wrong or expired session token)           | Yes |
| 2001              | Session not found           | Yes |
| 2003              | SDK launched without session Token           | Yes |
| 2004              | SDK launched without session ID           | Yes |
| 3000              | Yoti's services are down or unable to process the request           | Yes |
| 3001              | An error occurred during a network request          | Yes |
| 3002              | User has no network          | Yes |
| 4000              | The user did not grant permissions to the camera          | Yes |
| 5000              | No camera (when user's camera was not found and file upload is not allowed)          | No |
| 5002              | No more local tries for the liveness flow          | Yes |
| 5003              | SDK is out-of-date - please update the SDK to the latest version          | No |
| 5004              | Unexpected internal error          | No |
| 5005              | Unexpected document scanning error          | No |
| 5006              | Unexpected liveness error          | No |
| 6000              | Document Capture dependency not found error          | No |
| 6001              | Liveness Zoom dependency not found error          | No |
| 6002              | Supplementary document dependency not found error          | No |



## Android configuration

### Microblink

Add microblink to your repositories in the root build.gradle file (`android/build.gradle`):

```groovy
allprojects {
    repositories {
        mavenCentral()
        maven { url 'https://maven.microblink.com' }
        maven { url "https://jitpack.io" }
        ...
    }
    ...
}
```
### Debug build configuration

Add this configuration for the debug build type to your `buildTypes` block (`android/app/build.gradle`):

```groovy
buildTypes {
    debug {
        matchingFallbacks = ['release']
      ...
    }
    ...
}

```
If you're using [Firebase Performance Monitoring](https://rnfirebase.io/perf/usage) you'll need to disable it for debug built variant. One way to do this is including this flag in your `gradle.properties` file:

```groovy
firebasePerformanceInstrumentationEnabled=false

```
And update your release build command line to enable it:

```groovy
./gradlew assembleRelease -PfirebasePerformanceInstrumentationEnabled=true

```

### Release build configuration
If you're using **Proguard** or other obfuscation tool, add the following configuration rules to your proguard-rules.pro file:
```groovy
-keep class com.yoti.** { *; }
-keep class com.microblink.** { *; }
-keep class com.microblink.**$* { *; }
-dontwarn com.microblink.**
-keep class com.facetec.zoom.** { *; }
-dontwarn javax.annotation.Nullable
```


Depending on your Android project setup and version of React Native, you
may encounter the following error during your build process:

> More than one files produce libc++_shared.so

Resolve by adding the following packaging options to your `android` block (`android/app/build.gradle`):

```groovy
android {
    compileSdkVersion rootProject.ext.compileSdkVersion
    
    packagingOptions {
        pickFirst 'lib/x86/libc++_shared.so'
        pickFirst 'lib/x86_64/libjsc.so'
        pickFirst 'lib/arm64-v8a/libjsc.so'
        pickFirst 'lib/arm64-v8a/libc++_shared.so'
        pickFirst 'lib/x86_64/libc++_shared.so'
        pickFirst 'lib/armeabi-v7a/libc++_shared.so'
    }
    ...

```

> Running out of memory `space: java.lang.OutOfMemoryError: Java heap space`

Resolve by increasing the daemon memory settings in your `gradle.properties` file:

```groovy
org.gradle.jvmargs=-Xmx4608m
```