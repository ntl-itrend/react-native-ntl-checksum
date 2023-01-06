
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNNtlChecksumSpec.h"

@interface NtlChecksum : NSObject <NativeNtlChecksumSpec>
#else
#import <React/RCTBridgeModule.h>

@interface NtlChecksum : NSObject <RCTBridgeModule>
#endif

@end
 