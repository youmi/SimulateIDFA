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

## Credits
Inspiration from Yann Lechelle's [OpenIDFA](https://github.com/ylechelle/OpenIDFA)。It is not well maintained for 3 years.

SimulateIDFA uses a larger set of fingerprinting techniques. SimulateIDFA are also not time limited.

## 背景
[advertisingIdentifier](https://developer.apple.com/reference/adsupport/asidentifiermanager/1614151-advertisingidentifier) 的说明文档看到这样一句话：

```
Important

In iOS 10.0 and later, the value of advertisingIdentifier is all zeroes when the user has limited ad tracking.
```

也就是说在iOS10上，用户如果开启了 `限制广告跟踪` , 获取的idfa将是一串 `00000000-0000-0000-0000-000000000000`

## SimulateIDFA
`SimulateIDFA` 是根据一堆设备信息（每个app获取的值都是一样的）生成的一个MD5值。用于标志不同设备。

### 使用：

框架依赖：

* CoreTelephony.framework

导入`SimulateIDFA.h、SimulateIDFA.m`两个文件

在需要获取 SimulateIDFA的地方调用代码：

```
NSString *simulateIDFA = [SimulateIDFA createSimulateIDFA];
```

`simulateIDFA`的格式跟`IDFA`的格式一样

```
626363D0-90D4-06BF-C281-384E4E69D3E2
```


### 生成原理
生成的MD5值分两部分。

以 `626363D0-90D4-06BF-C281-384E4E69D3E2` 为例：

前16位`626363D0-90D4-06BF`是由比较稳定的参数组合获得,这前16位只有在系统升级的情况下才会变。

后16位`C281-384E4E69D3E2` 由 一些比较容易被改变的参数组合生成，比较常见的值变化情况是系统重新启动。

* 参与前16位计算的参数有： 

```
系统版本（9.3.2）、硬件信息（N53AP,iPhone6,2,中国移动46002,1048576000）、coreServices文件创建更新时间(2015-08-07 23:53:00 +0000,2016-06-07 23:53:09 +0000),系统容量(12266725376)
```

这里有一些信息是升级的时候会变的，`系统版本`、`coreServices文件创建更新时间`、`系统容量`

* 参与后16位计算的参数有：

```
系统开机时间(1473301191去掉后面的4位数 147330)、国家代码(CN)、本地语言(zh-Hans-CN)、设备名称(XXXX)
```

这里的参数都是比较容易变化的，系统重启离上次重启有10000秒的话会变，其他参数在设置里面可以修改



## SimulateIDFA与OpenIDFA对比

[OpenIDFA](https://github.com/ylechelle/OpenIDFA) 是 Yann Lechelle的一个开源库。同是IDFA的替换方案

### 生成的ID重复的概率对比

假设一个情况。一天内某个国家有10000000（1千万）台相同型号的设备升级到同一个系统。

* SimulateIDFA

一天内这个算法可能的值计算， 24x3600（文件创建时间，单位秒）x 10（文件最后修改时间假设误差在10秒）x 10000000（系统容量误差范围）x 1000000(设备名称范围，这里假设的是每100台就有2个重复)= 8640000000000000000。

设备a的值为 K，那么设备b的值同为K的可能性为： 1/8640000000000000000. 总共有 10000000台设备。因此，这10000000设备中有与a设备的值同为K的可能性为 1/8640000000000000000 x 10000000 = 1/864000000000。

* OpenIDFA

先看一下OpenIDFA的生成算法，OpenIDFA是对下面的参数组合进行MD5.

```
系统开机时间(1473241127 减去后四位值为 147324)、系统容量(29230571520)、系统版本(9.3.4)、机型(N78AP,iPod5,1)、国家代码(CN)、本地语言(zh-Hans-CN)、一些预装的App(由于用的是canOpenURL这个接口，iOS9就已经废了)、时区(Asia/Shanghai)、当天时间(160804, 16年8月4日，这个值是他每天值都会变化的原因)
```

一天内可能的值为系统容量的误差(10000000)。 ps: 系统启动时间在这种情况下对重复率的降低没起到作用，因为OpenIDFA是减去了系统启动时间的后4位来计算的。同理当天时间也是。

设备a的值为 K，那么设备b的值同为K的可能性为： 1/10000000. 总共有 10000000台设备。因此，这10000000设备中有与a设备的值同为K的可能性为 1/10000000 x 10000000 = 1


## 时效性对比
* OpenIDFA 

每天获取的值都不一样

* SimulateIDFA

SimulateIDFA分两部分，前16位是在系统升级的时候才会变化，后16位用户的某些行为可能会导致值变化（例如：重启手机、修改设备名称、修改手机本地语言）

## 总结：
`OpenIDFA` 有一些限制，生成的IDFA会每天变化，在一些极端条件下重复率比较高。 SimulateIDFA在这方面有更好的表现