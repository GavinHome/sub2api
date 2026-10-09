#!/bin/bash
set -e  # 出错时立即停止

# 1. 登录 Docker Hub
echo "登录 Docker Hub..."
docker login || { echo "登录失败"; exit 1; }

# 2. 创建并启动构建器（如果不存在）
echo "创建构建器..."
if ! docker buildx inspect sub2api-builder &>/dev/null; then
    docker buildx create --name sub2api-builder
fi
docker buildx use sub2api-builder
docker buildx inspect --bootstrap

# 3. 安装 QEMU（支持多平台）
echo "安装 QEMU..."
docker run --privileged --rm tonistiigi/binfmt --install all

# 4. 构建并推送多平台镜像
echo "构建镜像..."
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t mabsimon/sub2api:latest \
  --push \
  .

echo "构建完成！"

# 5. 部署docker image到k8s cluster
# echo "部署镜像..."
# cd ../sub2api-deploy
# docker compose up -d
