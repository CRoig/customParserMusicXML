//
//  readXML.m
//  customParserMusicXML
//
//  Created by Carles Roig (ATIC) on 12/02/14.
//  Copyright (c) 2014 Carles Roig (ATIC). All rights reserved.
//

#import "readXML.h"
#import "XMLParser.h"

@implementation readXML

@synthesize scores;

-(BOOL) readScore:(NSURL *) scorePath{
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL: scorePath];
    
    //Initialize the delefate
    XMLParser *parser = [[XMLParser alloc] init];
   
    //Set delegate
    [xmlParser setDelegate: parser];
    
    //Start parsing the XML file
    BOOL success = [xmlParser parse];
    
    if(success){
        NSLog(@"No Errors");
        scores = [parser returnScores];
    }else{
        NSLog(@"Error!");
        scores = nil;
    }
    
    // Override point for customization after application launch.
    return YES;
}

@end
