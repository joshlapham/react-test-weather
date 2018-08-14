//
//  NSDate+Helpers.m
//  Carton Cloud Tech Test
//
//  Created by jl on 14/8/18.
//  Copyright © 2018 Josh Lapham. All rights reserved.
//

#import "NSDate+Helpers.h"

const float kWholeDay = 86400.0;

@implementation NSDate (Helpers)

+ (NSDate *)yesterday {
    NSDate *today = [NSDate date];
    return [today dateByAddingTimeInterval:-kWholeDay];
}

- (NSString *)stringFromDate {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                   fromDate:self];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    return [NSString stringWithFormat:@"%ld/%ld/%ld", (long)year, (long)month, (long)day];
}

@end
