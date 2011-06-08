//
//  THCardsViewController.h
//  Cartes
//
//  Created by Tom Hartley on 01/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THServerConnection.h"

@interface THCardsViewController : UITableViewController {
    THServerConnection *connection;
}

- (id)initWithConnection:(THServerConnection *)theConnection;

@end
