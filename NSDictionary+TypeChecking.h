//
//  NSDictionary+TypeChecking.h
//  CTC
//
//  Created by Thomas Davie on 18/05/2012.
//  Copyright (c) 2012 Hunted Cow Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TypeChecking)

- (BOOL)CTCAllKeysAreKindOfClass:(Class)c;
- (BOOL)CTCAllObjectsAreKindOfClass:(Class)c;
- (BOOL)CTCAllKeysAreKindOfClass:(Class)kc andObjectsAreKindOfClass:(Class)oc;

- (BOOL)CTCObjectsAreKindsOfClasses:(NSDictionary *)classSpec;
- (BOOL)CTCObjectsAreKindsOfClasses:(NSDictionary *)classSpec
             allowAdditionalObjects:(BOOL)additionalObjects
                     missingObjects:(BOOL)missingObjects;

@end
