//
//  RCTStocksModule.m
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

#import "RCTStocksModule.h"
#import "SUIRN-Swift.h"

@implementation RCTStocksModule
@class StocksModule;

// To export a module named StocksModule
RCT_EXPORT_MODULE(StocksModule);

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getValues:(NSNumber *)period
                                       ticker:(NSString *)ticker) {
    return [StocksModule getValues:[period integerValue] ticker:@"NVDA"];
}

@end
