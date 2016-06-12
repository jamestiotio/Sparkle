//
//  SUUpdaterCycle.h
//  Sparkle
//
//  Created by Mayur Pawashe on 6/11/16.
//  Copyright © 2016 Sparkle Project. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SUUpdaterCycleDelegate <NSObject>

- (void)resetUpdateCycle;

@end

// This notifies the updater for (re-)starting and canceling update cycles
// This class is used so that an updater instance isn't kept alive by a pending update cycle
@interface SUUpdaterCycle : NSObject

// This delegate is weakly referenced
- (instancetype)initWithDelegate:(id<SUUpdaterCycleDelegate>)delegate;

- (void)resetUpdateCycleAfterDelay;

- (void)cancelNextUpdateCycle;

@end

NS_ASSUME_NONNULL_END
