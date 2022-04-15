# Installing Dlang on Windows

_This idiom by Stephane Ribas._

_Installing the D programming language on Windows can be sometimes difficult. This guide is intended to provide a beginner-friendly tutorial for foolproof D installation, using Visual Studio + VisualD._

## **General plan to install D language, LDC, etc.**

Install & compile D code by following those steps:

1. 1. Install Microsoft Visual Studio.
2. 2. Add C++ & Windows SDK libs.
3. 3. Install Visual D.
4. 4. Check the LDC path in the `PATH` environment variable.
5. 5. Open a terminal window, check that DUB and compilers are working.

_The order is important!_

## **1. Install Microsoft Visual Studio IDE + Libraries**

Before starting the D language installation, we recommend you to install FIRST the Microsoft Visual Studio Community IDE:

1. To do so you will have to install **Microsoft Visual Installer** that can be downloaded from Microsoft Visual Studio [official website](https://visualstudio.microsoft.com).

2. Once you have downloaded this executable and installed it on your PC, launch it and install the free **Microsoft Visual Studio Community Edition** (2019 version or above).

![](assets/vs-community.png)

3. **IMPORTANT:** Once installed, you need to install Windows SDK and C/C++ libs.


## **2. Install librairies**

### **Windows SDK (version 10 or 11)**

1. Open again the Microsoft Visual Installer & in Microsoft Visual Studio Community area, click on the "MODIFY" option

![](assets/vs-modify.png)

2. Choose the thumbnail called "Individual component':

![](assets/all-kits.png)

3. In the SEARCH toolbar, write "Windows SDK" and press ENTER:

![](assets/windows-sdk.png)

4. The program will show you all the Windows SDK libraries that you can install on your system.

5. Install ALL OF THEM.


### **Windows C++/C libs**


1. Once you have install the Windows SDK librairies, go back the SEARCH toolbar.
2. Write "C++ development tools".
3. The program will show you all the libraries that you can install on your system.
4. Install ALL OF THEM...

![](assets/vs-search.png)

5. Now you have an IDE & libs installed. Perfect!

_Explanation: D programs links with both the D runtime, and a C runtime. Here the C runtime is MSVCRT (Visual C language runtime), so we need to install it._


## **3. Visual D installer**

1. Go on the official webpage [VisualD installer](https://rainers.github.io/visuald/visuald/StartPage.html) that bundles everything needed for D on Windows. That installer will install VisualD, LDC and DMD on your computer.
2. During the installation process, the VisualD installer will ask you if you want to integrate in Microsoft Visual Studio IDE the D language extension. **Yes you want to.**  
   This will add a specific D menu into the Microsoft IDE (to access D specific function directly from the Visual Studio graphic user interface).


## **4. Set up the DUB/LDC path in the** `PATH` **environment variable**

Normally, the Visual D installer should have already set up the `PATH` environment variable, adding the path to `ldc2.exe`:

1. You can check this by opening the environment variable setup in your system:

![](assets/envvars.png)

**If you have the LDC path in your PATH variable: nothing else to do!**

Otherwise, follow the instructions below:

2. If you are lazy, we advise you to go to the [LDC official github repository](https://github.com/ldc-developers/ldc/releases) & download the latest LDC stable release (multilib version is highly recommended).
3. Launch this executable (for instance LDC.1.29-multilib.exe)
4. Follow the instructions.
5. At the end of the process, the installer will ask you if you want to add the right LDC PATH automatically. Do so :-)
6. You can do that everytime you want to update LDC.

If you don't want to do this (you are not lazy) :

1. Go the the Windows Configuration Panel, search for "environment variables" & add into the PATH the path to the LDC root folder:

![](assets/ldc-path.png)

**Here is a detailed guide to set your environment variables:** [https://www.computerhope.com/issues/ch000549.htm](https://www.computerhope.com/issues/ch000549.htm)

_Note: environment variables are inherited from parent process to child process. After modifying them, you will have to restart your IDE, or terminal window, in order for them to udpate._


## **5. This is the END...**

Open a `CMD.exe` and try `dub --version`. You should get an answer from the system with a version number. You can now start writing D code & compile it!

Some useful commands:
  * `dub -a x86` builds a 32-bit program using LDC
  * `dub -a x86_64` builds a 64-bit program using LDC
  * `dub -a x86 --compiler dmd` builds a 32-bit program using DMD
  * `dub -a x86_64 --compiler dmd` builds a 64-bit program using DMD
  * `dub generate visuald` generates a 64-bit LDC VisualD solution.
  * `dmd --version` tells your DMD version.
  * `ldc2 --version` tells your LDC version.
  * `rdmd file.d` builds and run a single-file D program in `file.d`.

_Warning: both DMD and LDC comes with their own dub. The one that is used depends on who is first in the PATH envvar._


## **An issue while installing D language ?**

In case you encounter an issue while installing the D programming language, do not hesitate to post your questions on the D.learn forum: https://forum.dlang.org/group/learn
