[![Build Status](https://travis-ci.com/braillespecs/pef.svg?branch=master)](https://travis-ci.com/braillespecs/pef)

# Portable Embosser Format
The Portable Embosser Format (PEF) is a data format for representing braille books, accurately and unambiguously; regardless of language, location, embosser settings, braille code and computer environment. It can be used for braille embossing and archiving anywhere in the world, no matter where nor how it was produced.

PEF builds on XML, Unicode and Dublin Core. Three well known, widely used and reliable technologies.

PEF has been been awarded with the [Braille21 Award](http://braille21.dzb.de/en/programme). A one-time award presented at the Braille21 conference in Leipzig.

## Reasons for developing PEF
  * To facilitate ordering of additional braille copies at a later point in time
  * To ensure readability of material many years from now, e.g. when investing in an digitizing effort, the result must be persistently readable
  * To reduce costs for embossing
  * To enable easy file sharing across regions having different embosser settings or software


## Why use PEF?
  * PEF is a proper file format, defined in a publicly available specification.
  * There is never any doubt about how to interpret or use the contents of a PEF file
  * A PEF file can be shared with anyone in the world
  * A PEF file provides metadata that can be used for tracing, tracking, organizing and searching
  * Publishing and republishing can be achieved quickly and easily, without worrying about embosser or software settings

## What about ASCII braille?
Problems with ASCII braille:
  * It is insufficiently defined
  * It can be interpreted differently depending on software/embosser
  * It depends on an alternate interpretation of regular ASCII characters, but provides no means of how to differentiate one interpretation from another. A stray file that has been taken out of context or transferred from one computer to another can be very difficult to make sense of, even for a skilled transcriber
  * Common characters like .?()+$% and # render different braille patterns depending on embosser and/or software locale. The reality is that one can’t send an ASCII braille file to an embosser without braille knowledge
  * A user keeping a collection of ASCII braille files cannot rely on embedded metadata when searching or organizing, such as one can with for example mp3-files. In fact, no additional information whatsoever can be attributed to an ASCII file.