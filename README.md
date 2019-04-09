# Rescratched, a continuation of the Scratch 2.0 editor and player

## License

Rescratched maintains the same license policy that the [Scratch 2.0 open source project](https://github.com/LLK/scratch-flash) uses. Thus, the Rescratched code is provider under the GPLv2 license, and forks can be released under GPLv2 or any later version of the GPL.

## Status

Rescratched is nearly through with primary develpoment. The official Rescratched site will be initially hosted on my own website. If reception is sufficient, I will purchase the resources to host Rescratched at a dedicated domain.

## Notable Features

* Compatible with Scratch 1.X and Scratch 2.0 projects (SB and SB2 format)
* Capable of "recovering" Scratch 1.X and Scratch 2.0 projects from the official Scratch website (you *dont* have to use horrible Scratch 3.0 to keep working on your projects!)
* Introduces and supports per-project runtime settings
* Incremental stream of UX improvements and advanced capabilities, including...
* The feature most highly requested, but always denied by the Scratch Team: project play/pause!

## Origin and Goals

Rescratched was born from the tear that the Scratch 3.0's "love it or leave it" philosophy put in the Scratch community. The failures and regressions of Scratch 3.0 are both nasty and plentiful, with the Scratch Team's refusal to resolve any as the icing on top. Naturally, when a new version of a product is hot garbage, displaced users will return to a previous, mature version; but, in this case, the in-browser Scratch 2.0 editor is kaput, leaving the AIR-based offline editor as the only official distribution of Scratch 2.0 remaining. Adobe AIR applications require installation like any regular software, which is a barrier to users without administrative powers, users waiting on slow-moving IT departments, users who are suspicious of installing things, etc. So, while some existing users have already cleared this hurdle, many new and long-time Scratchers alike have a substantial obstacle in the way of trying out or carrying on with Scratch 2.0.

Enter Rescratched, a continuation of the Scratch 2.0 editor and player that runs in the browser, just as Scratch 2.0 did before. The reliable Scratch 2.0 experience, now provided by Rescratched, is for...
* Veteran Scratchers
* New Scratchers
* Scratchers looking for some advanced new features
* Anyone with unfinished Scratch 2.0 projects
* Anyone with ideas for new Scratch 2.0 projects
* Anyone with projects that are broken by Scratch 3.0
* Anyone who suffers eye strain from Scratch 3.0's unbelievably low-contrast UI
* Anyone who suffers boredom from Scratch 3.0's loading times and constant freezing
* Anyone who is fed up with the limitations of Scratch 3.0
* Anyone who wants to see what Scratch was all about
* You? Yes, you!

## Potential Concerns & Quanderies

#### Rescratched/Scratch 2.0 uses Adobe Flash, and Flash is dead/insecure/slow/so 2010/gross!
Flash has fallen from its mighty throne, yes, but it is not as dead or insecure as sensational media would have you believe. Adobe continues to regularly update Flash with security patches. Additionally, while Flash's history of use in games/videos/animations/everything has led to unfair comparisons against deticated versions of those applications, thus forming the consensus that "Flash is sloooooow", please note that the Scratch 2.0 editor (as well as Rescratched) has distinctly better performance than Scratch 3.0 in most cases.

#### Can Rescratched rescue/edit my Scratch 3.0 projects?
Unfortunately, no. The Scratch 3.0 project format, SB3, is substantially different from the Scratch 2.0 SB2 format. Presently, there is no utility to convert a Scratch 3.0 project to the SB2 format, but I have that on the backburner for my free time.

#### What are the "advanced new features" in Rescratched?
The typical person who decides to try out Rescratched is likely a veteran Scratcher who has already pushed against some of Scratch 2.0's limitations. In gradual time, I hope to introduce more advanced project-making capabilities to Rescratched to help keep the interest and attention of these users. Such new capabilities will *never* break compatibility with vanilla Scratch 2.0 projects.

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------

# Relevant README from origin scratch-flash is below
### I will get around to rewriting the build instructions once Rescratched is launched.

## Building

The Scratch 2.0 build process now uses [Gradle](http://gradle.org/) to simplify the process of acquiring dependencies:
the necessary Flex SDKs will automatically be downloaded and cached for you. The [Gradle
wrapper](https://docs.gradle.org/current/userguide/gradle_wrapper.html) is included in this repository, but you will
need a Java Runtime Environment or Java Development Kit in order to run Gradle; you can download either from Oracle's
[Java download page](http://www.oracle.com/technetwork/java/javase/downloads/index.html). That page also contains
guidance on whether to download the JRE or JDK.

There are two versions of the Scratch 2.0 editor that can be built from this repository. See the following table to
determine the appropriate command for each version. When building on Windows, replace `./gradlew` with `.\gradlew`.

Required Flash version | Features | Command
--- | --- | ---
11.6 or above | 3D-accelerated rendering | `./gradlew build -Ptarget="11.6"`
10.2 - 11.5 | Compatibility with older Flash (Linux, older OS X, etc.) | `./gradlew build -Ptarget="10.2"`

A successful build should look something like this (SDK download information omitted):

```sh
$ ./gradlew build -Ptarget="11.6"
Defining custom 'build' task when using the standard Gradle lifecycle plugins has been deprecated and is scheduled to be removed in Gradle 3.0
Target is: 11.6
Commit ID for scratch-flash is: e6df4f4
:copyresources
:compileFlex
WARNING: The -library-path option is being used internally by GradleFx. Alternative: specify the library as a 'merged' Gradle dependendency
:copytestresources
:test
Skipping tests since no tests exist
:build

BUILD SUCCESSFUL

Total time: 13.293 secs
```

Upon completion, you should find your new SWF in the `build` subdirectory.

```sh
$ ls -R build
build:
10.2  11.6

build/10.2:
ScratchFor10.2.swf

build/11.6:
Scratch.swf
```

Please note that the Scratch trademarks (including the Scratch name, logo, Scratch Cat, and Gobo) are property of MIT.
For use of these Marks, please see the [Scratch Trademark
Policy](http://wiki.scratch.mit.edu/wiki/Scratch_1.4_Source_Code#Scratch_Trademark_Policy).

## Debugging

Here are a few integrated development environments available with Flash debugging support:

* [Visual Studio Code](https://code.visualstudio.com/)
* [Intellij IDEA](http://www.jetbrains.com/idea/features/flex_ide.html)
* [Adobe Flash Builder](http://www.adobe.com/products/flash-builder.html)
* [FlashDevelop](http://www.flashdevelop.org/)
* [FDT for Eclipse](http://fdt.powerflasher.com/)

It may be difficult to configure your IDE to use Gradle's cached version of the Flex SDK. To debug the Scratch 2.0 SWF
with your own copy of the SDK you will need the [Flex SDK](http://flex.apache.org/) version 4.10+, and
[playerglobal.swc files](http://helpx.adobe.com/flash-player/kb/archived-flash-player-versions.html#playerglobal) for
Flash Player versions 10.2 and 11.6 added to the Flex SDK.

After downloading ``playerglobal11_6.swc`` and ``playerglobal10_2.swc``, move them to
``${FLEX_HOME}/frameworks/libs/player/${VERSION}/playerglobal.swc``. E.g., ``playerglobal11_6.swc`` should be located
at ``${FLEX_HOME}/frameworks/libs/player/11.6/playerglobal.swc``.

Consult your IDE's documentation to configure it for your newly-constructed copy of the Flex SDK.

If the source is building but the resulting .swf is producing runtime errors, your first course of action should be to
download version 4.11 of the Flex SDK and try targeting that. The Apache foundation maintains an
[installer](http://flex.apache.org/installer.html) that lets you select a variety of versions.
