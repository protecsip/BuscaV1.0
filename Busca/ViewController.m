//
//  ViewController.m
//  Busca
//
//  Created by Alberto on 04/02/13.
//  Copyright (c) 2013 Protecmedia. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController


// Siempre que se declara variables en el header ".h" para poder
// usaralas el el main ".m" se debe hacer un synthesize


@synthesize allTableData;
@synthesize filteredTableData;
@synthesize searchBar;
@synthesize NavButton;
@synthesize isFiltered;
@synthesize verde;
@synthesize rojo;


// Aqui pasa nada mas anrrancar la aplicacion procedente del main de la aplicacion.

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    
    /*UIBarButtonItem *NavButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(GuardarComentario;)];
                                                                                                                                            
    */
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    verde = [UIColor colorWithRed:0 green:0.4 blue:0.2 alpha:1];
    rojo = [UIColor colorWithRed:0.6 green:0 blue:0 alpha:1];
    
    [self CargaDatosWebService:@"Prueba"];
    
    
    // Liberar memoria
    
    
    
    
}

-(void) GuardarComentario:(id)sender{

}


- (void)refresh:(UIRefreshControl *)sender {
    // ... código de refresco
    
    [self CargaDatosWebService:@"Prueba"];

    
    [sender endRefreshing];
}


-(void)CargaDatosWebService:(NSString *)Status
{
    
    
    // indicamos la url desde donde tomaremos los datos
    NSURL *url = [NSURL URLWithString:@"http://10.15.30.124/webservicebusca/busca.asmx/GetDatosJSON"];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    searchBar.delegate = (id)self;
    
    
    [self empezarAParsear:urlData];
    
    
}

#pragma mark - Custom methods


// Aqui se crean funciones a las que se llaman para la obtencion de datos.

- (void)empezarAParsear:(NSData *)urlData
{
    NSError *error = nil;
    
    // parseamos los datos de la URL
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:urlData
                                                            options:kNilOptions
                                                              error:&error];
    
    // si hubo algún error en el parseo lo mostramos
    if (error != nil)
    {
        NSLog(@"ERROR: %@", [error localizedDescription]);
    }
    else {
        
        self.allTableData = [jsonDic objectForKey:@"Table"];
        
        
    }
}


//Cuando se relacciona en el storyboard a data source pasa por aki
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int rowCount;
    
    if(self.isFiltered)
        rowCount = [self.filteredTableData count];
    else
        rowCount =  [self.allTableData count];
    
    
    
    
    return rowCount;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    /*
     
     DescripcionContacto* descripcioncontacto;
     
     */
    NSDictionary *datos;
    
    
    if(isFiltered){
        datos = [self.filteredTableData objectAtIndex:indexPath.row];
    }
    else{
        datos = [self.allTableData objectAtIndex:indexPath.row];
    }
    
    
    
    //Proceso de relleno de TableView
    
    NSString *Separador = @", ";
    
    NSString *Nombre = [datos objectForKey:@"NOMBRE"];
    NSString *Apellidos = [datos objectForKey:@"APELLIDOS"];
    NSString *Color = [datos objectForKey:@"COLOR"];
    
    NSString *Titulo = [[NSString alloc] initWithFormat:@"%@%@%@",Apellidos,Separador,Nombre];
    
    NSString *Fecha =[datos objectForKey:@"FECHABD"];
    
    
    Fecha =[Fecha stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    
    NSString *dateStr = Fecha;
    NSDateFormatter *dtF = [[NSDateFormatter alloc] init];
    [dtF setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d = [dtF dateFromString:dateStr];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yy HH:mm:ss"];
    NSString *st = [dateFormat stringFromDate:d];
    
    Fecha = st;
    
    NSString *Localizacion = [datos objectForKey:@"DSLOCALIZACION"];
    NSString *Extension = [datos objectForKey:@"EXTENSION"];
    NSString *Comentario = [datos objectForKey:@"COMENTARIO"];
    
    
    
    NSString *SubTitulo = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@",Fecha,Separador,Localizacion,Separador,Extension,Separador,Comentario];
    
    cell.textLabel.text = Titulo;
    cell.detailTextLabel.text = SubTitulo;
    
    if([Color isEqualToString:(@"rojo")]==1)
    {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }else{
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    DetailViewController *detail = [[DetailViewController alloc] initWithNibName:@"DetailViewController"  bundle:nil];
    

    
    NSDictionary *datos;
    
    
    if(isFiltered){
        datos = [self.filteredTableData objectAtIndex:indexPath.row];
    }
    else{
        datos = [self.allTableData objectAtIndex:indexPath.row];
    }

    
    
    
    
    detail.DetailNameStr = [[NSString alloc] initWithString:[datos objectForKey:@"NOMBRE"]];
    
    detail.DetailSurNameStr = [[NSString alloc] initWithString:[datos objectForKey:@"APELLIDOS"]];
    
    detail.DetailExtStr = [[NSString alloc] initWithString:[datos objectForKey:@"EXTENSION"]];
    
    detail.DetailLocationStr = [[NSString alloc] initWithString:[datos objectForKey:@"DSLOCALIZACION"]];
    
    detail.DetailContactoStr = [[NSString alloc] initWithString:[datos objectForKey:@"CDCONTACTO"]];
    
    
    detail.Color = [[NSString alloc] initWithString:[datos objectForKey:@"COLOR"]];
    
     detail.DetailComentStr = [[NSString alloc] initWithString:[datos objectForKey:@"COMENTARIO"]];
    
    NSString *Fecha =[datos objectForKey:@"FECHABD"];
    
    
    Fecha =[Fecha stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    
    NSString *dateStr = Fecha;
    NSDateFormatter *dtF = [[NSDateFormatter alloc] init];
    [dtF setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d = [dtF dateFromString:dateStr];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yy HH:mm:ss"];
    NSString *st = [dateFormat stringFromDate:d];
    
    Fecha = st;


    
    detail.DetailDateStr = [[NSString alloc] initWithString:Fecha];
    
        [self.navigationController pushViewController:detail animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//Parte especial para la busqueda


-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    text = [self prepareString:text];
    
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        
        
        //Aqui hacer algo para que filtre.......
        
        filteredTableData = [[NSMutableArray alloc] init];
        
        int i=0;
        
        //Por si acaso llevan tiempo con la aplicacion en  marcha
        //Volvemos a llamar al webservice
        
        
        [self CargaDatosWebService:@"Prueba"];
        
        
        for (NSObject* descripcioncontacto in allTableData)
        {
            
            
            NSDictionary *datos =[allTableData objectAtIndex:(i)];
            NSString *nombre = [datos objectForKey:@"NOMBRE"];
            NSString *apellidos = [datos objectForKey:@"APELLIDOS"];
            
            //NSString *Titulo = [[NSString alloc] initWithFormat:@"%@%@%@",Apellidos,Separador,Nombre  ];
            
            nombre = [self prepareString:nombre];
            apellidos = [self prepareString:apellidos];
            
            NSRange RangeNombre = [nombre rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange RangeApellidos = [apellidos rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if(RangeNombre.location != NSNotFound || RangeApellidos.location != NSNotFound){
                [filteredTableData addObject:descripcioncontacto];
            }
            
            i++;
            
            
        }
        
        
        
        
    }
    [self.TableView reloadData];
}

//repositorio

-(NSString*) prepareString:(NSString*)a {
    //remove any accents and punctuation;
    a=[[NSString alloc] initWithData:[a
                                      dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]
                            encoding:NSASCIIStringEncoding];
    
    a=[a stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"'" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"`" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"-" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"_" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"á" withString:@"a"];
    a=[a stringByReplacingOccurrencesOfString:@"é" withString:@"e"];
    a=[a stringByReplacingOccurrencesOfString:@"í" withString:@"i"];
    a=[a stringByReplacingOccurrencesOfString:@"ó" withString:@"o"];
    a=[a stringByReplacingOccurrencesOfString:@"ú" withString:@"u"];
    a=[a stringByReplacingOccurrencesOfString:@"Á" withString:@"A"];
    a=[a stringByReplacingOccurrencesOfString:@"É" withString:@"E"];
    a=[a stringByReplacingOccurrencesOfString:@"Í" withString:@"I"];
    a=[a stringByReplacingOccurrencesOfString:@"Ó" withString:@"O"];
    a=[a stringByReplacingOccurrencesOfString:@"Ú" withString:@"U"];
    a=[a lowercaseString];
    return a;
}

-(IBAction)Exit:(id)sender{
    
    
    
    exit(EXIT_SUCCESS);
    
    
}




@end

