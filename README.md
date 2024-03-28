# Camera Manager

## How to use

To use it you just add the preview layer to your desired view, you'll get back the state of the camera if it's unavailable, ready or the user denied access to it. Have in mind that in order to retain the AVCaptureSession you will need to retain cameraManager instance somewhere, ex. as an instance constant.

```swift
let cameraManager = CameraManager()
cameraManager.addPreviewLayerToView(self.cameraView)

```

To shoot image all you need to do is call:

```swift
cameraManager.capturePictureWithCompletion({ result in
    switch result {
        case .failure:
            // error handling
        case .success(let content):
            self.myImage = content.asImage;
    }
})
```

To record video you call:

```swift
cameraManager.startRecordingVideo()
cameraManager.stopVideoRecording({ (videoURL, recordError) -> Void in
    guard let videoURL = videoURL else {
        //Handle error of no recorded video URL
    }
    do {
        try FileManager.default.copyItem(at: videoURL, to: self.myVideoURL)
    }
    catch {
        //Handle error occured during copy
    }
})
```

To zoom in manually:

```swift
let zoomScale = CGFloat(2.0)
cameraManager.zoom(zoomScale)
```

### Properties

You can set input device to front or back camera. `(Default: .Back)`

```swift
cameraManager.cameraDevice = .front || .back
```

You can specify if the front camera image should be horizontally fliped. `(Default: false)`

```swift
cameraManager.shouldFlipFrontCameraImage = true || false
```

You can enable or disable gestures on camera preview. `(Default: true)`

```swift
cameraManager.shouldEnableTapToFocus = true || false
cameraManager.shouldEnablePinchToZoom = true || false
cameraManager.shouldEnableExposure = true || false
```

You can set output format to Image, video or video with audio. `(Default: .stillImage)`

```swift
cameraManager.cameraOutputMode = .stillImage || .videoWithMic || .videoOnly
```

You can set the quality based on the [AVCaptureSession.Preset values](https://developer.apple.com/documentation/avfoundation/avcapturesession/preset) `(Default: .high)`

```swift
cameraManager.cameraOutputQuality = .low || .medium || .high || *
```

`*` check all the possible values [here](https://developer.apple.com/documentation/avfoundation/avcapturesession/preset)

You can also check if you can set a specific preset value:

```swift
if .cameraManager.canSetPreset(preset: .hd1280x720) {
     cameraManager.cameraOutputQuality = .hd1280x720
} else {
    cameraManager.cameraOutputQuality = .high
}
```

You can specify the focus mode. `(Default: .continuousAutoFocus)`

```swift
cameraManager.focusMode = .autoFocus || .continuousAutoFocus || .locked
```

You can specifiy the exposure mode. `(Default: .continuousAutoExposure)`

```swift
cameraManager.exposureMode = .autoExpose || .continuousAutoExposure || .locked || .custom
```

You can change the flash mode (it will also set corresponding flash mode). `(Default: .off)`

```swift
cameraManager.flashMode = .off || .on || .auto
```

You can specify the stabilisation mode to be used during a video record session. `(Default: .auto)`

```swift
cameraManager.videoStabilisationMode = .auto || .cinematic
```

You can get the video stabilization mode currently active. If video stabilization is neither supported or active it will return `.off`.

```swift
cameraManager.activeVideoStabilisationMode
```

You can enable location services for storing GPS location when saving to Camera Roll. `(Default: false)`

```swift
cameraManager.shouldUseLocationServices = true || false
```

In case you use location it's mandatory to add `NSLocationWhenInUseUsageDescription` key to the `Info.plist` in your app. [More Info](https://developer.apple.com/documentation/uikit/protecting_the_user_s_privacy)

You can specify if you want to save the files to phone library. `(Default: true)`

```swift
cameraManager.writeFilesToPhoneLibrary = true || false
```

You can specify the album names for image and video recordings.

```swift
cameraManager.imageAlbumName =  "Image Album Name"
cameraManager.videoAlbumName =  "Video Album Name"
```

You can specify if you want to disable animations. `(Default: true)`

```swift
cameraManager.animateShutter = true || false
cameraManager.animateCameraDeviceChange = true || false
```

You can specify if you want the user to be asked about camera permissions automatically when you first try to use the camera or manually. `(Default: true)`

```swift
cameraManager.showAccessPermissionPopupAutomatically = true || false
```

To check if the device supports flash call:

```swift
cameraManager.hasFlash
```

To change flash mode to the next available one you can use this handy function which will also return current value for you to update the UI accordingly:

```swift
cameraManager.changeFlashMode()
```

You can even setUp your custom block to handle error messages:
It can be customized to be presented on the Window root view controller, for example.

```swift
cameraManager.showErrorBlock = { (erTitle: String, erMessage: String) -> Void in
    var alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
    }))

    let topController = UIApplication.shared.keyWindow?.rootViewController

    if (topController != nil) {
        topController?.present(alertController, animated: true, completion: { () -> Void in
            //
        })
    }

}
```

You can set if you want to detect QR codes:

```swift
cameraManager.startQRCodeDetection { (result) in
    switch result {
    case .success(let value):
        print(value)
    case .failure(let error):
        print(error.localizedDescription)
    }
}
```

and don't forget to call `cameraManager.stopQRCodeDetection()` whenever you done detecting.
