//
//  ViewController.m
//  Carton Cloud Tech Test
//
//  Created by jl on 13/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import "ViewController.h"
#import <React/RCTRootView.h>

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)fetchWeatherDataButtonPressed:(id)sender {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self fetchData:^(NSDictionary *jsonData) {
        NSLog(@"JSON data: %@", jsonData);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self presentReactView:jsonData];
        });
    }];
}

- (void)fetchData:(void (^)(NSDictionary *))completionHandler {
    // TODO: don't hardcode `apiUrl` value
    // TODO: allow for URL params
    // TODO: need to fetch details for yesterday; so we'll need to form a string using `NSDate`
    NSURL *apiUrl = [NSURL URLWithString:@"https://www.metaweather.com/api/location/1100661/"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:apiUrl
                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                            // TODO: implement error handling
                                            NSLog(@"%@", response);
                                            
                                            NSError *jsonError = nil;
                                            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                 options:0
                                                                                                   error:&jsonError];
                                            
                                            completionHandler((NSDictionary *) json);
                                        }];
    
    [task resume];
}

- (void)presentReactView:(NSDictionary *)jsonData {
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNWeatherResultsList"
                                                 initialProperties:jsonData
                                                     launchOptions:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

@end
