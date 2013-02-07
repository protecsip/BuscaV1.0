//
//  ViewController.h
//  Busca
//
//  Created by Alberto on 04/02/13.
//  Copyright (c) 2013 Protecmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *NavButton;

@property (nonatomic,retain) NSMutableArray* allTableData;
@property (nonatomic, retain) NSMutableArray* filteredTableData;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;


@property (nonatomic,assign) UIColor* verde;
@property (nonatomic,assign) UIColor* rojo;


- (void)empezarAParsear:(NSData *)urlData;
- (void)CargaDatosWebService:(NSString *)Status;
- (NSString*) prepareString:(NSString*)a;


-(IBAction)Exit:(id)sender;




- (IBAction)Refrescar:(id)sender;


@end
