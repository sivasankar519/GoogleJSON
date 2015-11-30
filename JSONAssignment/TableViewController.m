//
//  TableViewController.m
//  
//
//  Created by SIVASANKAR DEVABATHINI on 11/3/15.
//
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "DataManager.h"

static NSString * const urlString = @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PLWz5rJ2EKKc_XOgcRukSoKKjewFJZrKV0&key=AIzaSyBkKJRvNKAJ4cgdVY604OfkzhqHh7bvyi0";

@interface TableViewController ()
{
    NSArray *dataArray;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JSON Test";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Request to establish connection from Data manager shared instance
    [[DataManager sharedInstance] loadURLRequestWithURLString:urlString completionHandler:^(NSData *data){
        
        NSError *jsonParsingError = nil;
        NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        if(jsonResults)
        dataArray = jsonResults[@"items"];
        
        
        // Update UI on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }];
    
    
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = dataArray[indexPath.row][@"snippet"][@"title"];
    cell.detailTextLabel.text = dataArray[indexPath.row][@"snippet"][@"description"];
    
    
    
    
    
    [cell setUpCell:dataArray[indexPath.row][@"snippet"][@"thumbnails"][@"default"][@"url"]];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
