//
//  CartesDeckAppDelegate.h
//  CartesDeck
//
//  Created by Tom Hartley on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartesDeckViewController;

@interface CartesDeckAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CartesDeckViewController *viewController;

@end
