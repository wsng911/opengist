# Opengist

自托管代码片段分享平台，基于 Git 存储。

## 功能特性
- 代码片段创建与分享
- Git 驱动存储
- 语法高亮
- 公开/私有片段
- 嵌入支持

## 快速部署
```bash
docker run -d -p 6157:6157 -v $(pwd)/data:/opengist --name opengist wsng911/opengist:latest
```
访问 `http://localhost:6157`
