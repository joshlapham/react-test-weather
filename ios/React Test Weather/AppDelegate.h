//
//  AppDelegate.h
//  React Test Weather
//
//  Created by jl on 13/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RCTBridge *bridge;

@end
