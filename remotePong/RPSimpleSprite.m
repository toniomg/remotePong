//
//  RPSprite.m
//  GLTest
//
//  Created by M2Mobi on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RPSimpleSprite.h"

typedef struct {
    CGPoint geometryVertex;
    CGPoint textureVertex;
} TexturedVertex;

typedef struct {
    TexturedVertex bl;
    TexturedVertex br;    
    TexturedVertex tl;
    TexturedVertex tr;    
} TexturedQuad;

@interface RPSimpleSprite () {
@private
}

@property (strong) GLKBaseEffect *effect;
@property (assign) TexturedQuad quad;

@end

@implementation RPSimpleSprite
@synthesize effect = _effect;
@synthesize quad= _quad;
@synthesize position = _position;
@synthesize totalSize = _totalSize;


-(id)initWithSize:(CGSize)frame origin:(CGPoint)origin effect:(GLKBaseEffect *)effect{
    
    if ((self = [super init])) {
        
        self.effect = effect;
    
        //Create the quad
        TexturedQuad newQuad;
        newQuad.bl.geometryVertex = CGPointMake(0,0);
        newQuad.br.geometryVertex = CGPointMake(frame.width,0);
        newQuad.tl.geometryVertex = CGPointMake(0, frame.height);
        newQuad.tr.geometryVertex = CGPointMake(frame.width, frame.height);
        
        newQuad.bl.textureVertex = CGPointMake(0, 0);
        newQuad.br.textureVertex = CGPointMake(1, 0);
        newQuad.tl.textureVertex = CGPointMake(0, 1);
        newQuad.tr.textureVertex = CGPointMake(1, 1);
        self.quad = newQuad;
        
        self.position = GLKVector2Make(origin.x, origin.y);
        self.totalSize = frame;

    }
    
    return self;
    
}


- (void)render { 
    
    self.effect.transform.modelviewMatrix = GLKMatrix4Translate(GLKMatrix4Identity, self.position.x,self.position.y, 0);
    
    [self.effect prepareToDraw];
    
    long offset = (long)&_quad;
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *) (offset + offsetof(TexturedVertex, geometryVertex)));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *) (offset + offsetof(TexturedVertex, textureVertex)));
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
}


-(void)update:(GLKVector2)curMove{
    
    //Update the position
    self.position = GLKVector2Add(self.position, curMove);
    
}


@end
