# flannel-io/cni-plugin

<https://github.com/flannel-io/cni-plugin>

```bash
git remote add upstream git@github.com:flannel-io/cni-plugin.git
git fetch upstream
git merge v1.2.0
```

## build

```bash
# golang cache
docker run -it --rm \
-w /go/src/github.com/flannel-io/cni-plugin \
-v $PWD/:/go/src/github.com/flannel-io/cni-plugin \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-alpine \
rm -rf vendor && go mod vendor

# devops-go-arch
docker run -it --rm \
-w /go/src/github.com/flannel-io/cni-plugin \
-v $PWD/:/go/src/github.com/flannel-io/cni-plugin \
-e TAG=v1.2.0 \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-alpine \
bash .beagle/build.sh
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="flannel-cni-plugin" \
  -e PLUGIN_MOUNT=".git,vendor" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="flannel-cni-plugin" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
