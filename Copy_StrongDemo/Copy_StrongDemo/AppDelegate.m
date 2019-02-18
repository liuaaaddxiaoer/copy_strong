//
//  AppDelegate.m
//  Copy_StrongDemo
//
//  Created by 小2 on 2019/2/18.
//  Copyright © 2019 小2. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property(nonatomic, strong) NSString *testStrongStr;
@property(nonatomic, copy) NSString *testCopyStr;

@property(nonatomic, strong) NSMutableString *testMutStr;
@property(nonatomic, copy) NSMutableString *testMutCopyStr;

@property(nonatomic, strong) NSArray *testArr;
@property(nonatomic, copy) NSArray *testCopyArr;

@property(nonatomic, strong) NSMutableArray *testMutArr;
@property(nonatomic, copy) NSMutableArray *testMutCopArr;



@property(nonatomic, strong) NSMutableDictionary *testDic;
@property(nonatomic, copy) NSMutableDictionary *testCopyDic;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *str = @"haha";
    
    self.testStrongStr = str;
    self.testCopyStr = str;
    
    NSLog(@"%p---%p---%p",str,_testStrongStr,_testCopyStr);
    
    
    NSMutableString *mutaStr = [[NSMutableString alloc] initWithString:@"mutaStr"];
    
    self.testStrongStr = mutaStr;
    self.testCopyStr = [mutaStr mutableCopy];
    
    [mutaStr appendString:@"--222"];
    
    
    NSLog(@"%p---%p---%p",mutaStr,_testStrongStr,_testCopyStr);
    NSLog(@"\n%@---%@---%@",mutaStr,_testStrongStr,_testCopyStr);
    
    NSArray *arr = @[@1,@2];
    self.testArr = arr;
    self.testCopyArr = arr;
    NSLog(@"%p---%p---%p",arr,_testArr,_testCopyArr);
    
    NSMutableArray *arr2 = [NSMutableArray arrayWithArray:@[@1,@2]];
    self.testArr = arr2;
    self.testCopyArr = arr2;
    
    [arr2 addObject:@3];
    
    NSLog(@"%p---%p---%p",arr2,_testArr,_testCopyArr);
    NSLog(@"%@---%@---%@",arr2,_testArr,_testCopyArr);
    
    
    NSArray *arr3 = @[@1,@2];
    self.testArr = [arr3 mutableCopy];
    self.testCopyArr = [arr3 mutableCopy];
    NSLog(@"%p---%p---%p",arr3,_testArr,_testCopyArr);
    
    
    NSDictionary *dict = @{@1:@2,@3:@4};
    self.testDic = dict;
    self.testCopyDic = [dict mutableCopy];
    NSLog(@"%p---%p---%p",dict,_testDic,_testCopyDic);
    
//    [self.testCopyDic setObject:@5 forKey:@4];
    
    
    NSArray *arr4 = @[@1,@2];
    self.testMutArr = [arr4 copy];
    self.testMutCopArr = [arr4 mutableCopy];
    NSLog(@"%p---%p---%p",arr4,_testMutArr,_testMutCopArr);
    
    NSMutableArray *arr5 = [NSMutableArray arrayWithArray:@[@1]];
    self.testMutArr = [arr5 copy];
    self.testMutCopArr = [arr5 mutableCopy];
    NSLog(@"%p---%p---%p",arr5,_testMutArr,_testMutCopArr);
    
    NSString *str6 = @"str";
    self.testMutStr = str6;
    self.testMutCopyStr = str6;
    
    self.testMutStr = [str6 mutableCopy];
    self.testMutCopyStr = [str6 mutableCopy];
    
    NSMutableString *muStr = [[NSMutableString alloc] initWithString:@"mutStr"];
    
    NSLog(@"%p---%p---%p",str6,_testMutStr,_testMutCopyStr);
    
    [self.testMutStr appendString:@"1"];
//    self.testMutCopyStr
//    [self.testMutCopyStr appendString:@2];
    
    NSString *tagPointerStr = [NSString stringWithFormat:@"1"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
