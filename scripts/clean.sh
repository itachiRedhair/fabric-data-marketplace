git add .

git commit -m "forgot to commit, so autmoatically comitting..."

git clean -xdn

git clean -xdf

docker stop $(docker ps -qa --no-trunc)
docker rm $(docker ps -qa --no-trunc)
docker volume rm $(docker volume ls -qf dangling=true)