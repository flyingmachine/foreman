//
//  IconViewController.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 9/2/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class AppGroupController;
@interface IconViewController : NSViewController
@property (strong) AppGroupController* appGroupController;
@property (strong) NSString* app;
@property (strong) IBOutlet NSImageView* imgView;

- (IBAction)removeApp:(id)sender;
- (void)setup:(float)leftMargin app:(NSString *)app appGroupController:(AppGroupController *)agc;
@end
