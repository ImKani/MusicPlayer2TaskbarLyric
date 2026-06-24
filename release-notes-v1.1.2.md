# MusicPlayer2 任务栏歌词集成版 v1.1.2

这是 `v1.1.1` 的界面补丁版本。

## 主要变化

- 修正中文资源下 TrafficMonitor 插件设置窗口没有显示“并列歌词行”选项的问题。
- 非强制三行时仍可用 `parallel_lyric_line` 选择末行或指定副行。

## 配置说明

```ini
parallel_lyric_line=0
```

- `0` 或 `-1`：显示末行。
- `1` 到 `3`：显示指定副行。

## 许可和说明

这是个人修改版，不是 MusicPlayer2 或 TrafficMonitor 官方版本。

本整合包包含基于 `zhongyang219/MusicPlayer2` 的修改版程序、TrafficMonitor 歌词插件和示例配置文件，并保留各上游项目的版权和许可声明。

MusicPlayer2 上游项目使用 GPLv3。如果分发修改版 `MusicPlayer2.exe`，应同时提供对应源码。TrafficMonitor 插件代码基于 MIT 许可证的 `zhongyang219/TrafficMonitorPlugins`。
