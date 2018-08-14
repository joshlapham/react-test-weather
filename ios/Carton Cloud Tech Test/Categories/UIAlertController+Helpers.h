//
//  UIAlertController+Helpers.h
//  Carton Cloud Tech Test
//
//  Created by jl on 14/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Helpers)

+ (UIAlertController *)errorAlertController:(NSString *)title
                                    message:(NSString *)message;

@end
