# IGExperiments
<p align="center">
    <img src="https://img.shields.io/badge/platform-iOS%2010%2B-brown.svg?style=flat" alt="Instagram: 11.0+"/><br><br>
</p>

IGExperiments allows you to view the a/b experiments Instagram is testing. These experiments are subject to change without notice by Instagram. The only thing IGExperiments does is grant access to these.

### Installing

Install IGExperiments from Cydia via the BigBoss repo if you are jailbroken.

If you are not jailbroken, a pre-compiled dylib is available for sideloading purposes.

### Compiling

To compile IGExperiments you will need to use [theos][theos]. Theos is a unified cross-platform Makefile system. To find out more about it check out it's [wiki][theoswiki].

Download the latest source code and do:
- *make*
- or *make install*
- or *make package install*
- or *make do*
- or whatever you've set as your easy to type alias

If compiling for sideloading purposes, make sure the set IGExperiments_USE_SUBSTRATE to 0 in the makefile.

[theos]: <https://github.com/theos/theos>
[theoswiki]: <https://github.com/theos/theos/wiki>
