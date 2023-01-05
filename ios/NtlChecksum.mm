#import "NtlChecksum.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NtlChecksum
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(getChecksum,
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{

    // NSString *path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"jsbundle"];
    NSBundle *main = [NSBundle mainBundle];
    NSURL *pathUrl = [main URLForResource:@"main" withExtension:@"jsbundle"];
    NSString *path = [pathUrl absoluteString];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    if (data == nil) {
        resolve(@"not found");
        return;
    }
    
    const char* str = [data UTF8String];
    
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }

    resolve(ret);
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeNtlChecksumSpecJSI>(params);
}
#endif

@end
