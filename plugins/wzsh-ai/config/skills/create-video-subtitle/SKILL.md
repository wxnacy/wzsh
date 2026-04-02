---
name: create-video-subtitle
description: 将视频转为音频后再生成字幕文件
---

# 创建视频字幕

## 转为音频

1. 如果文件同目录有同名音频文件(wav mp3 等常见音频后缀)，则直接使用
2. 如果给的文件不是音频，需要使用 `ffmpeg` 先转为音频，保存到源文件同目录下

转音频的命令

```bash
ffmpeg -i {source_file} -vn -acodec pcm_s16le -ar 16000 {target_file_name}.wav
```

## 生成字幕文件

### 切换虚拟环境

1. 查看当前环境是否为 `conda` 的 `whisperx` 虚拟环境

```bash
conda env list
```

如果已经在虚拟环境中，不要在尝试切换

2. 如果不是需要切换虚拟环境

```bash
source /Users/wxnacy/.wzsh/plugins/wzsh-python/bin/conda-init && conda activate whisperx
```

如果切换失败，程序退出，并通知我

3. 生成字幕文件

如果已存在同名 `srt` 文件，使用时间戳备份已存在文件。
使用命令重新生成并保存到音频文件同目录下

```bash
mlx_whisper {audio_file} --output-dir {source_file_dir} -f srt --model mlx-community/whisper-large-v3-turbo
```

