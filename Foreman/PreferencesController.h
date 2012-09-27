//
//  PreferencesController.h
//  Foreman
//
//  Created by Daniel Higginbotham on 9/27/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShortcutRecorder/ShortcutRecorder.h>
#import "PTHotKey.h"
#import "PTHotKeyCenter.h"

@interface PreferencesController : NSObject {
  IBOutlet SRRecorderControl *shortcutRecorder;
  
  PTHotKey *globalHotKey;
  PTKeyCombo *akeyCombo;
  PTHotKey *hotKey;
  PTHotKey *otherHotKey;
  PTHotKeyCenter *hotKeyCenter;
  NSUserDefaults *userDefaults;
}

+ (BOOL)universalAccessNeedsToBeTurnedOn;

@end
