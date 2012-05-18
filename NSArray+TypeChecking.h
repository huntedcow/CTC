//
//  NSArray+TypeChecking.h
//  CTC
//
//  Created by Thomas Davie on 18/05/2012.
//  Copyright (c) 2012 Hunted Cow Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (TypeChecking)

- (BOOL)allObjectsAreKindOfClass:(Class)c;

@end
