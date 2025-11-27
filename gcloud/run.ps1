$PROJECT_ID = "freetier-only"
$REGION = "asia-east2" # HK
$REPO = "cloud-run-source-deploy"
$IMAGE_NAME = "dynamic-webapp"
$project_root = "../"
$gserviceaccount = "cloud-region@freetier-only.iam.gserviceaccount.com"
$image = "$REGION-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE_NAME"

gcloud iam service-accounts add-iam-policy-binding $gserviceaccount --member="user:davidkhala@gmail.com" --role="roles/iam.serviceAccountUser" --project=$PROJECT_ID

gcloud builds submit $project_root --tag $image --region $REGION --project=$PROJECT_ID

gcloud run deploy $IMAGE_NAME --image $image --service-account=$gserviceaccount --platform managed --allow-unauthenticated --region $REGION --project=$PROJECT_ID
