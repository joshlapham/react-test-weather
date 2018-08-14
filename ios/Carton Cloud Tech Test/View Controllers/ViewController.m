//
//  ViewController.m
//  Carton Cloud Tech Test
//
//  Created by jl on 13/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <React/RCTRootView.h>

const float kWholeDay = 86400.0;
const NSString *kWIDBrisbane = @"1100661";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *fetchWeatherDataButton;

@end

@implementation ViewController

- (IBAction)fetchWeatherDataButtonPressed:(id)sender {
    self.fetchWeatherDataButton.enabled = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *dateString = [self stringFromDate:[self yesterday]];
    
    NSURL *apiUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.metaweather.com/api/location/%@/%@/", kWIDBrisbane, dateString]];
    
    NSLog(@"URL: %@", apiUrl);
    
    [self fetchData:apiUrl
  completionHandler:^(NSDictionary *jsonData) {
      dispatch_async(dispatch_get_main_queue(), ^{
          self.fetchWeatherDataButton.enabled = YES;
          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
          [self presentReactView:jsonData];
      });
  }];
}

- (NSDate *)yesterday {
    NSDate *today = [NSDate date];
    return [today dateByAddingTimeInterval:-kWholeDay];
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                   fromDate:date];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    return [NSString stringWithFormat:@"%ld/%ld/%ld", (long)year, (long)month, (long)day];
}

- (void)fetchData:(NSURL *)apiUrl
completionHandler:(void (^)(NSDictionary *))completionHandler {
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
    NSDictionary *jsonModified = @{ @"data": jsonData }; // Add a key to the JSON data so that React component can parse its `props` correctly
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:delegate.bridge
                                                     moduleName:@"RNWeatherResultsList"
                                              initialProperties:jsonModified];
    
    UIViewController *containerViewController = [[UIViewController alloc] init];
    containerViewController.view = rootView;
    containerViewController.title = @"Weather Results";
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
