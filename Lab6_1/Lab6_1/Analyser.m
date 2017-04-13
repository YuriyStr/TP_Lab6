//
//  Analyser.m
//  Lab6_1
//
//  Created by Admin on 11.04.17.
//  Copyright (c) 2017 Yury Struchkou. All rights reserved.
//

#import "Analyser.h"

@implementation Analyser

+(void)analyse:(NSString *)input
{
    NSArray *words = [input componentsSeparatedByString:@" "];
    NSMutableDictionary *stats = [NSMutableDictionary dictionary];
    
    for (NSString *word in words)
    {
        NSNumber *reps = [stats valueForKey:word];
        if (reps == nil)
            [stats setObject:[[NSNumber alloc] initWithLong:1] forKey:word];
        else
            [stats setObject:[[NSNumber alloc] initWithLong:[reps integerValue] + 1] forKey:word];
    }
    
    NSArray *sortedKeys = [stats keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue])
            return (NSComparisonResult)NSOrderedAscending;
        if ([obj1 integerValue] < [obj2 integerValue])
            return (NSComparisonResult)NSOrderedDescending;
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSInteger num = MIN(5, [sortedKeys count]);
    for (int i = 0; i < num; i++)
    {
        NSLog(@"%@: %@\n", sortedKeys[i], [stats valueForKey:sortedKeys[i]]);
    }
}

@end
