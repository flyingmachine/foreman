//
//  AppGroupView.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DragReceiver;

@interface AppGroupViewNode : NSObject
{
  IBOutlet NSView* rootView;
  IBOutlet AppGroupController* controller;
}

-(void)loadUIFromNib;

@end
