# pear.cakephp.org

This is the repository that is used to serve up [http://pear.cakephp.org](http://pear.cakephp.org).

## Usage

```shell
# build the image
docker build . cakephp/pear

# run the image with a mounted volume
docker run
  -it
  -v some/public/dir/with/pear/zip/files:/data
  cakephp/pear
```

## Deploying

On the Dokku server:

```shell
# create the app
dokku apps:create pear

# create requisite persistent storage
mkdir -p /var/lib/dokku/data/storage/pear
chown 32767:32767 /var/lib/dokku/data/storage/pear

# mount the storage, docker socket, and docker binary
dokku storage:mount pear /var/lib/dokku/data/storage/pear:/data
```

On your local computer:

```shell
# add the remote
git remote add dokku dokku@SERVER_IP:pear

# push the app
git push dokku master
```
