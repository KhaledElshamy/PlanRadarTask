//
//  APIClient.m
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

#import "APIClient.h"
#import "AFNetworking.h"

@implementation APIClient

+ (id)sharedInstance {
    static APIClient *sharedClient = nil;
      static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
          sharedClient = [[self alloc] init];
      });
      return sharedClient;
}

# pragma: - Methods

- (void) sendRequestWithURL: (NSString *) url parameters: (NSDictionary* _Nullable)params httpHeaders: (NSDictionary* _Nullable)headers httpMethod: (NSString *) method completionHandler: (void (^)( id _Nullable  result, NSError*  _Nullable error))finishBlock {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration: configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithHTTPMethod: method URLString: url parameters: params headers: nil uploadProgress: nil downloadProgress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finishBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finishBlock(nil, error);
    }];
    [dataTask resume];
}

@end
