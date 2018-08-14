//
//  NSError+Helpers.m
//  Carton Cloud Tech Test
//
//  Created by jl on 14/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import "NSError+Helpers.h"

NSString * const kJPLErrorDomain = @"com.joshlapham.Tech-Test";

@implementation NSError (Helpers)

+ (NSError *)dataFetchError:(NSInteger)responseStatusCode {
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedString(@"Data fetch from API was unsuccessful; response status code was %lu", nil), responseStatusCode]
                               };
    
    NSError *error = [NSError errorWithDomain:kJPLErrorDomain
                                         code:-42
                                     userInfo:userInfo];
    
    return error;
}

@end
