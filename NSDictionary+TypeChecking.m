//
//  NSDictionary+TypeChecking.m
//  CTC
//
//  Created by Thomas Davie on 18/05/2012.
//  Copyright (c) 2012 Hunted Cow Studios. All rights reserved.
//

#import "NSDictionary+TypeChecking.h"

#import "NSArray+TypeChecking.h"

@implementation NSDictionary (TypeChecking)

- (BOOL)CTCAllKeysAreKindOfClass:(Class)c
{
    return [[self allKeys] CTCAllObjectsAreKindOfClass:c];
}

- (BOOL)CTCAllObjectsAreKindOfClass:(Class)c
{
    return [[self allValues] CTCAllObjectsAreKindOfClass:c];
}

- (BOOL)CTCAllKeysAreKindOfClass:(Class)kc andObjectsAreKindOfClass:(Class)oc
{
    __block BOOL invalid = NO;
    [self enumerateKeysAndObjectsUsingBlock:^(id k, id o, BOOL *stop)
     {
         *stop = invalid = ![k isKindOfClass:kc] || ![o isKindOfClass:oc];
     }];
    return !invalid;
}

- (BOOL)CTCObjectsAreKindsOfClasses:(NSDictionary *)classSpec
{
    return [self CTCObjectsAreKindsOfClasses:classSpec allowAdditionalObjects:NO missingObjects:NO];
}

- (BOOL)CTCObjectsAreKindsOfClasses:(NSDictionary *)classSpec
             allowAdditionalObjects:(BOOL)additionalObjects
                     missingObjects:(BOOL)missingObjects
{
    NSUInteger numberOfObjectsFound = 0;
    for (id k in classSpec)
    {
        Class expectedClass = [classSpec objectForKey:k];
        id o = [self objectForKey:k];
        if (nil != o)
        {
            numberOfObjectsFound++;
            if (![o isKindOfClass:expectedClass])
            {
                return NO;
            }
        }
        else if (!missingObjects)
        {
            return NO;
        }
    }
    if (!additionalObjects)
    {
        return [self count] == numberOfObjectsFound;
    }
    
    return YES;
}

@end
