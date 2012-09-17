//
//  StatusItemView.m
//  Foreman
//
//  Created by Fabio Pelosin on 07/09/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "StatusItemView.h"

@implementation StatusItemView

#pragma mark -
#pragma mark NSMenu Delegate

const int QUIT_MENU_TAG = 999;
const int TOGGLE_ITEM_TAG = 499;

- (void)menuWillOpen:(NSMenu *)the_menu
{
  NSMenuItem *quitItem = [the_menu itemWithTag:QUIT_MENU_TAG];
  NSMenuItem *toggleItem = [the_menu itemWithTag:TOGGLE_ITEM_TAG];
  [the_menu removeAllItems];
  

  [the_menu addItem:toggleItem];
  [the_menu addItem:[NSMenuItem separatorItem]];
  
  [[self.dataProvider groupNamesForStatusItemView:self] enumerateObjectsUsingBlock:^(NSString* name, NSUInteger idx, BOOL *stop) {
    NSString *nameWithRank = [NSString stringWithFormat:@"%ld. %@", idx + 1, name];
    NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:nameWithRank action:@selector(menuItemAction:) keyEquivalent:@""];
    menuItem.tag = (NSInteger)idx;
    [menuItem setTarget:self];
    [menuItem setEnabled:YES];
    [the_menu addItem:menuItem];

  }];
  [the_menu addItem:[NSMenuItem separatorItem]];
  [the_menu addItem:quitItem];
  
	highlighted = YES;
	[self setNeedsDisplay:YES];
}

- (void)menuItemAction:(NSMenuItem*)sender {
  [self.dataProvider statusItemView:self didSelectGroupAtIndex:sender.tag];
}

@end
