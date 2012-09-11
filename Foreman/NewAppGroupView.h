#import <Cocoa/Cocoa.h>
#import "AppReceiver.h"

@class NewAppGroupViewController;

@interface NewAppGroupView : AppReceiver
@property (strong) IBOutlet NewAppGroupViewController* controller;
@end