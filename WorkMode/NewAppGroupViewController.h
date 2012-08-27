//
//  AddAppGroupControllerViewController.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NewAppGroupViewController : NSViewController
- (void) addAppGroupWithName:(NSString *)name andApps:(NSArray *)apps;
@end
