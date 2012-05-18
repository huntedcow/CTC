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

- (BOOL)allKeysAreKindOfClass:(Class)c
{
    return [[self allKeys] allObjectsAreKindOfClass:c];
}

- (BOOL)allObjectsAreKindOfClass:(Class)c
{
    return [[self allValues] allObjectsAreKindOfClass:c];
}

- (BOOL)allKeysAreKindOfClass:(Class)kc andObjectsAreKindOfClass:(Class)oc
{
    __block BOOL invalid = NO;
    [self enumerateKeysAndObjectsUsingBlock:^(id k, id o, BOOL *stop)
     {
         *stop = invalid = ![k isKindOfClass:kc] || ![o isKindOfClass:oc];
     }];
    return invalid;
}

@end
