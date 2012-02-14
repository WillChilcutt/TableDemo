//
//  monsterVC.h
//  TableDemo
//
//  Created by Will Chilcutt on 2/4/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface monsterVC : UITableViewController
{
    NSMutableArray *theMonsters;
    sqlite3 *db;
}

@property (nonatomic, retain) NSMutableArray *theMonsters;

-(NSMutableArray *) monsterList;

@end
