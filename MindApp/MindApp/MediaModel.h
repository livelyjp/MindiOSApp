//
//  MediaModel.h
//  MindApp
//
//  Created by Jonny Pillar on 16/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaType.h"

@interface MediaModel : NSObject

@property (assign) NSInteger Id;
@property (strong, nonatomic) NSString* Filename;
@property (nonatomic) MediaType MediaType;

@end
