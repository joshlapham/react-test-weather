//
//  ViewController.m
//  Carton Cloud Tech Test
//
//  Created by jl on 13/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "NSDate+Helpers.h"
#import "UIAlertController+Helpers.h"
#import "NSError+Helpers.h"
#import <React/RCTRootView.h>

NSString * const kWIDBrisbane = @"1100661";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *fetchWeatherDataButton;

@end

@implementation ViewController

- (void)toggleUIState:(BOOL)networkingActive {
    self.fetchWeatherDataButton.enabled = !networkingActive;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:networkingActive];
}

- (IBAction)fetchWeatherDataButtonPressed:(id)sender {
    [self toggleUIState:YES];
    
    NSString *dateString = [[NSDate yesterday] stringFromDate];
    
    NSURL *apiUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.metaweather.com/api/location/%@/%@/",
                                          kWIDBrisbane,
                                          dateString]];
    
    NSLog(@"URL: %@", apiUrl);
    
    [self fetchData:apiUrl
  completionHandler:^(NSDictionary * _Nullable jsonData,
                      NSError * _Nullable error) {
      NSLog(@"Error: %@", error);
      
      if (error != nil && jsonData == nil) {
          dispatch_async(dispatch_get_main_queue(), ^{
              [self toggleUIState:NO];
              
              UIAlertController *errorAlertController = [UIAlertController errorAlertController:NSLocalizedString(@"Error", nil)
                                                                                        message:[error localizedDescription]];
              
              [self presentViewController:errorAlertController
                                 animated:YES
                               completion:nil];
          });
          
      } else {
          dispatch_async(dispatch_get_main_queue(), ^{
              [self toggleUIState:NO];
              [self presentReactView:jsonData];
          });
      }
  }];
}

- (void)fetchData:(NSURL *)apiUrl
completionHandler:(void (^)(NSDictionary * _Nullable jsonData, NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:apiUrl
                                        completionHandler:^(NSData * _Nullable data,
                                                            NSURLResponse * _Nullable response,
                                                            NSError * _Nullable error) {
                                            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                            NSLog(@"%@", response);
                                            NSLog(@"Status code: %ld", (long)httpResponse.statusCode);
                                            
                                            // Handle errors
                                            if (error != nil) {
                                                completionHandler(nil, error);
                                                
                                            } else if (httpResponse.statusCode != 200) {
                                                NSError *error = [NSError dataFetchError:httpResponse.statusCode];
                                                completionHandler(nil, error);
                                                
                                            } else {
                                                // Parse JSON data
                                                NSError *jsonError = nil;
                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                     options:0
                                                                                                       error:&jsonError];
                                                
                                                if (jsonError != nil) {
                                                    completionHandler(nil, jsonError);
                                                    
                                                } else {
                                                    completionHandler(json, nil);
                                                }
                                            }
                                        }];
    
    [task resume];
}

- (void)presentReactView:(NSDictionary *)jsonData {
    NSDictionary *jsonModified = @{ @"data": jsonData }; // Add a key to the JSON data so that React component can parse its `props` correctly
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:delegate.bridge
                                                     moduleName:@"RNWeatherResultsList"
                                              initialProperties:jsonModified];
    
    UIViewController *containerViewController = [[UIViewController alloc] init];
    containerViewController.view = rootView;
    containerViewController.title = NSLocalizedString(@"Weather Results", nil);
    containerViewController.edgesForExtendedLayout = UIRectEdgeNone; // Ensure navbar doesn't overlap React Native `FlatList` component view
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                 target:self
                                                                                 action:@selector(closeButtonTapped:)];
    containerViewController.navigationItem.rightBarButtonItem = closeButton;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:containerViewController];
    
    [self presentViewController:navController
                       animated:YES
                     completion:nil];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
