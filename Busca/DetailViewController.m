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
@synthesize DetailComent;


-(IBAction)hideKeyboard:(id)Sender
{
    
    [DetailComent resignFirstResponder];
}

-(IBAction)GuardarComentario:(id)sender{
    
   // NSString *parametros = ;
   
    [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://10.15.30.124/webservicebusca/busca.asmx/Guardar_Comentario?Parametros=",[NSString stringWithFormat:@"%@%@%@", DetailContactoStr,@",",DetailComent.text]]]];
    
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
    
    NSString *web = @"http://10.15.30.124/_SIP/shared/imagen.aspx?cn=";
    NSString *contacto = DetailContactoStr;
    NSString *webCompleta = [NSString stringWithFormat:@"%@%@", web,contacto];
 
    NSString *html =[NSString stringWithFormat:@"%@%@%@", @"<img src='",webCompleta,@"' width='100%' height='100%'></img>"];
    

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
    
    
    [self.DetailComent becomeFirstResponder];
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
  //Actualizar ComentarioBusca







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
