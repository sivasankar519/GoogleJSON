//
//  DataManager.h
//
//
//  Created by SIVASANKAR DEVABATHINI on 11/26/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject


+ (DataManager *)sharedInstance;

- (void)loadURLRequestWithURLString:(NSString *)urlString completionHandler:(void (^)(NSData *data))completionHandler;

@end

