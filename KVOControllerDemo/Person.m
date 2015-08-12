//
//  Person.m
//  KVOControllerDemo
//
//  Created by Keita on 8/11/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Keita";
    }
    return self;
}

@end
