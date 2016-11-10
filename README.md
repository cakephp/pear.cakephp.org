# pear.cakephp.org

This is the repository that is used to serve up [http://pear.cakephp.org](http://pear.cakephp.org).

## Usage

```shell
# build the image
docker build . cakephp/pear

# run the image with a mounted volume
docker run
  -it
  -v some/public/dir/with/pear/zip/files:/data/public
  cakephp/pear
```

## Deployment

This is deployed via Docker on [Dokku](http://dokku.viewdocs.io/dokku/).
