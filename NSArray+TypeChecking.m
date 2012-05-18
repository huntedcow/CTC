//
//  NSArray+TypeChecking.m
//  CTC
//
//  Created by Thomas Davie on 18/05/2012.
//  Copyright (c) 2012 Hunted Cow Studios. All rights reserved.
//

#import "NSArray+TypeChecking.h"

@implementation NSArray (TypeChecking)

- (BOOL)allObjectsAreKindOfClass:(Class)c
{
    for (id i in self)
    {
        if (![i isKindOfClass:c])
        {
            return NO;
        }
    }
    return YES;
}

@end
