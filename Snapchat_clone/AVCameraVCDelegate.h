//
//  Header.h
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/16/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import <Foundation/Foundation.h>

@protocol AVCameraVCDelegate <NSObject>
    
-(void)shouldEnableRecordUI:(BOOL)enable;
-(void)shouldEnableCameraUI:(BOOL)enable;
-(void) canSatartRecording;
-(void)recordingHasStarted;
-(void)videoRecordingComplete:(NSURL*)videoURL;
-(void)videoRecordingFailed;
-(void)snapshotTaken:(NSData*)snapshotData;
-(void)snapshotFailed;
    
@end

#endif /* Header_h */
