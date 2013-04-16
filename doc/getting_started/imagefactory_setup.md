Set up and configure image factory
==================================

Checkout and Build ImageFactory and plugins
-------------------------------------------

  make rpm 

(alternatively, you can run from source, but you need the
plugins installed via rpm at the moment).

  cd imagefactory-plugins/; make rpm

If you are missing any dependencies that are not yet in fedora, you
can add the imagefactory repo, located here:
http://repos.fedorapeople.org/repos/aeolus/imagefactory/testing/repos/fedora/

yum install ~/rpmbuild/RPMS/noarch/imagefactory-*

Run factory
-----------

sudo /usr/bin/imagefactoryd --debug --no_ssl --no_oauth --foreground 

another alternative to to create a conf file here with the flags you
care about, for example:

``` json
{
  "rest": "true",
  "imgdir": "/where/you/want/images",
  "no_oauth" : "true",
  "no_ssl" : "true",
  "debug" : "true",
  "foreground" : "true",
  "ec2_build_style": "snapshot",
  "ec2_ami_type": "s3",
  "rhevm_image_format": "qcow2",
  "proxy_ami_id": "ami-id",
  "max_concurrent_local_sessions": 2,
  "max_concurrent_ec2_sessions": 4,
  "ec2-32bit-util": "m1.small",
  "ec2-64bit-util": "m1.large",
  "image_manager": "file",
  "image_manager_args": { "storage_path":
"/some/full/path/storage"}
}
```

Then simply run:
  sudo ./imagefactoryd --conf my.conf
