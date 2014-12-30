//
//  NSDate+TimeTools.m
//  CvtDate
//
//  Created by Yicheng Wang on 12/30/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "NSDate+TimeTools.h"

@implementation NSDate (TimeTools)

- (NSInteger)TimeDifference{ //Give the time difference between LocalTime and GMTtime.
    NSDate *GMTdate = [[NSDate alloc]init];
    NSDate *localdate = [GMTdate LocalDate];
    NSTimeInterval distanceBetweenDates = [localdate timeIntervalSinceDate:GMTdate];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    return hoursBetweenDates;
}

- (NSDate *)LocalDate{ //Give local time.
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    NSDate *today = [NSDate dateWithTimeInterval: seconds sinceDate: self];
    return today;
}

- (NSString *)GMTString{ //Give GMT time as a string.
    NSDate *date = [[NSDate alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmm";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    NSString *datestring = [formatter stringFromDate:date];
    return datestring;
}

- (NSMutableDictionary *)TimeArrayFromTimeString:(NSString *)time{ //Convert a time string to time dictionary.
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    const char *s = [time UTF8String];
    NSString *year = [NSString stringWithFormat:@"%c%c%c%c",s[0],s[1],s[2],s[3]];
    [dic setObject:year forKey:@"year"];
    NSString *month = [NSString stringWithFormat:@"%c%c",s[4],s[5]];
    [dic setObject:month forKey:@"month"];
    NSString *day = [NSString stringWithFormat:@"%c%c",s[6],s[7]];
    [dic setObject:day forKey:@"day"];
    NSString *hour = [NSString stringWithFormat:@"%c%c",s[8],s[9]];
    [dic setObject:hour forKey:@"hour"];
    NSString *min = [NSString stringWithFormat:@"%c%c",s[10],s[11]];
    [dic setObject:min forKey:@"min"];
    return dic;
}


@end
