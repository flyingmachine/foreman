//
//  NSStatusItem+BCStatusItem.h
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BCStatusItemView;

@interface NSStatusItem(BCStatusItem)

/**
 * Sets up a BCStatusItemView, copies needed NSStatusItem properties and sets the view on the status item
 * Call this after you do any of these: setImage, setAlternateImage, setTitle, setAttributedTitle, setHighlightMode
 */
- (void)setupView;

- (void)setAllowsDragging:(BOOL)dragging;
- (void)setDraggingTypes:(NSArray *)types;
- (NSArray *)draggingTypes;

/**
 * Convenience method which gets the window frame for the custom NSStatusItem view
 */
@property (nonatomic, readonly) NSRect frame;

/**
 * Sets the view's delegate, convenience method 
 */
- (void)setViewDelegate:(id)delegate;

@end
