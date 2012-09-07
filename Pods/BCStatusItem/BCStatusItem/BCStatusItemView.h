//
//  BCStatusItemView.h
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BCStatusItemView;

@protocol BCStatusItemViewDelegate
- (NSDragOperation)statusItemView:(BCStatusItemView *)view draggingEntered:(id <NSDraggingInfo>)info;
- (void)statusItemView:(BCStatusItemView *)view draggingExited:(id <NSDraggingInfo>)info;
- (BOOL)statusItemView:(BCStatusItemView *)view prepareForDragOperation:(id <NSDraggingInfo>)info;
- (BOOL)statusItemView:(BCStatusItemView *)view performDragOperation:(id <NSDraggingInfo>)info;
@end

@interface BCStatusItemView : NSView<NSMenuDelegate> // TODO: ifdef this for 10.6 only
{
	NSStatusItem *parentStatusItem;
	NSMenu *menu;
	
	BOOL highlighted;
	BOOL doesHighlight;
	
	NSImage *image;
	NSImage *alternateImage;
	NSString *title;
	NSAttributedString *attributedTitle;
	
	id<BCStatusItemViewDelegate> delegate;
}

@property (assign, nonatomic) BOOL doesHighlight;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSAttributedString *attributedTitle;
@property (copy, nonatomic) NSImage *image;
@property (copy, nonatomic) NSImage *alternateImage;
@property (assign, nonatomic) id<BCStatusItemViewDelegate> delegate;
@property (nonatomic, getter = isEnabled) BOOL enabled;

+ (BCStatusItemView *)viewWithStatusItem:(NSStatusItem *)statusItem;
- (id)initWithStatusItem:(NSStatusItem *)statusItem;

//- (void)registerForDraggedTypes:(NSArray *)types;

@end
