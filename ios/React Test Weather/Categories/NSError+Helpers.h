//
//  NSError+Helpers.h
//  React Test Weather
//
//  Created by jl on 14/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Helpers)

+ (NSError *)dataFetchError:(NSInteger)responseStatusCode;

@end
