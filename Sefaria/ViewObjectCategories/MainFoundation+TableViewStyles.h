//
//  MainFoundation+TableViewStyles.h
//  Sefaria
//
//  Created by MGM on 7/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (TableViewStyles)

- (CGFloat) tableViewHeightTwoTables:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath;
- (CGFloat) tableViewHeightForSingleTable:(UITableView *)tableView withString : (NSString*) myString;

- (CGSize) frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size;

- (UILabel*) labelForNumberRightSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell;
- (UILabel*) labelForNumberLeftSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell;

@end
