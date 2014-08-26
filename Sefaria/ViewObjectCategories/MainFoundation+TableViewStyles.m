//
//  MainFoundation+TableViewStyles.m
//  Sefaria
//
//  Created by MGM on 7/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+TableViewStyles.h"
#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+CommentStyle.h"

@implementation MainFoundation (TableViewStyles)

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400
#define COMMENT_TAG 600
#define SEARCH_TAG 700
#define CELL_CONTENT_WIDTH 380.0f
#define WIDE_CELL_CONTENT_WIDTH 550.0f
#define CELL_PADDING 30.0f

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]
#define IPAD_FONT_XTLARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.8]

#define ACC_FONT_NAME @"HelveticaNeue-Light"
#define ACC_FONT_SIZE 10.0

//
//
////////
#pragma mark - Cell number
////////
//
//

- (NSInteger) tableViewCellNumberForCoreData:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == MENU_TAG){
        return [self.menuListArray count] ? [self.menuListArray count] : 0;
    }
    else if (tableView.tag == CHAPTER_TAG) {
        return [self.chapterListArray count] ? [self.chapterListArray count] : 0;
    }
    else if (tableView.tag == ENGLISH_TAG){
        return [self.primaryDataArray count] ? [self.primaryDataArray count] : 0;
    }
    else if (tableView.tag == HEBREW_TAG){
        return [self.primaryDataArray count] ? [self.primaryDataArray count] : 0;
    }
    else if (tableView.tag == COMMENT_TAG){
        return [self.commentArray count] ? [self.commentArray count] : 0;
    }
    else if (tableView.tag == SEARCH_TAG){
        return [self.searchTextArray count] ? [self.searchTextArray count] : 0;
    }
    else {
        NSLog(@"Error on cell load");
        return 0;
    }
}

- (NSInteger) tableViewCellNumberForREST:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == MENU_TAG){
        return [self.menuListArray count] ? [self.menuListArray count] : 0;
    }
    else if (tableView.tag == ENGLISH_TAG) {
        return [self.primaryEnglishTextArray count] ? [self.primaryEnglishTextArray count] : 0;
    }
    else if (tableView.tag == HEBREW_TAG) {
        return [self.primaryHebrewTextArray count] ? [self.primaryHebrewTextArray count] : 0;
    }
    else if (tableView.tag == CHAPTER_TAG) {
        return [self.chapterListArray count] ? [self.chapterListArray count] : 0;
    }
    else {
        NSLog(@"Error on cell load");
        return 0;
    }
}

//
//
////////
#pragma mark - Accessory Label
////////
//
//

- (UILabel*) labelForNumberRightSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell
{
    CGRect myRect = CGRectMake(0,0,30,cell.frame.size.height);
    UILabel* myLabel = [[UILabel alloc]initWithFrame:myRect];
    NSString* myLineNumber = [NSString stringWithFormat:@"%ld",indexPathRow+1];
    myLabel.text = myLineNumber;
    myLabel.textColor = [UIColor grayColor];
    myLabel.font = [UIFont fontWithName: ACC_FONT_NAME size:ACC_FONT_SIZE];
    myLabel.textAlignment = NSTextAlignmentNatural;
    return myLabel;
}

- (UILabel*) labelForNumberLeftSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell
{
    CGRect myRect = CGRectMake(0,0,30,cell.frame.size.height);
    UILabel* myLabel = [[UILabel alloc]initWithFrame:myRect];
    NSString* myLineNumber = [NSString stringWithFormat:@"%ld",indexPathRow+1];
    myLabel.text = myLineNumber;
    myLabel.textColor = [UIColor grayColor];
    myLabel.font = [UIFont fontWithName: ACC_FONT_NAME size:ACC_FONT_SIZE];
    myLabel.textAlignment = NSTextAlignmentNatural;
    myLabel.tag = 5000;
    return myLabel;
}

//
//
////////
#pragma mark - TableView
////////
//
//

- (CGFloat)tableViewHeightForCoreData:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath
{
    if (tableView.tag == ENGLISH_TAG || tableView.tag == HEBREW_TAG) {
        return [self dualLanguagetableViewHeight:tableView cellForRowAtIndexPath:indexPath];
    }
    else if (tableView.tag == SEARCH_TAG){
        CGSize sizeEnglish;
        NSString* myString;
        if ([self.searchTextArray count] > indexPath.row) {
            myString = [self.searchTextArray objectAtIndex:indexPath.row];
        }
        if ([myString length]) {
            UIFont *myFont = [ UIFont fontWithName: FONT_NAME size: FONT_SIZE ];
            sizeEnglish = [self frameForText: myString sizeWithFont:myFont constrainedToSize:CGSizeMake(WIDE_CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
            return sizeEnglish.height*1.1+CELL_PADDING+10;
        }
        else {
            return 55.0;
        }
    }
    else{
        return 55.0;
    }
}

- (double) theCurrentWidth {
    if (self.isWideView) {
        return WIDE_CELL_CONTENT_WIDTH;
    } else {
        return CELL_CONTENT_WIDTH;
    }
}

- (CGFloat)dualLanguagetableViewHeight:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath
{
    NSInteger sizeEnglish;
    NSInteger sizeHebrew;
    NSString* myStringEnglish;
    NSString* myStringHebrew;
    if ([self.primaryDataArray count] > indexPath.row){
        myStringEnglish = [self englishTextFromObject:indexPath];
        myStringHebrew = [self hebrewTextFromObject:indexPath];
    }
    if ([myStringEnglish length] || [myStringHebrew length]){
        if (self.self.fontSizeLargeSet) {
            CGSize myCGSizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT_LARGE constrainedToSize:CGSizeMake([self theCurrentWidth], CGFLOAT_MAX)];
            CGSize myCGSsizeHebrew = [self frameForText:myStringHebrew sizeWithFont:IPAD_FONT_XTLARGE constrainedToSize:CGSizeMake([self theCurrentWidth], CGFLOAT_MAX)];
            sizeEnglish = myCGSizeEnglish.height*1.3;
            sizeHebrew = myCGSsizeHebrew.height*1.3;
        }
        else {
            CGSize  myCGSizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT constrainedToSize:CGSizeMake([self theCurrentWidth], CGFLOAT_MAX)];
            CGSize  myCGSizeHebrew = [self frameForText:myStringHebrew sizeWithFont:IPAD_FONT_LARGE constrainedToSize:CGSizeMake([self theCurrentWidth], CGFLOAT_MAX)];
            sizeEnglish = myCGSizeEnglish.height;
            sizeHebrew = myCGSizeHebrew.height;
        }
        if (sizeEnglish > sizeHebrew) {
            //NSLog(@"-- 0.0english EH: %ld HH:  %ld --",(long)sizeEnglish,(long)sizeHebrew);
            return sizeEnglish+CELL_PADDING;
        }
        else {
            //NSLog(@"-- 0.1hebrew EH: %ld HH:  %ld --",(long)sizeEnglish,(long)sizeHebrew);
            return sizeHebrew+CELL_PADDING;
        }
    }
    else {
        return 55.0;
    }
}

//
////
//

- (CGFloat)tableViewHeightTwoTables:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath
{
    if (tableView.tag == ENGLISH_TAG || tableView.tag == HEBREW_TAG) {
        CGSize sizeHebrew;
        CGSize sizeEnglish;
        if (indexPath.row < [self.primaryEnglishTextArray count]) {

            NSString* myStringEnglish = [self.primaryEnglishTextArray objectAtIndex:indexPath.row];
            sizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
        }
        if (indexPath.row < [self.primaryHebrewTextArray count]) {

            NSString* myStringHebrew = [self.primaryHebrewTextArray objectAtIndex:indexPath.row];
            sizeHebrew = [self frameForText:myStringHebrew sizeWithFont:IPAD_FONT_LARGE constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
        }
        if (sizeEnglish.height > sizeHebrew.height) {
            return sizeEnglish.height + CELL_PADDING;
        } else {
            return sizeHebrew.height + CELL_PADDING;
        }
    }
    else {
        return 55.0;
    }
}

//
////
//

- (CGFloat) commentHeight : (NSIndexPath *)indexPath
{
    CGSize sizeComment;
    NSString* myString;
    if ([self.commentArray count] > indexPath.row) {
        Comment* myComment = [self.commentArray objectAtIndex:indexPath.row];
        myString = [self commentTextFromObject:myComment];
    }
    if ([myString length]) {
        UIFont *myFont = IPAD_FONT;
        sizeComment = [self frameForText: myString sizeWithFont:myFont constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
        return sizeComment.height*1.1 + CELL_PADDING;
    }
    else {
        return 55.0;
    }
}

//
//
////////
#pragma mark - Frame
////////
//
//

- (CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin)
                                   attributes:attributesDictionary
                                      context:nil];
    return frame.size;
}


@end
