# Image Versions REST API

## Create Image Version

### Request
```xml
  curl -X POST --header "Accept: application/xml" --header \
  "Content-Type: application/xml" http://localhost:3000/tim/image_versions --data \
  "<image_version>
    <base_image id='3'></base_image>
  </image_version>
```

### Respone

#### Headers
```
  HTTP Status Code: 201
```
#### Body
```xml

  <image_version href='http://localhost:3000/tim/image_versions/5' id='5'>
    <base_image href='http://localhost:3000/tim/base_images/1' id='1'></base_image>
    <target_images>
    </target_images>
  </image_version>
```

## Show Image Version

### Request
```
  curl --header "Accept: application/xml" http://localhost:3000/tim/image_versions/1
```
### Respone

#### Headers
```
  HTTP Status Code: 200
```
#### Body
```xml

  <image_version href='http://localhost:3000/tim/image_versions/1' id='1'>
    <base_image href='http://localhost:3000/tim/base_images/1' id='1'></base_image>
    <target_images>
    </target_images>
  </image_version>
```

## List Image Versions

### Request
```
  curl --header "Accept: application/xml" http://localhost:3000/tim/image_versions
```
### Respone

#### Headers
```
  HTTP Status Code: 200
```
#### Body
```xml
  <image_versions>
    <image_version href='http://localhost:3000/tim/image_versions/1' id='1'></image_version>
    <image_version href='http://localhost:3000/tim/image_versions/2' id='2'></image_version>
    <image_version href='http://localhost:3000/tim/image_versions/3' id='3'></image_version>
  </image_versions>
```

## Update Image Version

### Request
```xml
  curl -X PUT --header "Accept: application/xml" --header \
  "Content-Type: application/xml" http://localhost:3000/tim/image_versions/1 --data \
  "<image_version>
    <base_image id='2'></base_image>
  </image_version>"
```
### Respone

#### Headers
```
  HTTP Status Code: 200
```
#### Body
```xml
  <image_version href='http://localhost:3000/tim/image_versions/1' id='1'>
    <base_image href='http://localhost:3000/tim/base_images/2' id='2'></base_image>
    <target_images>
    </target_images>
  </image_version>
```

## Delete Image Version

### Request
```
  curl -X DELETE--header "Accept: application/xml" http://localhost:3000/tim/image_versions/1
```
### Respone

#### Headers
```
  HTTP Status Code: 204
```
