//
//  OSESaveNoteViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 2/3/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSESaveNoteViewController.h"

@interface OSESaveNoteViewController ()

@property Note *note;
@property OSENotesManager *notesManager;
@property UITextView *noteField;

@end

@implementation OSESaveNoteViewController

- (id)initWithNote:(Note *)note andNotesManager:(OSENotesManager *)notesManager;
{
    self = [super init];
    if (self) {
        self.note = note;
        self.notesManager = notesManager;
    }
    return self;
}

- (id)initWithDateManager:(OSEDateManager *)dateManager andNotesManager:(OSENotesManager *)notesManager;
{
    self = [super init];
    if (self) {
        self.dateManager = dateManager;
        self.notesManager = notesManager;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect frame = self.view.frame;
    self.noteField = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.noteField.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.noteField];
    
    // Done Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveNote:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks - first responders

- (void)saveNote:(id)sender
{
    if (!self.note)
        self.note = [self.notesManager addNoteWithDate:self.dateManager.date];
    
    [self.notesManager saveNote:self.note withText:self.noteField.text];
    
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
