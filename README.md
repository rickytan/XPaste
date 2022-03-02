# XPaste
This is a Xcode Source Extension to power up your text paste abilities.

## Features
- [x] Paste as base64 string. You can also paste a image data as Base64 string, make sure it has been copied to your pasteboard.
  ```text
  A short text.中文。
  ```
  ```objc
  NSString *text = @"QSBzaG9ydCB0ZXh0LuS4reaWh+OAgg==";
  ```
  ![base64-string](https://user-images.githubusercontent.com/1250207/46783725-f1f7c680-cd5d-11e8-917e-994f9b36518a.gif)

- [x] Paste as string literal
  ```html
  <div class="card" style="width: 18rem;">
    <img class="card-img-top" src=".../100px180/" alt="Card image cap">
    <div class="card-body">
  <h5 class="card-title">Card title</h5>
  <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
  <a href="#" class="btn btn-primary">Go somewhere</a>
    </div>
  </div>
  ```
  ```objc
  NSString *htmlString = @"<div class=\"card\" style=\"width: 18rem;\">\n  <img class=\"card-img-top\" src=\".../100px180/\" alt=\"Card image cap\">\n  <div class=\"card-body\">\n    <h5 class=\"card-title\">Card title</h5>\n    <p class=\"card-text\">Some quick example text to build on the card title and make up the bulk of the card's content.</p>\n    <a href=\"#\" class=\"btn btn-primary\">Go somewhere</a>\n  </div>\n</div>";
  ```
  ![string-literal](https://user-images.githubusercontent.com/1250207/46783558-4a7a9400-cd5d-11e8-80dc-65c2c12f48b1.gif)

- [x] Paste as Unicode string
  ```text
  A short text.中文。😂🤣
  ```
  ```objc
  NSString *unicode = @"A short text.\u4e2d\u6587\u3002\U0001f602\U0001f923";
  ```
  ![unicode-string](https://user-images.githubusercontent.com/1250207/46783817-413df700-cd5e-11e8-9b86-2ad527920089.gif)

- [x] Paste as Url encoded string
  ```text
  http://www.host.com/一段中文路径?key=中文&name=中文#/path/中文
  ```
  ```objc
  NSString *urlString = @"http://www.host.com/%E4%B8%80%E6%AE%B5%E4%B8%AD%E6%96%87%E8%B7%AF%E5%BE%84?key=%E4%B8%AD%E6%96%87&name=%E4%B8%AD%E6%96%87#/path/%E4%B8%AD%E6%96%87";
  ```

- [x] Paste JSON String as Objective-C Dictionary/Array/String variable
  ```json
  {
    "name": "John",
    "age": 30,
    "house": null,
    "cars": [ "Ford", "BMW", "Fiat" ]
  }
  ```
  ```objc
  id object = @{@"age": @30,
                @"cars": @[@"Ford",
                           @"BMW",
                           @"Fiat"],
                @"name": @"John",
                @"house": [NSNull null]};
  ```
  
- [x] Sort imports, and group them to `<>` and `""`
  ```objc
  #import <NELog/NELog.h>
  #import <NKCoreNetwork/NKCoreNetwork.h>
  #import "NKWebViewController.h"
  #import <NKIocProtocols/NKIocProtocols.h>
  #import "NKWebviewURLProtocol.h"
  #import "UIBarButtonItem+NKBarButton.h"
  #import <NEIocProtocols/NEIocProtocols.h>
  ```
  
  ```objc
  #import <NEIocProtocols/NEIocProtocols.h>
  #import <NELog/NELog.h>
  #import <NKCoreNetwork/NKCoreNetwork.h>
  #import <NKIocProtocols/NKIocProtocols.h>

  #import "NKWebViewController.h"
  #import "NKWebviewURLProtocol.h"
  #import "UIBarButtonItem+NKBarButton.h"
   ```

## Install

1. Clone this project, build by yourself with Xcode
2. Or, you can download the binary [here](https://github.com/rickytan/XPaste/releases/download/v1.3/XPaste.app.zip)

Open the **XPaste.app**, you will see following interface, and click **Enable XPaste**, make sure **XPaste Xcode Source Editor** is checked.

![image](https://user-images.githubusercontent.com/1250207/46783018-2cac2f80-cd5b-11e8-9fda-c97126a8167e.png)

Then relaunch your Xcode, it will be shown at **Editor** sub-menu.

![image](https://user-images.githubusercontent.com/1250207/46782854-75171d80-cd5a-11e8-97e1-e9c3023c26c1.png)

## Key bindings
Open Preference of Xcode, search **xpaste** in **Key Bindings** tab.

![image](https://user-images.githubusercontent.com/1250207/46782797-3e410780-cd5a-11e8-84eb-80cd3b28e514.png)

## License
```
MIT License

Copyright (c) 2018 Ricky Tan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
