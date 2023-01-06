#import "NtlChecksum.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NtlChecksum
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_EXPORT_METHOD(getChecksum:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"jsbundle"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(data == nil) {
        resolve(@"");
        return;
    }
    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, data.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    resolve(ret);
}

RCT_EXPORT_METHOD(getChecksumCert:(NSString *)certName resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError* error = nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:certName ofType:@"cer"];
    NSData *nsData = [NSData dataWithContentsOfFile:path];
    
   if (nsData == nil) {
       resolve(nil);
       return;
   }
    
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([nsData bytes], [nsData length], result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }

    resolve(ret);
}

RCT_EXPORT_METHOD(getSumMETA:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)
{
    resolve(@"");
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
