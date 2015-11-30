//
//  DataManager.m
//  
//
//  Created by SIVASANKAR DEVABATHINI on 11/26/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import "DataManager.h"

typedef void (^completionHandler)(NSData *data);

@interface DataManager () < NSURLSessionDataDelegate >
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end

@implementation DataManager

+ (DataManager *)sharedInstance {
    
    // To create Singleton object.
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    
    if (self) {
        // Intializing
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        self.session = [NSURLSession sessionWithConfiguration:configuration
                                                     delegate:self
                                                delegateQueue:nil];
        
        self.dictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)loadURLRequestWithURLString:(NSString *)urlString completionHandler:(void (^)(NSData *data))completionHandler {
    
    // Establishing connection with NSURLSessionDataTask
    // To return the completion block to calling place
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    
    [self.dictionary setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                [NSMutableData data], @"data",
                                [completionHandler copy], @"completionHandler",
                                nil]
                        forKey:task];
    [task resume];
}

#pragma mark- NSURLSessionDataDelegate methods

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    [self.dictionary[dataTask][@"data"] appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    // Handover the completion block of this method to dictionary object with typeDef completion block.
    if (self.dictionary[task]) {
        completionHandler completionHandler = self.dictionary[task][@"completionHandler"];
        
        if (completionHandler) {
            completionHandler(self.dictionary[task][@"data"]);
        }
    }
}
@end
