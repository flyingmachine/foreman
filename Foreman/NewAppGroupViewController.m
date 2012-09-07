//
//  AddAppGroupControllerViewController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "NewAppGroupViewController.h"
#import "AppDelegate.h"

@implementation NewAppGroupViewController

- (void) addAppGroupWithName:(NSString *)name andApps:(NSArray *)apps {
  NSDictionary* group = @{ @"name" : name, @"apps" : apps };
  [[NSNotificationCenter defaultCenter] postNotificationName:@"addAppGroup" object:self userInfo:group];
}
@end
