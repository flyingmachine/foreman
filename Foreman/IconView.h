//
//  IconView.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 9/3/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IconView : NSView
@property (strong) IBOutlet NSButton* btn;
- (void) setIcon:(NSImage *)image;
- (BOOL)selected;
- (void)setSelected:(BOOL)selected;
@end
