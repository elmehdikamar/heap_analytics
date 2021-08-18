#import "HeapAnalyticsPlugin.h"
#if __has_include(<heap_analytics/heap_analytics-Swift.h>)
#import <heap_analytics/heap_analytics-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "heap_analytics-Swift.h"
#endif

@implementation HeapAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHeapAnalyticsPlugin registerWithRegistrar:registrar];
}
@end
