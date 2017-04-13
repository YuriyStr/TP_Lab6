//
//  main.m
//  Lab6_1
//
//  Created by Admin on 11.04.17.
//  Copyright (c) 2017 Yury Struchkou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Analyser.h"
#include <stdio.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char buffer[1001];
        NSLog(@"Enter the input string: ");
        fgets(buffer, 1001, stdin);
        buffer[strlen(buffer) - 1] = '\0';
        
        NSString *input = [NSString stringWithUTF8String:buffer];
        [Analyser analyse:input];
    }
    return 0;
}
