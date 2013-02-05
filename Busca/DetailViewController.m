//
//  DetailViewController.m
//  Busca
//
//  Created by Alberto on 05/02/13.
//  Copyright (c) 2013 Protecmedia. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end



@implementation DetailViewController

@synthesize DetailContactoStr;
@synthesize DetailNameStr;
@synthesize DetailSurNameStr;
@synthesize DetailExtStr;
@synthesize DetailLocationStr;
@synthesize DetailDateStr;

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
    
    NSString *web = @"http://10.15.30.124/_SIP/shared/imagen.aspx?cn=";
    NSString *contacto = DetailContactoStr;
    NSString *webCompleta = [NSString stringWithFormat:@"%@%@", web,contacto];
    NSString *urlAddress = webCompleta;
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    
    [DetailWebImage loadRequest:requestObj];
    
    

    
    
    DetailName.text = DetailNameStr;
    DetailSurName.text = DetailSurNameStr;
    DetailExt.text = DetailExtStr;
    DetailLocation.text = DetailLocationStr;
    DetailDate.text = DetailDateStr;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
