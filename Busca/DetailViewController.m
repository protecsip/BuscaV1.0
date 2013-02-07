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
@synthesize DetailComentStr;
@synthesize Color;



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
 
    NSString *html =[NSString stringWithFormat:@"%@%@%@", @"<img src='",webCompleta,@"' width='100%' height='100%'></img>"];
    

    
        /*
         
     NSString *urlAddress = html;
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    
    [DetailWebImage loadRequest:requestObj];
    
     
    
    
    NSString *strTemplateHTML = [NSString stringWithFormat:@"<html><head><style>img{max-width:100%%;height:auto !important;width:auto !important;};</style></head><body style='margin:0; padding:0;'>%@</body></html>", @"http://10.15.30.124/_SIP/shared/imagen.aspx?cn=50699"];
   
        */
    
    NSString *strTemplateHTML = [NSString stringWithFormat:@"<html><body style='margin:0; padding:0;'>%@</body></html>", html];
    
    
    [DetailWebImage loadHTMLString:strTemplateHTML baseURL:nil];
  
    DetailName.text = DetailNameStr;
    DetailSurName.text = DetailSurNameStr;
    DetailExt.text = DetailExtStr;
    DetailLocation.text = DetailLocationStr;
    DetailDate.text = DetailDateStr;
    DetailComent.text = DetailComentStr;
    
    
    if([Color isEqualToString:(@"rojo")]==1)
    {
        DetailLocation.textColor = [UIColor redColor];
        DetailDate.textColor =[UIColor redColor];
    }else{
        DetailLocation.textColor = [UIColor blueColor];
        DetailDate.textColor = [UIColor blueColor];
    }
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
  //Actualizar ComentarioBusca

- (IBAction)GrabarComentarioBusca:(UIBarButtonItem *)sender {
    NSString *parametros = [NSString stringWithFormat:@"%@%@%@", DetailContactoStr,@",",DetailComent.text];
    
    
    // NSURL *urlComent = [NSURL URLWithString:@"http://10.15.30.124/webservicebusca/busca.asmx/Guardar_Comentario?Parametros="];
    
    NSString *urlComent0 = [NSString stringWithFormat:@"%@%@", @"http://10.15.30.124/webservicebusca/busca.asmx/Guardar_Comentario?Parametros=",parametros];
    
    NSURL *urlComent =[NSURL URLWithString:urlComent0];
    
    [NSData dataWithContentsOfURL:urlComent];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
