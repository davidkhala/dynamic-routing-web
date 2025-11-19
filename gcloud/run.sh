PROJECT_ID="freetier-only"
image="gcr.io/$PROJECT_ID/dynamic-webapp"
project_root="../"
dockerfile_path="../Dockerfile"
gcloud builds submit $project_root --tag $image --dockerfile $dockerfile_path

gcloud run deploy dynamic-webapp --image $image --platform managed --allow-unauthenticated \
  --region asia-east2 # taiwan region
