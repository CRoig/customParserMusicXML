//
//  readXML.h
//  customParserMusicXML
//
//  Created by Carles Roig (ATIC) on 12/02/14.
//  Copyright (c) 2014 Carles Roig (ATIC). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface readXML : NSObject {
    NSMutableArray *scores;
}

@property (nonatomic, retain) NSMutableArray *scores;

- (BOOL) readScore: (NSURL *) scorePath;

@end
