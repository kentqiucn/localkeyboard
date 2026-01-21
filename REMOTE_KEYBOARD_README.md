# Remote Keyboard Feature / 远程键盘功能

This document describes the Remote Keyboard feature added to LocalKeyboard.

本文档介绍 LocalKeyboard 新增的远程键盘功能。

## Overview / 概述

The Remote Keyboard feature allows you to use one device (sender) to type text that appears on another device (receiver) over the local network.

远程键盘功能允许您使用一台设备（发送端）输入文本，并将文本显示在另一台设备（接收端）上，通过本地网络传输。

## Use Case / 使用场景

**Example:** You have a Mac where you want to input text, and an Ubuntu machine with a physical keyboard. You can:
1. Run LocalKeyboard on Mac and start the "Receive Input" listener
2. Run LocalKeyboard on Ubuntu, connect to the Mac, and type in the text field
3. Text typed on Ubuntu will appear on Mac and be copied to the clipboard

**示例：** 您在 Mac 上有一个需要输入文本的文本框，在 Ubuntu 机器上有物理键盘。您可以：
1. 在 Mac 上运行 LocalKeyboard 并启动"接收输入"监听器
2. 在 Ubuntu 上运行 LocalKeyboard，连接到 Mac，在文本框中输入
3. 在 Ubuntu 上输入的文本将显示在 Mac 上并复制到剪贴板

## How to Use / 使用方法

### On the Receiving Device (e.g., Mac) / 在接收端设备上（如 Mac）

1. Open LocalKeyboard and go to the **Keyboard** tab
2. In the **Receive Input** section, click **Start Listening**
3. Note the displayed IP address and port (default: 53318)
4. Wait for connections from sender devices

1. 打开 LocalKeyboard 并进入 **远程键盘** 标签页
2. 在 **接收输入** 部分，点击 **开始监听**
3. 记下显示的 IP 地址和端口（默认：53318）
4. 等待发送端设备的连接

### On the Sending Device (e.g., Ubuntu) / 在发送端设备上（如 Ubuntu）

1. Open LocalKeyboard and go to the **Keyboard** tab
2. In the **Send Input** section, either:
   - Click **Scan for Receivers** to automatically discover devices
   - Click the **+** button to manually enter the receiver's IP:port
3. Select or enter the receiver device to connect
4. Once connected, type in the text field
5. Text is sent in real-time as you type
6. Use the **Paste** button to send clipboard content
7. Use the **Clear** button to clear the text

1. 打开 LocalKeyboard 并进入 **远程键盘** 标签页
2. 在 **发送输入** 部分，可以：
   - 点击 **扫描接收端** 自动发现设备
   - 点击 **+** 按钮手动输入接收端的 IP:端口
3. 选择或输入要连接的接收端设备
4. 连接后，在文本框中输入
5. 文本在输入时实时发送
6. 使用 **粘贴** 按钮发送剪贴板内容
7. 使用 **清空** 按钮清除文本

## Technical Details / 技术细节

- Uses WebSocket for real-time communication
- Default port: 53318
- Supports text input, paste, backspace, enter, and clear operations
- Received text is automatically copied to the clipboard on the receiver

- 使用 WebSocket 进行实时通信
- 默认端口：53318
- 支持文本输入、粘贴、退格、回车和清空操作
- 接收到的文本会自动复制到接收端的剪贴板

## Network Requirements / 网络要求

- Both devices must be on the same local network
- Port 53318 must be accessible (not blocked by firewall)
- No internet connection required

- 两台设备必须在同一局域网内
- 端口 53318 必须可访问（未被防火墙阻止）
- 不需要互联网连接

## Files Added / 新增文件

```
app/lib/
├── model/state/
│   └── remote_keyboard_state.dart       # State models
├── provider/
│   └── remote_keyboard_provider.dart    # Provider/Service logic
├── pages/tabs/
│   └── remote_keyboard_tab.dart         # UI component
```

Modified files:
- `app/lib/pages/home_page.dart` - Added Keyboard tab
- `app/assets/i18n/en.json` - English translations
- `app/assets/i18n/zh-CN.json` - Chinese translations

## Building / 构建

After adding these files, run the following commands to generate the necessary code:

添加这些文件后，运行以下命令生成必要的代码：

```bash
cd app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Then build for your target platform:

然后为目标平台构建：

```bash
# For macOS
flutter build macos

# For Linux
flutter build linux
```
