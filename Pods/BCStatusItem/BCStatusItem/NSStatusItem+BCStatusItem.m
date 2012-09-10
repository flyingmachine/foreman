//
//  NSStatusItem+BCStatusItem.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "NSStatusItem+BCStatusItem.h"
#import "BCStatusItemView.h"

//@interface NSStatusItem(Private)
//- (BCStatusItemView *)view;
//@end


@implementation NSStatusItem(BCStatusItem)

- (void)setupView
{
	BCStatusItemView *view = [BCStatusItemView viewWithStatusItem:self];
//	// grab the statu item's various vars that get cleared upon setView:
//	[view setImage:[self image]];
//	[view setAlternateImage:[self alternateImage]];
//	[view setAttributedTitle:[self attributedTitle]];
//	[view setDoesHighlight:[self highlightMode]];
	[self setView:view];
	
	// view becomes delegate for highlighting purposes, this isn't ideal for all cases
	[[self menu] setDelegate:view];
}

- (void)setAllowsDragging:(BOOL)dragging
{
	
}

- (void)setDraggingTypes:(NSArray *)types
{
}

- (NSArray *)draggingTypes
{
	return nil;
}

- (NSRect)frame
{
	return [[[self view] window] frame];
}

- (void)setViewDelegate:(id)delegate
{
	if([[self view] respondsToSelector:@selector(setDelegate:)])
		[(BCStatusItemView *)[self view] setDelegate:delegate];
}

#pragma mark -
#pragma mark Overrides

// our view replaces all drawing/etc. of NSStatusItem so we forward any related changes on to it
// TODO: we should do method swizzling or something to not block original methods

- (void)setImage:(NSImage *)image
{
	[(BCStatusItemView *)[self view] setImage:image];
}

- (void)setAlternateImage:(NSImage *)image
{
	[(BCStatusItemView *)[self view] setAlternateImage:image];
}

- (void)setHighlightMode:(BOOL)highlightMode
{
	[(BCStatusItemView *)[self view] setDoesHighlight:highlightMode];
}

- (void)setTitle:(NSString *)title
{
	[(BCStatusItemView *)[self view] setTitle:title];
}

- (void)setAttributedTitle:(NSAttributedString *)attrTitle
{
	[(BCStatusItemView *)[self view] setAttributedTitle:attrTitle];
}

- (BOOL)isEnabled {
    return [(BCStatusItemView *)[self view] isEnabled];
}

- (void)setEnabled:(BOOL)enabled {
    [(BCStatusItemView *)[self view] setEnabled:enabled];
}

@end
