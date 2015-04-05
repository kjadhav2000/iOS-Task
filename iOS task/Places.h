//
//  Student.h
//  CoreDataDemo
//
//  Created by net admin on 07/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Places : NSManagedObject

@property (nonatomic, retain) NSString * prating;
@property (nonatomic, retain) NSString * paddress;
@property (nonatomic, retain) NSString * pname;
@property (nonatomic, retain) NSString * imageid;
@property(nonatomic)float lat;
@property(nonatomic)float lng;



@end
