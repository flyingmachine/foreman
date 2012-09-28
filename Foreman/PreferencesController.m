//
//  PreferencesController.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/27/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "PreferencesController.h"
#import "Headers.h"

@implementation PreferencesController

- (id)init {
  self = [super init];
  if (self) {
    userDefaults = [NSUserDefaults standardUserDefaults];
  }
  return self;
}

- (BOOL)shortcutRecorder:(SRRecorderControl *)aRecorder isKeyCode:(NSInteger)keyCode andFlagsTaken:(NSUInteger)flags reason:(NSString **)aReason {
	return NO;
}

- (void)shortcutRecorder:(SRRecorderControl *)aRecorder keyComboDidChange:(KeyCombo)newKeyCombo {
  userDefaults = [NSUserDefaults standardUserDefaults];
  hotKeyCenter = [PTHotKeyCenter sharedCenter];
  
  signed short code = newKeyCombo.code;
  NSUInteger flags = [aRecorder cocoaToCarbonFlags:newKeyCombo.flags];
  akeyCombo = [[PTKeyCombo alloc] initWithKeyCode:code modifiers:flags];
  
  if (aRecorder == shortcutRecorder) {
    NSLog(@"yes");
    [hotKeyCenter unregisterHotKey:otherHotKey]; // The Key to happiness
    
    otherHotKey = [[PTHotKey alloc] initWithIdentifier:[userDefaults objectForKey:@"globalShortcut"] keyCombo:akeyCombo];
    [userDefaults setObject:[akeyCombo plistRepresentation] forKey:@"globalShortcut"];
    [otherHotKey setTarget:[App delegate]];
    [otherHotKey setAction:@selector(toggle:)];
    [hotKeyCenter registerHotKey:otherHotKey];
  }
  //    if (newKeyCombo.code == ShortcutRecorderEmptyCode & newKeyCombo.flags == ShortcutRecorderEmptyFlags) {
  //    }
  
  [userDefaults synchronize];
}

+ (BOOL)universalAccessNeedsToBeTurnedOn {
  if (!AXAPIEnabled()) {
    NSString *message = NSLocalizedString(@"To use global hotkeys you must \"Enable access for assistive devices\" in the Universal Access preferences pane.", nil);
    NSUInteger result = NSRunAlertPanel(message, @"", NSLocalizedString(@"OK", nil), NSLocalizedString(@"Quit", nil), NSLocalizedString(@"Cancel", nil));
    
    switch (result) {
      case NSAlertDefaultReturn:
        [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/UniversalAccessPref.prefPane"];
        break;
        
      case NSAlertAlternateReturn:
        [NSApp terminate:self];
        break;
    }
    return YES;
  } else {
    return NO;
  }
}


- (void)windowDidBecomeKey:(NSNotification *)notification {
  PTKeyCombo *keys = [[PTKeyCombo alloc] initWithPlistRepresentation:[userDefaults objectForKey:@"globalShortcut"]];
  KeyCombo someKeyCombo = SRMakeKeyCombo([keys keyCode], SRCarbonToCocoaFlags([keys modifiers]));
  [shortcutRecorder setKeyCombo:someKeyCombo];
}
@end
