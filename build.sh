END_POINT=$1
TAG=$2
VERSION=$(git rev-parse --verify HEAD)
IMAGE_NAME=nambgit/lab-nextjs$TAG
#IMAGE_NAME=ghcr.io/ascension-six/backmarket$TAG

echo "Build docker image name " $IMAGE_NAME:$VERSION
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

docker build --no-cache -t $IMAGE_NAME:$VERSION . &&
docker build --no-cache -t $IMAGE_NAME:latest . &&
docker push $IMAGE_NAME:$VERSION && 
docker push $IMAGE_NAME:latest &&
#echo $BMK_VERSION $END_POINT
#curl --location --request POST 'https://cms-bmk.ascension6.dev/external_api/deploy/1bd8e53148f3d6ac42332c626d524bbb199a01bce67f7896e5da03dd7cc9d0e5' \
#--header 'Content-Type: application/json' \
#--header 'Cookie: device_view=full' \
#--data-raw '{
    #"version": {
        #"name": "BMK_VERSION",
        #"value": "'$VERSION'"
    #},
    #"stackId": '$END_POINT'
#}'

echo "Build success: $IMAGE_NAME:$VERSION"