//
//  MessageViewController.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/12.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewModel.h"
#import "UploadRequestItem.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MessageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) MessageViewModel *vm;
@property (nonatomic, strong) UIImagePickerController *imgPC;
///// 将视频写入文件的对象
//@property (nonatomic, strong) AVCaptureMovieFileOutput *movieFileOutput;
//@property (nonatomic, strong) AVCaptureSession *captureSession;
///// 相机输入
//@property (nonatomic, strong) AVCaptureDeviceInput *cameraDeviceInput;
///// 麦克风输入
//@property (nonatomic, strong) AVCaptureDeviceInput *micDeviceInput;
///// 相机拍摄预览图层
//@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@end

@implementation MessageViewController
//
//- (AVCaptureDeviceInput *)cameraDeviceInput {
//    if (_cameraDeviceInput == nil) {
//        AVCaptureDevice *cameraDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInDuoCamera mediaType:AVMediaTypeAudio position:AVCaptureDevicePositionBack];
//        _cameraDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:cameraDevice error:nil];
//        
//    }
//    return _cameraDeviceInput;
//}
//
//- (AVCaptureDeviceInput *)micDeviceInput {
//    if (_micDeviceInput == nil) {
//        AVCaptureDevice *micDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//        _micDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:micDevice error:nil];
//    }
//    return _micDeviceInput;
//}
//
//
//
//- (AVCaptureMovieFileOutput *)movieFileOutput {
//    if (_movieFileOutput == nil) {
//        _movieFileOutput = [AVCaptureMovieFileOutput new];
//    }
//    return _movieFileOutput;
//}
//
//- (AVCaptureSession *)captureSession {
//    if (_captureSession == nil) {
//        _captureSession = [AVCaptureSession new];
//        
//        if ([_captureSession canAddInput:self.micDeviceInput]) {
//            [_captureSession addInput:self.micDeviceInput];
//        }
//        if ([_captureSession canAddOutput:self.movieFileOutput]) {
//            [_captureSession addOutput:self.movieFileOutput];
//        }
//        if ([_captureSession canAddInput:self.cameraDeviceInput]) {
//            [_captureSession addInput:self.cameraDeviceInput];
//        }
//        
//        // 创建视频预览层，用于时实展示摄像头状态
//        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
//        CALayer *layer = self.view.layer;
//        layer.masksToBounds = YES;  // 设置图层的圆角属性
//        
//        _captureVideoPreviewLayer.frame = layer.bounds;
//        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResize; // 填充模式显示在layer上
//        // 将视频预览层添加到界面中
//        [layer addSublayer:_captureVideoPreviewLayer];
////        [layer insertSublayer:_captureVideoPreviewLayer below:self.focusCursor.layer];
//        
////        _enableRotation=YES;
////        [self addNotificationToCaptureDevice:captureDevice];  // 给输入设备添加通知
////        [self addGenstureRecognizer]; // 添加手势
////        [self setFlashModeButtonStatus]; // 设置闪光灯按钮状态
//        
//    }
//    return _captureSession;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息";
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:@"上传图片或视频1" forState:UIControlStateNormal];
    b.frame = CGRectMake(100, 100, 200, 50);
    b.backgroundColor = kColor(200, 200, 50, 1.0);
    [self.view addSubview:b];
    [b addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    self.imgPC.delegate = self;
    
//    
//    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [b1 setTitle:@"上传图片或视频1" forState:UIControlStateNormal];
//    b1.frame = CGRectMake(100, 400, 200, 50);
//    b1.backgroundColor = kColor(150, 50, 80, 1.0);
//    [self.view addSubview:b1];
//    [b1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)btnClick1:(UIButton *)b {
//    
////    [[NSOperationQueue new] addOperationWithBlock:^{
//    
//        [self.captureSession startRunning];
//    AVCaptureConnection *captureConnection=[self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
//    //根据连接取得设备输出的数据
//    if (![self.movieFileOutput isRecording]) {
//        //        shootBt.backgroundColor = UIColorFromRGB(0xfa5f66);
//        //预览图层和视频方向保持一致
//        captureConnection.videoOrientation=[self.captureVideoPreviewLayer connection].videoOrientation;
////        [self.movieFileOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:[self getVideoSaveFilePathString]] recordingDelegate:self];
//    }
//    
////    }];
//}



- (MessageViewModel *)vm {
    if (_vm == nil) {
        _vm = [MessageViewModel new];
    }
    return _vm;
}

#pragma MARK - 示例1
- (UIImagePickerController *)imgPC {
    if (_imgPC == nil) {
        _imgPC = [UIImagePickerController new];
        _imgPC.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imgPC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        _imgPC.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, nil];
        _imgPC.allowsEditing = YES;
        
    }
    return _imgPC;
}
- (void)btnClick:(UIButton *)b {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray *availableMediaTypes = [UIImagePickerController
                                        availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if ([availableMediaTypes containsObject:(NSString *)kUTTypeMovie]) {
            // 支持视频录制
            [self presentViewController:self.imgPC animated:YES completion:nil];
        }
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSString *url = info[UIImagePickerControllerReferenceURL];
    NSLog(@"%@", info);
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            // 上传图片
            [self upload:image name:url];
        }];
    }];
    
}

/// 测试上传图片或视频
- (void)upload:(UIImage *)image name:(NSString *)name {
    
    /// 保存
    [self.vm xy_viewModelWithProgress:nil success:^(id responseObject) {
        
        // 上传成功后，返回datas，拿到后将其传给updateTrendFile
        if ([responseObject[@"code"] integerValue] == 0) {
            // 上传图片
            [self.vm xy_viewModelWithConfigRequest:^(id<XYRequestProtocol> request) {
                // 配置请求对象
                UploadRequestItem*item = (UploadRequestItem *)request;
                
                // file，tid=10673， type=1，file=image.jpg(数组，有多张图片时)
                item.xy_params = @{@"tid": responseObject[@"datas"], @"type": @"1", @"file": UIImagePNGRepresentation(image)};
                item.xy_fileConfig = [[XYRequestFileConfig alloc] initWithFormData:UIImagePNGRepresentation(image) name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
                
            } progress:^(NSProgress *progress) {
                NSLog(@"%@", progress);
            } success:^(id responseObject) {
                NSLog(@"%@", responseObject);
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}


@end
