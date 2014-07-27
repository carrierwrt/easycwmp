
EasyCwmp
========

[EasyCwmp](http://easycwmp.org) is [PIVA Software's](http://www.pivasoftware.com)
fork of [freecwmp](http://freecwmp.org), originally written by Luka Perkov and
licensed under the GPLv2 (see COPYING for details).

This repo takes [easycwmp-1.0.1.tar.gz](http://www.easycwmp.org/download/easycwmp-1.0.1.tar.gz)
as its starting point, with the ambition to clean up the code base, fix bugs and
implement some missing functionality.

TODO
====

Things To Do:

 * Basic cleanup of source code and structural improvements

   - Fix incorrect use of static in header files [DONE]

   - Various minor bugfixes [DONE]

   - Understand and simplify the event loop / "backup" / forking behavior

 * Implement explict file system based model and separate action scripts

   - Implement traversal of fs dir hierarchy representing the data model

   - Implement separate external getters/setters for parameters

   - Implement separate external list/add/delete scripts for objects

   - Implement better support for notifications

   - Strip out libjson-c and shflags dependencies

 * Implement RequestDownload

