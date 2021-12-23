while getopts o:n:p: flag
do
    case "${flag}" in
        o) outputPath=${OPTARG};; #path to a folder on your computer to put spec.html
        n) containerName=${OPTARG:-markua-spec};; #optionally set the container name
        p) preserveContainer=${OPTARG};; #set to t or true to preserve the container afterwards
    esac
done     

if [ $containerName="" ]; then
    containerName=markua-spec
fi

if [ $outputPath="" ]; then
    outputPath=$HOME/Desktop
fi

docker build -t lua-image .
docker run --name $containerName -v $outputPath:/spec lua-image & sleep 3 #nasty hack to wait for the container to start

docker exec $containerName rm -f spec.html
docker exec $containerName rm -f spec/spec.html
docker exec $containerName make spec.html
docker exec $containerName cp spec.html spec 

docker stop $containerName
echo "$preserveContainer abc"
if ([[ "$preserveContainer" == "t" ]] || [[ "$preserveContainer" == "true" ]]) && [[ "$preserveContainer" != "" ]]; then
    echo "preserved container"
else
    docker rm $containerName
fi
echo "spec generated as spec.html in the path $outputPath"