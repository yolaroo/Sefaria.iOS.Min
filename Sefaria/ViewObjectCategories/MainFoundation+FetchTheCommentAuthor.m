//
//  MainFoundation+FetchTheCommentAuthor.m
//  Sefaria
//
//  Created by MGM on 8/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTheCommentAuthor.h"

@implementation MainFoundation (FetchTheCommentAuthor)


- (NSArray*) fetchAllCommentAuthors : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"CommentAuthor" inManagedObjectContext:context];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

@end
