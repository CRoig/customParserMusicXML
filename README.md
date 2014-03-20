customParserMusicXML
====================

A Parser for extracting the desired information from a MusicXML file

In this version, the focused information is the following (defined in Score.h):

1. divisionInt (int): Indicates the shortest note duration in the score (in quarter divisions, e.g. if the shortest note is a quarter, divisionInt = 1, if it is an eight not, divisionInt = 2).
2. fifthsInt (int): Indicates the key:
  - Missing : Refers to a non alterations tonality
  - Positive : Indiactes a sharp tonality. The number refers to the amount of sharps in the key signature.
  - Negative : Indicates a flat tonality. The number refers to the amount of flats in the key signature.
3. modeString (NSString): Defines the mode of the tonality @"major" or @"minor"
4. beatInt (int): Defines the numerator of the time signature. e.g. 2/4, beatInt = 2;
5. typeInt (int): Defines the denominator of the time signature. e.g. 2/4, typeInt = 4;
6. clefSignString (NSString): Defines the kind of clef in the score.
  - G-Clef => @"G"
  - F-Clef => @"F"
  - C-Clef => @"C"
7. clefLineInt(int): Indicates the line property of the clef.
8. noteStream (NSMutableArray): This is an array containing a set of notes.

The notes are defined in another class (Note.h):

1. typeNote (NSString): Defines if the note is an actual note (@"note") or a resting period (@"rest").
2. stepNote (NSString): Defines the note chroma, @"C", @"D",..., @"B"
3. alterNote (int): Defines the number of alterations.
  - Missing : None alteration.
  - 0 : Natural Symbol
  - +1 : Sharp (+2, double sharps)
  - -1 : Flat (-2, double flats)
4. octaveNote (int): Defines the tone octave for C4, octaveNote = 4;
5. duratNote (int): Defines the duration refering to the score shortest note. e.g. if the shortest note is an eigth (Score.divisionInt = 2), a quarter note duration is duratNote = 2, and an eight note duratNote = 1.

A part from this classes, two classes are defined:

1. readXML : Is the top class of the parser, this object should be included in the main project, allocated and initalized for parsing the file. It has the score property (NSMutableArray) that stores the parsed information. Actually is an array of Score objects.
2. XMLParser : Is the actual implementation of the parses. It implements the parsing methods overriding NSXMLParser methods.

Finally, this is the proper initialization and usage of the parser:

``` cpp
#import "readXML.h"
#import "Score.h"
#import "Note.h"

...

NSURL *url = [[NSBundle mainBundle] URLForResource:xmlName withExtension:@"xml"];
readXML *readerXML = [[readXML alloc] init];
[readerXML readScore:url];
Score *currScore = [readerXML.scores objectAtIndex:0];
```

Note that the data tracked can be changed by defining other classes. Consequently, didStartElement and didEnElement must be adapted to the data required.

For any doubt or comment, please feel free to contact my at @CRoigG in Twitter
