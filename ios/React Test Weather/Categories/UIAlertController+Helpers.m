//
//  UIAlertController+Helpers.m
//  React Test Weather
//
//  Created by jl on 14/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import "UIAlertController+Helpers.h"

@implementation UIAlertController (Helpers)

+ (UIAlertController *)errorAlertController:(NSString *)title
                                    message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Okay", nil)
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
    
    [alertController addAction:okayAction];
    
    return alertController;
}

@end
