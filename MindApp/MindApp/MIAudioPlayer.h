//
//  MIAudioPlayer.h
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@protocol MIAudioPlayerDelegate;

@interface MIAudioPlayer : AVPlayer

@property (nonatomic, strong) id<MIAudioPlayerDelegate> delegate;

-(id) init;
-(id) initWithDelegate:(id) delegate;

-(void) playNewPlayerItem:(NSURL *) mediaItemUrl;
-(void) playAudio;
-(void) pauseAudio;
-(BOOL) audioPlayerIsPlaying;
-(float) getAudioTrackDuration;

@end

@protocol MIAudioPlayerDelegate <NSObject>

@required
-(void) updateUIForPlay;
-(void) updateUIForPause;

@end