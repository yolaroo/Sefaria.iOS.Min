//
//  DataControlPage.m
//  Sefaria
//
//  Created by MGM on 7/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "DataControlPageView.h"

#import "MainFoundation+DataControlPageActions.h"

#import "MainFoundation+CommentDataActions.h"

#import "MainFoundation+DeleteRecords.h"

#import "FileRecursion.h"

#import "MainFoundation+ActionsForAdvancedText.h"

#import "MainFoundation+CoreDataBuilderForGeneralExtraction.h"

#import "MainFoundation+FetchTheTextTitle.h"
#import "MainFoundation+FetchTheBookTitle.h"

#import "MainFoundation+FetchTheLineText.h"

#import "MainFoundation+SeedBuilder.h"

#import "MainFoundation+WordUseData.h"

@interface DataControlPageView ()

@end

@implementation DataControlPageView

#define RESET_DELAY 1.0
#define SEED_NAME_FULL @"x08.CDBStore"
#define SEED_NAME @"x08"


- (IBAction)seeddelete:(UIButton *)sender {
    [self deleteAction];

}

- (void) deleteAction {
    
    NSLog(@"delete action");
    __unused NSString* path = @"path";
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    __unused NSString *filePath = [documentsDirectory stringByAppendingPathComponent:SEED_NAME_FULL];
    
    
    NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:SEED_NAME withExtension:@"CDBStore"];

    [self fileExistsTest:[defaultStoreURL path]];

    
    NSError* error;
    [[NSFileManager defaultManager] removeItemAtPath: [defaultStoreURL path] error: &error];

    [self fileExistsTest:[defaultStoreURL path]];

    
    //[self saveData:self.managedObjectContext];
    
//    NSLog(@"file check");
    
//    NSURL *testdefaultStoreURL = [[NSBundle mainBundle] URLForResource:SEED_NAME withExtension:@"CDBStore"];
//    NSString* testmyPath = [defaultStoreURL absoluteString];

//    [self fileExistsTest:myPath];

    


}


- (NSURL *)tempSeedApplicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void) fileExistsTest : (NSString*)storePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathForFile = storePath;
    if ([fileManager fileExistsAtPath:pathForFile]){
        NSLog(@"exists : %@",storePath);
    }
    else {
        NSLog(@"doesnt exist : %@",storePath);
    }
}

//
////
//

- (IBAction)dataLoadButtonPress:(UIButton *)sender {
    @try {
        [self loadAllTanachData];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)commentLoadButtonPress:(UIButton *)sender {
    @try {
        [self buildCoreDataStackForComments:self.managedObjectContext];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)commentDeleteButtonPress:(UIButton *)sender {
    @try {
        [self masterCommentDelete];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)testCaseButtonPress:(UIButton *)sender {
    @try {
        //[self testTempCommentFetch];
        //[self testMishnahFileStructure];
        //[self testFetchCommentByText:self.managedObjectContext];
        [self textToWordList:self.managedObjectContext];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)textDirectoryLoadButtonPress:(UIButton *)sender {
    @try {
        FileRecursion* myFileRecursionMenu = [[FileRecursion alloc]init];
        NSArray*myArray = [myFileRecursionMenu textListOfMergeFiles];
        NSLog(@"-- %@ --",myArray);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)commentDirectoryLoadButtonPress:(UIButton *)sender {
    @try {
        FileRecursion* myFileRecursionMenu = [[FileRecursion alloc]init];
        NSArray*myArray = [myFileRecursionMenu commentListOfMergeFiles];
        NSLog(@"-- %@ --",myArray);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)allTextErrorCheckButtonPress:(UIButton *)sender {
    @try {
        [self testMenuRecursion];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)completeCommentCheck:(UIButton *)sender {
    @try {
        [self allCommentTest:self.managedObjectContext];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (IBAction)coreDataBuilderFromRecursionButtonPress:(UIButton *)sender {
    @try {
        [self completeCoreDataBuildForTexts:self.managedObjectContext];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}


- (IBAction)coreDataTitleFetchTest:(UIButton *)sender {
    NSLog(@"book title");
    [self testFetchBookTitle:self.managedObjectContext];
    NSLog(@"-- --");
    NSLog(@"-- --");
    NSLog(@"text title");
    [self testFetchTextTitle:self.managedObjectContext];

    TextTitle* ABC = [[self fetchTextTitleByNameString:@"Mishnah Eruvin" withContext:self.managedObjectContext]firstObject];
    
    NSLog(@"-- HTT %@--",ABC.hebrewName);

    //[self testFetchLineText : self.managedObjectContext];
}


//
////
//

- (IBAction)saveCDToDesktopPress:(UIButton *)sender {
    [self saveSeedToDesktop];
}

- (IBAction)deleteSourceSheetPress:(UIButton *)sender {
    [self masterSourceSheetDelete];
}



//
////
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    
    //[self performSelector:@selector(testLoad) withObject:nil afterDelay:RESET_DELAY];

    //[self testLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
