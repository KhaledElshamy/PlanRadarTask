//
//  APIClient.h
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIClient : NSObject
+ (id) sharedInstance;
- (void) sendRequestWithURL: (NSString *) url parameters: (NSDictionary* _Nullable)params httpHeaders: (NSDictionary* _Nullable)headers httpMethod: (NSString *) method completionHandler: (void (^)( id _Nullable  result, NSError*  _Nullable error))finishBlock ;
@end

NS_ASSUME_NONNULL_END
