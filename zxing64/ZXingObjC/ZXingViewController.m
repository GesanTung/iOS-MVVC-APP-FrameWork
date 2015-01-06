//
//  ZXingViewController.m
//  TRSMobile
//
//  Created by zhouting on 14/12/8.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#import "ZXingViewController.h"
#import "Globals.h"

@interface ZXingViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    int         num;
    BOOL        upOrdown;
    NSTimer     *timer;
    
    UIView      *_scanRectView;
    UIImageView *_scanFocusLine;
    UIToolbar   *_toolbar;
}

@property (nonatomic, strong) ZXCapture *capture;

@end

@implementation ZXingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initScanRectView];
    [self initCapture];
    [self initUIToolbar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    self.capture.layer.frame = _scanRectView.frame;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(_scanRectView.frame, captureSizeTransform);
    
    [self.view.layer addSublayer:self.capture.layer];
    [self.view bringSubviewToFront:_scanRectView];
    [self.view bringSubviewToFront:_toolbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.capture stop];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark -

- (void)initCapture
{
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.rotation = 90.0f;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.layer.frame = _scanRectView.frame;
}

- (void)initScanRectView
{
    _scanRectView = [[UIView alloc] initWithFrame:self.view.frame];
    _scanRectView.backgroundColor = [UIColor clearColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 40)];
    label.text = @"将二维码/条码放入框内，即可自动扫描";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.backgroundColor = [UIColor clearColor];
    [_scanRectView addSubview:label];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ZXing.bundle/zxing_pickbg.png"]];
    image.frame = CGRectMake(20, 80, 280, 280);
    [_scanRectView addSubview:image];
    
    _scanFocusLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 1)];
    _scanFocusLine.image = [UIImage imageNamed:@"ZXing.bundle/zxing_line.png"];
    [image addSubview:_scanFocusLine];
    
    [self.view addSubview:_scanRectView];
    
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(scaningAnimation) userInfo:nil repeats:YES];
}

- (void)initUIToolbar
{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 80)];
    _toolbar.tintColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ZXing.bundle/zxing_cancel.png"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem *photo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(photo)];

    UIBarButtonItem *flashLight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(turnTorch)];
    
    UIBarButtonItem *qrcode = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(QRImage)];
    
    [_toolbar setItems:@[cancel, space, photo, space, flashLight, space, qrcode] ];
    [self.view addSubview:_toolbar];
}

- (void)cancel
{
    self.isScanning = NO;
    [self.capture stop];
    if (_delegate && [_delegate respondsToSelector:@selector(zXingViewControllerDidCancel:)]) {
        [_delegate zXingViewControllerDidCancel:self];
    }
}

- (void)photo
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        self.isScanning = NO;
        [self.capture stop];
    }];
}

- (void)turnTorch
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(device.hasTorch && device.hasFlash) {
        BOOL active = !device.torchActive;
        [device lockForConfiguration:nil];
        device.torchMode = (active ? AVCaptureTorchModeOn : AVCaptureTorchModeOff);
        device.flashMode = (active ? AVCaptureFlashModeOn : AVCaptureFlashModeOff);
        [device unlockForConfiguration];
    }
}

- (void)QRImage
{

}

- (void)scaningAnimation
{
    if (upOrdown == NO) {
        num++;
        [_scanFocusLine setY:(10+4*num)];
        if (4*num >= 260) {
            upOrdown = YES;
        }
    }
    else {
        num--;
        [_scanFocusLine setY:(10+4*num)];
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

#pragma mark -
- (BOOL)isScaning {
    return self.capture.running;
}

- (void)decodeImage:(UIImage *)image
{
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:image.CGImage];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        if (_delegate && [_delegate respondsToSelector:@selector(zXingViewController:didScanResult:)]) {
            [self.delegate zXingViewController:self didScanResult:result];
        }
    }
    else {
        NSLog(@"%s, error:%@", __FUNCTION__, error.localizedDescription);
    }
}

- (UIImage *)ZXImageWriter
{
    NSError *error = nil;
    ZXEncodeHints *hits = [ZXEncodeHints hints];
    ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc] init];
    ZXBitMatrix *result = [writer encode:IOSAppProductName
                                  format:kBarcodeFormatQRCode
                                   width:640
                                  height:640
                                   hints:hits error:&error];
    if(result) {
        CGImageRef image = [ZXImage imageWithMatrix:result onColor:[UIColor redColor].CGColor offColor:[UIColor greenColor].CGColor].cgimage;
        return [UIImage imageWithCGImage:image scale:1.0 orientation:UIImageOrientationUp];
    }
    NSLog(@"%s, error:%@", __FUNCTION__, error.localizedDescription);
    
    return nil;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [timer invalidate];
    num = 0;
    upOrdown = NO;
    [_scanFocusLine setY:10.0];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 [self decodeImage:image];
                             }
     ];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [timer invalidate];
    num = 0;
    upOrdown = NO;
    [_scanFocusLine setY:10.0];
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                [self.capture start];
                                timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(scaningAnimation) userInfo:nil repeats:YES];
    }];
}

#pragma mark - ZXCaptureDelegate
- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
    if(result == nil) return;
    
    [self.capture stop];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    if (_delegate && [_delegate respondsToSelector:@selector(zXingViewController:didScanResult:)]) {
        [self.delegate zXingViewController:self didScanResult:result];
    }
}

@end
