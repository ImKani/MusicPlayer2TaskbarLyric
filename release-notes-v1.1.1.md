# MusicPlayer2 任务栏歌词集成版 v1.1.1

这是一个整合包补丁版本，主要修正 TrafficMonitor 插件在非强制三行显示时无法选择同时间戳并列歌词末行或指定副行的问题。

## 主要变化

- 插件新增 `parallel_lyric_line` 配置项。
- 插件设置窗口新增“Parallel lyric line”输入项。
- 非强制三行显示时，插件会从同时间戳并列歌词中选择一条副行显示。
- `parallel_lyric_line=0` 表示显示末行，适合“原文 / 罗马音 / 翻译”这类歌词，默认通常显示翻译。
- `parallel_lyric_line=1` 到 `3` 表示显示指定副行。
- 强制三行显示仍然保留多行展示，不受单行选择影响。

## 配置示例

```ini
[config]
max_display_lines=3
force_three_lines=0
show_song_info=1
show_current_next=0
parallel_lyric_line=0
primary_font_percent=90
supplement_font_percent=80
min_item_width=120
max_item_width=360
```

配置也可以在 TrafficMonitor 中打开：

```text
选项 -> 常规设置 -> 插件管理 -> MusicPlayer2 歌词 -> 选项
```

## 许可和说明

这是个人修改版，不是 MusicPlayer2 或 TrafficMonitor 官方版本。

本整合包包含基于 `zhongyang219/MusicPlayer2` 的修改版程序、TrafficMonitor 歌词插件和示例配置文件，并保留各上游项目的版权和许可声明。

MusicPlayer2 上游项目使用 GPLv3。如果分发修改版 `MusicPlayer2.exe`，应同时提供对应源码。TrafficMonitor 插件代码基于 MIT 许可证的 `zhongyang219/TrafficMonitorPlugins`。

请不要随包分发歌曲、歌词文本、封面等版权内容。
