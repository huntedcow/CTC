//
//  NSArray+TypeChecking.m
//  CTC
//
//  Created by Thomas Davie on 18/05/2012.
//  Copyright (c) 2012 Hunted Cow Studios. All rights reserved.
//

#import "NSArray+TypeChecking.h"

@implementation NSArray (TypeChecking)

- (BOOL)CTCAllObjectsAreKindOfClass:(Class)c
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

- (BOOL)CTCObjectsAreKindsOfClasses:(NSArray *)classSpec
{
    return [self CTCObjectsAreKindsOfClasses:classSpec allowAdditionalObjects:NO missingTrailingObjects:NO];
}

- (BOOL)CTCObjectsAreKindsOfClasses:(NSArray *)classSpec
             allowAdditionalObjects:(BOOL)additionalObjects
             missingTrailingObjects:(BOOL)missingObjects
{
    NSUInteger c = [self count];
    NSUInteger csc = [classSpec count];
    if (!additionalObjects && c > csc)
    {
        return NO;
    }
    if (!missingObjects && c < csc)
    {
        return NO;
    }
    
    NSUInteger idx = 0;
    for (Class cl in classSpec)
    {
        if (idx < c)
        {
            if (![[self objectAtIndex:idx] isKindOfClass:cl])
            {
                return NO;
            }
        }
        else
        {
            return YES;
        }
        
        idx++;
    }
    
    return YES;
}

@end
