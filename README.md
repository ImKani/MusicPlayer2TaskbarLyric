# MusicPlayer2 任务栏歌词集成版

这是一个个人修改版集成项目，用来把 MusicPlayer2 的当前歌词显示到 Windows 任务栏里的 TrafficMonitor 插件项中。

这套东西由两个绑定的部分组成：

- 修改版 `MusicPlayer2.exe`：负责解析歌词，并通过共享内存发布歌词状态。
- `MusicPlayer2Lyric.dll`：TrafficMonitor 插件，负责读取共享内存并绘制任务栏歌词。

两者需要使用同一次构建产物。不要只更新其中一个，否则可能因为 IPC 版本不一致导致插件读不到歌词。

## 当前功能

- MusicPlayer2 向共享内存发布当前歌词、下一句歌词、歌词进度和歌曲信息。
- TrafficMonitor 插件显示 MusicPlayer2 当前歌词。
- 支持同时间戳多行歌词：
  - 第 1 行是主歌词。
  - 同时间戳后续行按出现顺序保存为第 2 行、第 3 行、第 4 行。
  - 不自动判断哪一行是罗马音/发音、哪一行是翻译。
  - MusicPlayer2 本体原来的“翻译”显示使用你选中的并列行。
  - 默认选择最后一行，适合“原文 + 罗马音 + 中文翻译”这类歌词。
- TrafficMonitor 插件最多显示三行：
  - 主歌词。
  - 并列第 2 行。
  - 并列第 3 行。

## 发布文件

当前 x64 发布文件在：

```text
release\x64\MusicPlayer2.exe
release\x64\MusicPlayer2Lyric.dll
```

## 安装测试

1. 关闭 MusicPlayer2 和 TrafficMonitor。
2. 备份你当前 MusicPlayer2 目录里的原 `MusicPlayer2.exe`。
3. 用下面这个文件替换 MusicPlayer2 目录里的 exe：

```text
release\x64\MusicPlayer2.exe
```

4. 把下面这个 DLL 复制到 TrafficMonitor 的插件目录：

```text
release\x64\MusicPlayer2Lyric.dll
```

5. 启动 MusicPlayer2。
6. 启动或重载 TrafficMonitor。
7. 在 TrafficMonitor 中添加或启用 `MusicPlayer2 歌词` 插件项。

## MusicPlayer2 设置

现在不需要手写 `config.ini` 了。打开：

```text
选项设置 -> 歌词设置 -> 歌词选项 -> 同时间戳并列歌词行
```

可选项：

- `默认：最后一行`：写入 `parallel_lyric_line=-1`，推荐默认值。
- `第2行`：写入 `parallel_lyric_line=1`。
- `第3行`：写入 `parallel_lyric_line=2`。
- `第4行`：写入 `parallel_lyric_line=3`。

保存后配置会写入 MusicPlayer2 当前使用的 `config.ini`：

```ini
[config]
parallel_lyric_line=-1
```

这个设置控制 MusicPlayer2 本体把哪一条并列行当作“翻译”显示。TrafficMonitor 插件仍然会收到完整的并列行列表。

## 插件设置

插件会在 TrafficMonitor 提供的插件配置目录中生成：

```text
MusicPlayer2Lyric.ini
```

默认内容类似：

```ini
[config]
max_display_lines=3
force_three_lines=0
show_song_info=1
show_current_next=0
primary_font_percent=90
supplement_font_percent=80
min_item_width=120
max_item_width=360
```

含义：

- `max_display_lines`：任务栏最多显示几行，范围 `1` 到 `3`。
- `force_three_lines`：设为 `1` 时，只要有两条补充行就强制三行显示；设为 `0` 时根据任务栏高度自动降级。
- `show_song_info`：设为 `1` 时在左侧显示“曲名/歌手”信息区，并用分隔线和歌词区域区分。
- `show_current_next`：设为 `1` 时只显示“当前歌词 + 下一句歌词”，并强制不显示翻译、罗马音或其他并列行。
- `primary_font_percent`：三行显示时第 1 行字号比例，范围 `50` 到 `100`。
- `supplement_font_percent`：第 2/3 行字号比例，范围 `50` 到 `100`。
- `min_item_width`：插件项最小宽度，单位为 DPI 前像素。
- `max_item_width`：插件项最大宽度，单位为 DPI 前像素。

这些配置也可以在 TrafficMonitor 的“插件管理”中选中 `MusicPlayer2 歌词` 后点“选项”修改，不一定要手动编辑 ini。

修改插件 ini 后，重启或重载 TrafficMonitor 生效。

## 构建

当前机器使用的构建环境：

- Visual Studio Build Tools：`C:\BuildTools`
- MSVC v143
- MFC 和 ATL for v143
- Windows SDK `10.0.26100.0`

刷新 `release\x64`：

```powershell
.\scripts\build-release.ps1
```

生成带日期的发布包：

```powershell
.\scripts\package-release.ps1
```

## 源码位置

这个文件夹是集成项目入口，不复制完整上游源码。实际源码仍在同级目录：

```text
..\MusicPlayer2
..\TrafficMonitorPlugins
```

主要修改文件：

- `..\MusicPlayer2\MusicPlayer2\Lyric.h`
- `..\MusicPlayer2\MusicPlayer2\Lyric.cpp`
- `..\MusicPlayer2\MusicPlayer2\Mp2LyricIpc.h`
- `..\MusicPlayer2\MusicPlayer2\Mp2LyricIpc.cpp`
- `..\MusicPlayer2\MusicPlayer2\CUIDrawer.cpp`
- `..\MusicPlayer2\MusicPlayer2\LyricSettingsDlg.h`
- `..\MusicPlayer2\MusicPlayer2\LyricSettingsDlg.cpp`
- `..\MusicPlayer2\MusicPlayer2\MusicPlayer2.rc`
- `..\TrafficMonitorPlugins\Plugins\MusicPlayer2Lyric`

## 分享和法律风险

自用风险最低。如果小范围分享给朋友：

- 带上 `licenses` 目录。
- 明确说明这是个人修改版，不是 MusicPlayer2 或 TrafficMonitor 官方版本。
- 最好同时分享源码改动或补丁。
- 不要附带歌曲、歌词文本、封面等版权内容。
