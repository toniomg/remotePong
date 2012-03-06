//
//  RPSprite.h
//  GLTest
//
//  Created by M2Mobi on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@interface RPSimpleSprite : NSObject


-(id)initWithSize:(CGSize)frame origin:(CGPoint)origin effect:(GLKBaseEffect *)effect;
- (void)render;
-(void)update:(GLKVector2)curMove;

@property (assign) GLKVector2 position;
@property (assign) CGSize totalSize;


@end
