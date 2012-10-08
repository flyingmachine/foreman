//
//  LaunchGroupViewContainer.m
//  Foreman
//
//  Created by Daniel Higginbotham on 10/8/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "LaunchGroupViewContainer.h"

@implementation LaunchGroupViewContainer
-(void)shiftUp {
  NSRect frameRect = self.frame;
  frameRect.origin.y += frameRect.size.height;
  self.frame = frameRect;
}
@end
