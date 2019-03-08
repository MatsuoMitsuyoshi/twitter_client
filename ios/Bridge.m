//
//  Bridge.m
//  twitter_client
//
//  Created by mitsuyoshi matsuo on 2019/02/13.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(HelloWorld, NSObject)

RCT_EXTERN_METHOD(say)

@end

@interface RCT_EXTERN_MODULE(TwitterModule, NSObject)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

// Twitter Login
RCT_EXTERN_METHOD(auth:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject )

// Tweet function
RCT_EXTERN_METHOD(tweet)

// Login Judge
RCT_EXTERN_METHOD(isLogined:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject )

// Get Timeline
RCT_EXTERN_METHOD(getTimeline:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject )

@end
