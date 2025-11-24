# 定义变量
$PROJECT_ID = "freetier-only"
$REGION = "asia-east2"
$REPO = "cloud-run-source-deploy"
$IMAGE_NAME = "dynamic-webapp"
$project_root = "../"

# 镜像路径改为 Artifact Registry 格式
$image = "$REGION-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE_NAME"

# 构建并推送镜像到 Artifact Registry
gcloud builds submit $project_root --tag $image

# FIXME permission issue
# 部署到 Cloud Run (台湾区域 asia-east2)
gcloud run deploy $IMAGE_NAME --image $image --platform managed --allow-unauthenticated --region $REGION
