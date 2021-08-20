# heap_analytics

A non-official flutter plugin for Heap.io analytics (Android/iOS).

## Getting Started
### Android installation
Add the classpath for the Heap Gradle Plugin in the project-level `build.gradle`:
```
buildscript {
    ...
    dependencies {
        ...
        classpath "com.heapanalytics.android:heap-android-gradle:1.7.+"
        ...
    }
    ...
}
```

Then enable the plugin in the app-level `build.gradle`:
```
...
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
apply plugin: 'com.heapanalytics.android'
...
```

Finally add you Heap configuration, please refer to the [documentation](https://developers.heap.io/docs/android) for more info:
```
android {
    ...
    defaultConfig {
        ...
        ext {
            heapEnabled = true
        }
        ...
    }
    ...
}
```

Note: Make sure you have the required permissions in your `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"></uses-permission>
```

## Usage

Initialize Heap analytics:
```dart
await HeapAnalytics.init(appId: 'YOUR_APP_ID'); //replace with your Heap environment ID
```

Track event:
```dart
await HeapAnalytics.track(event: 'TestEvent'); //simple event
await HeapAnalytics.track(event: 'TestEvent', properties: { 'one': 'two', 'three': 4, 'five': '123' }); //event with properties
```

Identify:
```dart
await HeapAnalytics.identify('YOUR_IDENTITY');
```

Reset identity:
```dart
await HeapAnalytics.resetIdentity();
```

Add User Properties:
```dart
HeapAnalytics.addUserProperties(properties: { 'username': 'johndoe', 'email': 'email@example.com', 'first_name': 'John', 'last_name': 'Doe' });
```

## Contact
elmehdikamar@gmail.com