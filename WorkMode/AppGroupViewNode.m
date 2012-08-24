//
//  AppGroupView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppGroupViewNode.h"


@implementation AppGroupViewNode

- (void)loadUIFromNib
{
    [NSBundle loadNibNamed:@"AppGroupView" owner:self];
}

@end
