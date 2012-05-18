//
//  CTCTests.m
//  CTCTests
//
//  Created by Thomas Davie on 18/05/2012.
//  Copyright (c) 2012 Hunted Cow Studios. All rights reserved.
//

#import "CTCTests.h"

#import "NSArray+TypeChecking.h"
#import "NSDictionary+TypeChecking.h"
#import "NSSet+TypeChecking.h"

@implementation CTCTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testHomogeneousArray
{
    BOOL shouldPass = [[NSArray arrayWithObjects:@"a", @"b", @"c", nil] CTCAllObjectsAreKindOfClass:[NSString class]];
    STAssertTrue(shouldPass, @"Homogeneous array type checking gave false type error.");
    shouldPass = [[NSArray array] CTCAllObjectsAreKindOfClass:[NSArray class]];
    STAssertTrue(shouldPass, @"Empty homogeneous array type checking gave false type error.");
    BOOL shouldFail = [[NSArray arrayWithObjects:@"a", [NSNumber numberWithInt:5], nil] CTCAllObjectsAreKindOfClass:[NSString class]];
    STAssertFalse(shouldFail, @"Homogeneous array containing incorrectly typed elements did not cause type error.");
}

- (void)testHeterogeneousArray
{
    BOOL shouldPass = [[NSArray arrayWithObjects:@"a", [NSNumber numberWithInt:5], [NSArray array], nil] CTCObjectsAreKindsOfClasses:[NSArray arrayWithObjects:[NSString class], [NSNumber class], [NSArray class], nil]];
    STAssertTrue(shouldPass, @"Heterogeneous array type checking gave false type error.");
    shouldPass = [[NSArray array] CTCObjectsAreKindsOfClasses:[NSArray array]];
    STAssertTrue(shouldPass, @"Empty heterogeneous array type checking gave false type error.");
    BOOL shouldFail = [[NSArray array] CTCObjectsAreKindsOfClasses:[NSArray arrayWithObjects:[NSString class], nil]];
    STAssertFalse(shouldFail, @"Too small heterogeneous array type checking gave no type error.");
    shouldFail = [[NSArray arrayWithObjects:@"a", @"b", nil] CTCObjectsAreKindsOfClasses:[NSArray arrayWithObject:[NSString class]]];
    STAssertFalse(shouldFail, @"Too large heterogeneous array type checking gave no type error.");
    shouldPass = [[NSArray array] CTCObjectsAreKindsOfClasses:[NSArray arrayWithObject:[NSString class]] allowAdditionalObjects:NO missingTrailingObjects:YES];
    STAssertTrue(shouldPass, @"Too small heterogeneous array type checking gave false type error when missing objects were allowed.");
    shouldPass = [[NSArray arrayWithObjects:@"a", @"b", nil] CTCObjectsAreKindsOfClasses:[NSArray arrayWithObject:[NSString class]] allowAdditionalObjects:YES missingTrailingObjects:NO];
    STAssertTrue(shouldPass, @"Too large heterogeneous array type checking gave false type error when additional objects were allowed.");
}

- (void)testHomogeneousDictionary
{
    NSDictionary *homogeneousDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"a", @"b",
                                     @"c", @"d",
                                     nil];
    NSDictionary *heterogeneousKeysDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           @"a", @"b",
                                           @"c", [NSNumber numberWithInt:5],
                                           nil];
    NSDictionary *heterogeneousObjectsDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                              @"a", @"b",
                                              [NSNumber numberWithInt:5], @"d",
                                              nil];
    NSDictionary *heterogeneousDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"a", @"b",
                                       [NSNumber numberWithInt:5], [NSNumber numberWithInt:5],
                                       nil];
    
    STAssertTrue([homogeneousDict CTCAllKeysAreKindOfClass:[NSString class]], @"Checking homogeneous keys of homogeneous dict produced invalid type error.");
    STAssertTrue([homogeneousDict CTCAllObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous objects of homogeneous dict produced invalid type error.");
    STAssertTrue([homogeneousDict CTCAllKeysAreKindOfClass:[NSString class] andObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous keys and objects of homogeneous dict produced invalid type error.");
    
    STAssertFalse([heterogeneousKeysDict CTCAllKeysAreKindOfClass:[NSString class]], @"Checking homogeneous keys of heterogeneous dict did not produce type error.");
    STAssertTrue([heterogeneousKeysDict CTCAllObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous objects of homogeneous dict produced invalid type error.");
    STAssertFalse([heterogeneousKeysDict CTCAllKeysAreKindOfClass:[NSString class] andObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous keys and objects of heterogeneous keys dict did not produce type error.");

    STAssertTrue([heterogeneousObjectsDict CTCAllKeysAreKindOfClass:[NSString class]], @"Checking homogeneous keys of heterogeneous objects dict produced invalid type error.");
    STAssertFalse([heterogeneousObjectsDict CTCAllObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous objects of heterogeneous objects dict did not produce type error.");
    STAssertFalse([heterogeneousObjectsDict CTCAllKeysAreKindOfClass:[NSString class] andObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous keys and objects of heterogeneous objects dict did not produce type error.");
    
    STAssertFalse([heterogeneousDict CTCAllKeysAreKindOfClass:[NSString class]], @"Checking homogeneous keys of heterogeneous dict did not produce type error.");
    STAssertFalse([heterogeneousDict CTCAllObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous objects of heterogeneous dict did not produce type error.");
    STAssertFalse([heterogeneousDict CTCAllKeysAreKindOfClass:[NSString class] andObjectsAreKindOfClass:[NSString class]], @"Checking homogeneous keys and objects of heterogeneous dict did not produce type error.");
}

- (void)testHeterogeneousDictionary
{
    NSDictionary *heterogeneousDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"a", @"b",
                                       [NSNumber numberWithInt:5], [NSNumber numberWithInt:5],
                                       nil];
    BOOL shouldPass = [heterogeneousDict CTCObjectsAreKindsOfClasses:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [NSString class], @"b",
                                                                      [NSNumber class], [NSNumber numberWithInt:5],
                                                                      nil]];
    STAssertTrue(shouldPass, @"Checking types in heterogeneous dictionary produced invalid type error");
    BOOL shouldFail = [heterogeneousDict CTCObjectsAreKindsOfClasses:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [NSNumber class], @"b",
                                                                      [NSNumber class], [NSNumber numberWithInt:5],
                                                                      nil]];
    STAssertFalse(shouldFail, @"Checking types in heterogeneous dictionary did not produce type error");
    shouldFail = [heterogeneousDict CTCObjectsAreKindsOfClasses:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [NSString class], @"b",
                                                                 nil]];
    STAssertFalse(shouldFail, @"Checking types in heterogeneous dictionary with extra objects did not produce type error");
    shouldFail = [heterogeneousDict CTCObjectsAreKindsOfClasses:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [NSString class], @"b",
                                                                 [NSNumber class], [NSNumber numberWithInt:5],
                                                                 [NSNumber class], @"a",
                                                                 nil]]; 
    STAssertFalse(shouldFail, @"Checking types in heterogeneous dictionary with too few objects did not produce type error");
    
    shouldPass = [heterogeneousDict CTCObjectsAreKindsOfClasses:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [NSString class], @"b",
                                                                 nil] allowAdditionalObjects:YES missingObjects:NO];
    STAssertTrue(shouldPass, @"Checking types in heterogeneous dictionary with extra objects produced invalid type error");
    shouldPass = [heterogeneousDict CTCObjectsAreKindsOfClasses:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [NSString class], @"b",
                                                                 [NSNumber class], [NSNumber numberWithInt:5],
                                                                 [NSNumber class], @"a",
                                                                 nil] allowAdditionalObjects:NO missingObjects:YES];
    STAssertTrue(shouldPass, @"Checking types in heterogeneous dictionary with too few objects produced invalid type error");
}

- (void)testHomogeneousSet
{
    BOOL shouldPass = [[NSSet setWithObjects:@"a", @"b", @"c", nil] CTCAllObjectsAreKindOfClass:[NSString class]];
    STAssertTrue(shouldPass, @"Homogeneous set type checking gave false type error.");
    shouldPass = [[NSSet set] CTCAllObjectsAreKindOfClass:[NSArray class]];
    STAssertTrue(shouldPass, @"Empty homogeneous set type checking gave false type error.");
    BOOL shouldFail = [[NSSet setWithObjects:@"a", [NSNumber numberWithInt:5], nil] CTCAllObjectsAreKindOfClass:[NSString class]];
    STAssertFalse(shouldFail, @"Homogeneous set containing incorrectly typed elements did not cause type error.");
}

@end
