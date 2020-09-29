#import "VeridflutterpluginPlugin.h"
#if __has_include(<veridflutterplugin/veridflutterplugin-Swift.h>)
#import <veridflutterplugin/veridflutterplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "veridflutterplugin-Swift.h"
#endif

@implementation VeridflutterpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVeridflutterpluginPlugin registerWithRegistrar:registrar];
}
@end
