//
//  MainViewController.m
//  remotePong
//
//  Created by Antonio MG on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
@private
    
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

@end


@implementation MainViewController
@synthesize context = _context;
@synthesize effect = _effect;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Open GL Methods

- (void)setupGL {
    
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, 320, 0, 480, -1, 1);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
//    self.ball = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(50, 50) origin:CGPointMake(100, 100) effect:self.effect];
//    
//    myDirecction = DIRECTION_UP_RIGHT;
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
//    myPosition.x = 0.0f;
//    myPosition.y = 0.0f;
    
    [self setupGL];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - GLKView and GLKViewController delegate methods


- (void)update{
    
    
//    GLKVector2 position = self.ball.position;
//    NSLog(@"%f", position.x + self.ball.totalSize.width);
//    
//    if (position.x + self.ball.totalSize.width >= 320) {
//        myDirecction = DIRECTION_UP_LEFT;
//    }
//    else if (position.x <= 0){
//        myDirecction = DIRECTION_DOWN_RIGHT;
//    }
//    else if (position.y <= 0){
//        myDirecction = DIRECTION_UP_RIGHT;
//    }
//    else if (position.y + self.ball.totalSize.height >= 480)
//        myDirecction = DIRECTION_DOWN_LEFT;
//    
//    GLKVector2 curMove;
//    
//    if (myDirecction == DIRECTION_UP_RIGHT) {
//        curMove = GLKVector2MultiplyScalar(VECTOR_UP_RIGHT, 1);
//    }
//    
//    else if (myDirecction == DIRECTION_UP_LEFT){
//        curMove = GLKVector2MultiplyScalar(VECTOR_UP_LEFT, 1);
//    }
//    else if (myDirecction == DIRECTION_DOWN_LEFT) {
//        curMove = GLKVector2MultiplyScalar(VECTOR_DOWN_LEFT, 1);
//    }
//    
//    else if (myDirecction == DIRECTION_DOWN_RIGHT){
//        curMove = GLKVector2MultiplyScalar(VECTOR_DOWN_RIGHT, 1);
//    }
//    
//    [self.ball update:curMove];
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
}

@end
