SimulateIDFA: iOS10 IDFA AD tracking limit solution
==

## Background

Apple updated infos in [advertisingIdentifier](https://developer.apple.com/reference/adsupport/asidentifiermanager/1614151-advertisingidentifier) API Reference

```
Important

In iOS 10.0 and later, the value of advertisingIdentifier is all zeroes when the user has limited ad tracking.
```

It means Apple will no longer make the IDFA of users that have limited ad tracking available to developers。

## SimulateIDFA
SimulateIDFA combine many device infos to create an ID that help disambiguate one device from another. 

It includes deviceName,bootTime,countryCode,deviceModel and so on. 


**Framework dependencies**

* CoreTelephony.framework

Import SimulateIDFA.h and call the function `createSimulateIDFA ` to get `SimulateIDFA`

```
NSString *simulateIDFA = [SimulateIDFA createSimulateIDFA];
NSLog(@"%@", simulateIDFA);
```

outPut

```
626363D0-90D4-06BF-C281-384E4E69D3E2
```

## license

```
The MIT License (MIT)

Copyright (c) 2015 Youmi Technology

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

## [language:zh_CN](https://github.com/youmi/SimulateIDFA/wiki/%E4%B8%AD%E6%96%87%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3)
