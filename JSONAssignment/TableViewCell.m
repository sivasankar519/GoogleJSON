//
//  TableViewCell.m
//  JSONAssignment
//
//  Created by SIVASANKAR DEVABATHINI on 11/3/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import "TableViewCell.h"
#import "DataManager.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCell:(NSString*)string {
    
    // Get the Image data specific to Cell,
    // Calling LoadURL mehtod by passing URLstring this will give Data Object on completion block
    [[DataManager sharedInstance] loadURLRequestWithURLString:string completionHandler:^(NSData *data) {
        if (data) {
            
            // Update UI even its already presented to user,
            // setNeedsDisplay will override the drawRect method in its subviews to make changes on view.
            dispatch_async(dispatch_get_main_queue(), ^{
    
                
                self.imageView.image = [UIImage imageWithData:data];
                [self setNeedsLayout];
            });
        }
    }];
}

@end
