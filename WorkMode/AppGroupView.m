//
//  AppGroupView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppGroupView.h"
#import "IconListView.h"
#import "DragReceiver.h"

@implementation AppGroupView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [NSBundle loadNibNamed:@"AppGroupView" owner:self];
      self.dragReceiver.appListController = self.controller;
      self.iconListView.appListController = self.controller;
    }
    
    return self;
}

@end
