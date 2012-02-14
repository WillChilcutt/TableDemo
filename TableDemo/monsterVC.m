//
//  monsterVC.m
//  TableDemo
//
//  Created by Will Chilcutt on 2/4/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import "monsterVC.h"
#import "monster.h"
#import <sqlite3.h>


@implementation monsterVC

@synthesize theMonsters = _theMonsters;

-(NSMutableArray *) monsterList
{
    self.theMonsters = [[NSMutableArray alloc] initWithCapacity:6];
    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"monster.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured: %@", sqlite3_errmsg(db));
            
        }
        
        
        const char *sql = "SELECT Name, Level, CurrentHealth FROM  userParty";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement:  %@", sqlite3_errmsg(db));
        }else{

            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                monster *aMonster = [[monster alloc] init];
                aMonster.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                aMonster.level = sqlite3_column_int(sqlStatement, 1);
                aMonster.currentHealth = sqlite3_column_int(sqlStatement, 2);
                [self.theMonsters addObject:aMonster];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %@", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
        
        return self.theMonsters;
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [self monsterList];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //Return the number of sections.
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the seciton.
    return [self.theMonsters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"monsterCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int rowCount = indexPath.row;
    
    monster *aMonster = [self.theMonsters objectAtIndex:rowCount];
    
    cell.textLabel.text = aMonster.name;
    
    NSString *cellDetails = [NSString stringWithFormat:@"Level: %d Current Health: %d ",aMonster.level, aMonster.currentHealth];
    cell.detailTextLabel.text = cellDetails;
    
    
    return cell;
}
@end
