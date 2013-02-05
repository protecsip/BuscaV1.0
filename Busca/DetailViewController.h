//
//  DetailViewController.h
//  Busca
//
//  Created by Alberto on 05/02/13.
//  Copyright (c) 2013 Protecmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{


    IBOutlet UIWebView *DetailWebImage;
    IBOutlet UILabel *DetailName;
    IBOutlet UILabel *DetailSurName;
    IBOutlet UILabel *DetailExt;
    IBOutlet UILabel *DetailLocation;
    IBOutlet UILabel *DetailDate;
    NSString *DetailContactoStr;
    NSString *DetailNameStr;
    NSString *DetailSurNameStr;
    NSString *DetailExtStr;
    NSString *DetailLocationStr;
    NSString *DetailDateStr;

}

@property(nonatomic,retain) NSString *DetailContactoStr;
@property(nonatomic,retain) NSString *DetailNameStr;
@property(nonatomic,retain) NSString *DetailSurNameStr;
@property(nonatomic,retain) NSString *DetailExtStr;
@property(nonatomic,retain) NSString *DetailLocationStr;
@property(nonatomic,retain) NSString *DetailDateStr;



@end
