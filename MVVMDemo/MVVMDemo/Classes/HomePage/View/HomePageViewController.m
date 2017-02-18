//
//  HomePageViewController.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/12.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "HomePageViewController.h"
#import "XYHomePageViewModel.h"
#import "HomePageRequestItem.h"
#import "AFNetworking.h"

@interface HomePageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imgPC;
@property (nonatomic, strong) XYHomePageViewModel *vm;

@end

@implementation HomePageViewController

- (UIImagePickerController *)imgPC {
    if (_imgPC == nil) {
        _imgPC = [UIImagePickerController new];
        _imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imgPC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _imgPC.allowsEditing = YES;
        
    }
    return _imgPC;
}

- (XYHomePageViewModel *)vm {
    if (_vm == nil) {
        _vm = [XYHomePageViewModel new];
    }
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(100, 100, 200, 50);
    b.backgroundColor = kColor(200, 200, 50, 1.0);
    [self.view addSubview:b];
    [b addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgPC.delegate = self;
}

/// 上传图片到服务器
- (void)btnClick:(UIButton *)b {
    
    [self presentViewController:self.imgPC animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSString *url = info[UIImagePickerControllerReferenceURL];
    
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        // 上传图片
        [self upload:image name:url];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/// 使用AFN 上传图片
- (void)upload:(UIImage *)image name:(NSString *)name {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /// responseSerializer.acceptableContentTypes中不添加@"multipart/form-data",也是可以的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/jpeg", @"image/png", @"text/plain", @"multipart/form-data", nil];

    
    [manager POST:@"http://192.168.1.101:8080/FileUploadDemo/upload2" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /// fileData是要上传文件的二进制数据
        NSData *fileData = UIImagePNGRepresentation(image);
        /// 此name主要用于java中获取Part(文件上传组件对象的)，此name值必须是与服务端约定好的固定值，不然服务器到错误的name值时，就无法创建Part对象，最终肯定上传失败的，此name值在HTML5页面中用input标签type="file" 然后设置name值
        NSString *name = @"file";
        /// fileName为文件的名称
        NSString *fileName = [NSString stringWithFormat:@"%@.png", name];
        /// mimeType为文件类型
        NSString *mimeType = @"image/png";
        
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

/// 使用基于ANF进行封装的类 上传图片
//- (void)upload:(UIImage *)image name:(NSString *)name {
//    
//    [self.vm xy_viewModelWithConfigRequest:^(id<XYRequestProtocol> requestItem) {
//        
//        /// 拿到回调回来的请求对象，动态配置request
//        HomePageRequestItem *item = (HomePageRequestItem *)requestItem;
//        item.xy_fileConfig = [XYRequestFileConfig fileConfigWithFormData:UIImagePNGRepresentation(image) name:@"f" fileName:@"image.png" mimeType:@"image/png"];
//        
//    } progress:nil success:^(id responseObject) {
//        
//        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"---%@", obj);
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    
//    
//}

@end
