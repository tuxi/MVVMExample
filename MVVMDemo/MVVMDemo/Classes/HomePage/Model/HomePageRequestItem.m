//
//  HomePageRequestItem.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/18.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "HomePageRequestItem.h"
#import "NSObject+XYRequest.h"
#import "XYNetworkRequest.h"

@implementation HomePageRequestItem


- (void)xy_requestConfigures {
    
    self.xy_method = RequestMethodUPLOAD;
    self.xy_url = @"http://localhost:8080/FileUploadDemo/upload1";
    UIImage *img = [UIImage imageNamed:@"chat_tabbar_un"];
    self.xy_fileConfig = [[XYRequestFileConfig alloc] initWithFormData:UIImagePNGRepresentation(img) name:@"chat_tabbar_un" fileName:@"chat_tabbar_un" mimeType:@"image/jpeg"];
    
    
}




@end
