//
//  NSSet+TypeChecking.m
//  CTC
//
//  Created by Thomas Davie on 18/05/2012.
//  Copyright (c) 2012 Hunted Cow Studios. All rights reserved.
//

#import "NSSet+TypeChecking.h"

@implementation NSSet (TypeChecking)

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
