# 定义变量
$PROJECT_ID = "freetier-only"
$image = "gcr.io/$PROJECT_ID/dynamic-webapp"
$project_root = "../"

gcloud builds submit $project_root --tag $image

# 部署到 Cloud Run (台湾区域 asia-east2)
gcloud run deploy dynamic-webapp --image $image --platform managed --allow-unauthenticated `
    --region asia-east2
