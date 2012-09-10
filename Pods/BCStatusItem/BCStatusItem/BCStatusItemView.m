//
//  BCStatusItemView.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "BCStatusItemView.h"

@interface BCStatusItemView(Private)
- (void)_resizeToFitIfNeeded;
@end

@implementation BCStatusItemView

@synthesize doesHighlight;
@synthesize title;
@synthesize attributedTitle;
@synthesize image;
@synthesize alternateImage;
@synthesize delegate;
@synthesize enabled;

+ (BCStatusItemView *)viewWithStatusItem:(NSStatusItem *)statusItem
{
	return [[[BCStatusItemView alloc] initWithStatusItem:statusItem] autorelease];
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat length = ([statusItem length] == NSVariableStatusItemLength) ? 32.0f : [statusItem length];
	NSRect frame = NSMakeRect(0, 0, length, [[NSStatusBar systemStatusBar] thickness]);
	if((self = [self initWithFrame:frame]))
	{
		parentStatusItem = statusItem;
		[parentStatusItem addObserver:self forKeyPath:@"length" options:NSKeyValueObservingOptionNew context:nil];
		self.title = nil;
		self.attributedTitle = nil;
		self.doesHighlight = NO;
		self.image = nil;
		self.alternateImage = nil;
		self.delegate = nil;
        self.enabled = YES;
	}
	return self;
}

- (void)dealloc
{
	[parentStatusItem removeObserver:self forKeyPath:@"length"];
	self.title = nil;
	self.attributedTitle = nil;
	self.image = nil;
	self.alternateImage = nil;
	self.delegate = nil;
	parentStatusItem = nil; // we only had weak reference
	[super dealloc];
}

- (void)_resizeToFitIfNeeded
{
    if([parentStatusItem length] == NSVariableStatusItemLength)
    {
        NSRect newFrame = [self frame];
        newFrame.size.width = [[self image] size].width + [self.attributedTitle size].width + 8;
        // 12 px padding, 6 on each side maybe? not sure what might be the usual
        [self setFrame:newFrame];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if(object == parentStatusItem && [keyPath isEqualToString:@"length"])
	{
		if([parentStatusItem length] != NSVariableStatusItemLength)
		{
			NSRect newFrame = [self frame];
			newFrame.size.width = [parentStatusItem length];
			[self setFrame:newFrame];
		}
		else
			[self _resizeToFitIfNeeded];
	}
}

#pragma mark -

- (void)setImage:(NSImage *)newImage
{
	if(newImage != image)
	{
		[image release];
		image = [newImage copy];
        [self _resizeToFitIfNeeded];
		[self setNeedsDisplay:YES];
	}
}

- (void)setAlternateImage:(NSImage *)newAltImage
{
	if(newAltImage != alternateImage)
	{
		[alternateImage release];
		alternateImage = [newAltImage copy];
		[self setNeedsDisplay:YES];
	}
}

- (void)setTitle:(NSString *)newTitle
{
	if(newTitle != title)
	{
		[title release];
		title = [newTitle copy];
		
		NSFont *font = [NSFont menuBarFontOfSize:[NSFont systemFontSize] + 2.0f]; // +2 seemed to make it look right, maybe missed a font method for menu?
		NSColor *color = [NSColor controlTextColor];
        NSMutableParagraphStyle *paragraphStyle = [[[NSMutableParagraphStyle alloc] init] autorelease];
        [paragraphStyle setAlignment:NSCenterTextAlignment];
        
		NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
							   font, NSFontAttributeName,
							   color, NSForegroundColorAttributeName,
                                paragraphStyle, NSParagraphStyleAttributeName,
							   nil];
        
		NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:self.title attributes:attributes];
		self.attributedTitle = attrTitle;
		[attrTitle release];
		
		[self setNeedsDisplay:YES];
        
        [self _resizeToFitIfNeeded];
	}
}

- (void)setAttributedTitle:(NSAttributedString *)newTitle
{
	if(newTitle != attributedTitle)
	{
		[attributedTitle release];
		attributedTitle = [newTitle copy];
		[self setNeedsDisplay:YES];
	}
}

// TODO: setAttributedTitle with default attribtues
//- (void)setTitle:(NSString *)title
//{
//	NSFont *font = [NSFont menuBarFontOfSize:[NSFont systemFontSize] + 2.0f];
//	NSColor *color = [NSColor controlTextColor];
//
//	if(mHighlighted && [self doesHighlight])
//	{
//		color = [NSColor selectedMenuItemTextColor];
//	}
//
//	NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
//						   font, NSFontAttributeName,
//						   color, NSForegroundColorAttributeName,
//						   nil];
//}

#pragma mark -

- (void)mouseDown:(NSEvent *)theEvent
{
	// TODO: implement other behaviors like support for target/action & doubleAction
    if ([parentStatusItem isEnabled]) {
        highlighted = YES;
        [self setNeedsDisplay:YES];
        [parentStatusItem popUpStatusItemMenu:[parentStatusItem menu]];
        // apparently the above blocks?
        highlighted = NO;
        [self setNeedsDisplay:YES];  
    }
}

- (void)mouseUp:(NSEvent *)theEvent
{
    highlighted = NO;
    [self setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark NSMenu Delegate

- (void)menuWillOpen:(NSMenu *)menu
{
	highlighted = YES;
	[self setNeedsDisplay:YES];
}

- (void)menuDidClose:(NSMenu *)menu
{
	highlighted = NO;
	[self setNeedsDisplay:YES];	
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect 
{
	// TODO: handle image + title, centering the combined rect with image on left
	NSImage *drawnImage = nil;
	if(highlighted && [self doesHighlight])
	{
		[[NSColor selectedMenuItemColor] set];
		[NSBezierPath fillRect:[self bounds]];
		drawnImage = self.alternateImage;
	}
	else
		drawnImage = self.image;
	
	NSRect centeredRect = NSMakeRect(0, 0, 0, 0);
	if(drawnImage) {
		centeredRect = NSMakeRect(0, 0, [drawnImage size].width, [drawnImage size].height);
		
		// align left if we have a title
		if(self.attributedTitle) {
			centeredRect.origin.x = 2;
		}
		else
			centeredRect.origin.x = NSMidX([self bounds]) - ([drawnImage size].width / 2);
		
		centeredRect.origin.y = NSMidY([self bounds]) - ([drawnImage size].height / 2);
		centeredRect = NSIntegralRect(centeredRect);
		[drawnImage drawInRect:centeredRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	
	if(self.attributedTitle)
	{
		NSRect titleRect = NSMakeRect(2 + centeredRect.size.width, centeredRect.origin.y - 1, [self bounds].size.width - (centeredRect.size.width + 2) , [self bounds].size.height - centeredRect.origin.y);
		NSMutableAttributedString *attrTitle = [self.attributedTitle mutableCopy];
		if(highlighted && [self doesHighlight])
		{
			NSColor *color = [NSColor selectedMenuItemTextColor];
			[attrTitle addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [attrTitle length])];
		}
		else {
			NSShadow *textShadow = [[NSShadow alloc] init];
			[textShadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0f alpha:0.6f]];
			[textShadow setShadowOffset:NSMakeSize(0, -1)];
			[attrTitle addAttribute:NSShadowAttributeName value:textShadow range:NSMakeRange(0, [attrTitle length])];
			[textShadow release];
		}
		[attrTitle drawInRect:titleRect];
		[attrTitle release];
	}
}

#pragma mark -
#pragma mark NSDraggingDestination protocol

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	return [delegate statusItemView:self draggingEntered:sender];
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	[delegate statusItemView:self draggingExited:sender];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{	
	return [delegate statusItemView:self prepareForDragOperation:sender];
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	return [delegate statusItemView:self performDragOperation:sender];
}

@end
