//
//  monster.h
//  TableDemo
//
//  Created by Will Chilcutt on 2/4/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface monster : NSObject
{
    NSString *name;
    int level;
    int currentHealth;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int level;
@property (nonatomic, assign) int currentHealth;

@end
