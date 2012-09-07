//
//  StatusItemView.h
//  Foreman
//
//  Created by Fabio Pelosin on 07/09/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "BCStatusItemView.h"
@class StatusItemView;
@protocol StatusItemViewDataProvier
@required
- (NSArray*)groupNamesForStatusItemView:(StatusItemView *)view;
- (void)statusItemView:(StatusItemView *)view didSelectGroupAtIndex:(NSInteger)index;

@end

@interface StatusItemView : BCStatusItemView

@property id<StatusItemViewDataProvier> dataProvider;

@end
