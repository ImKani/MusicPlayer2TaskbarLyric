# MusicPlayer2 任务栏歌词集成版 v1.1.0

这是一个个人修改版整合包，用于将 MusicPlayer2 的当前歌词显示到 Windows 任务栏中的 TrafficMonitor 插件项里。

## 包含内容

- 修改版 `MusicPlayer2.exe`
- TrafficMonitor 插件 `MusicPlayer2Lyric.dll`
- 插件示例配置 `MusicPlayer2Lyric.ini.example`
- 使用说明、许可证和源码链接

## 主要变化

- MusicPlayer2 通过共享内存发布任务栏歌词状态。
- 支持发布曲名、歌手、当前歌词、下一句歌词、翻译和同时间戳并列歌词行。
- 支持同时间戳多行 LRC，例如“原文 / 罗马音 / 翻译”。
- MusicPlayer2 本体增加“同时间戳并列歌词行”选择选项。
- TrafficMonitor 插件支持任务栏显示当前歌词。
- 插件支持最多三行显示、强制三行显示、首行/副行字号比例设置。
- 插件支持曲名/歌手信息区，曲名和歌手分两行显示。
- 插件支持“当前歌词 + 下一句歌词”模式；启用后会强制不显示翻译、罗马音或其他并列行。
- 插件增加设置窗口，可在 TrafficMonitor 插件管理中直接修改显示选项。
- 插件元数据更新为 `1.1.0`，版权信息为 `Copyright (C) 2026 by ImKani`。

## 安装方法

1. 关闭 MusicPlayer2 和 TrafficMonitor。
2. 备份原来的 `MusicPlayer2.exe`。
3. 用本包中的修改版 `MusicPlayer2.exe` 替换 MusicPlayer2 目录中的同名文件。
4. 将 `MusicPlayer2Lyric.dll` 复制到 TrafficMonitor 的 `plugins` 目录。
5. 启动 MusicPlayer2。
6. 启动或重载 TrafficMonitor。
7. 在 TrafficMonitor 的插件管理中启用 `MusicPlayer2 歌词` 项。

## 配置

插件会生成或读取：

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

也可以在 TrafficMonitor 中打开：

```text
选项 -> 常规设置 -> 插件管理 -> MusicPlayer2 歌词 -> 选项
```

## 源码

- 修改版 MusicPlayer2 源码：`https://github.com/ImKani/MusicPlayer2-TaskbarLyric`
- TrafficMonitor 歌词插件源码：`https://github.com/ImKani/TrafficMonitorPlugins-MusicPlayer2Lyric`
- 整合包仓库：`https://github.com/ImKani/MusicPlayer2TaskbarLyric`

## 版权和说明

Copyright (C) 2026 by ImKani.

这是个人修改版，不是 MusicPlayer2 或 TrafficMonitor 官方版本。

MusicPlayer2 上游项目使用 GPLv3。如果分发修改版 `MusicPlayer2.exe`，应同时提供对应源码。TrafficMonitor 插件代码基于 MIT 许可证的 `zhongyang219/TrafficMonitorPlugins`。

请不要随包分发歌曲、歌词文本、封面等版权内容。
