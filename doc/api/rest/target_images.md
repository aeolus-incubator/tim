# Target Images REST API

## Create Target Image

### Request
```xml
  curl -X POST --header "Accept: application/xml" --header \
  "Content-Type: application/xml" http://localhost:3000/tim/target_images --data \
  "<target_image>
    <image_version id='2' />
  </target_image>"
```
### Response
####Headers
```
HTTP Status Code: 201

```
#### Body
```xml
<target_image href='http://localhost:3000/tim/target_images/1' id='1'>
  <target>EC2</target>
  <status>BUILDING</status>
  <status_detail></status_detail>
  <progress>0</progress>
  <image_version href='http://localhost:3000/tim/image_versions/2' id='2'></image_version>
  <provider_images></provider_images>
</target_image>
```
## Show Target Image
### Request
```
  curl --header "Accept: application/xml" http://localhost:3000/tim/target_images/1
```
### Response
####Headers
```
HTTP Status Code: 200
```
#### Body
```xml
  <target_image href='http://localhost:3000/tim/target_images/1' id='1'>
    <target>EC2</target>
    <status>COMPLETE</status>
    <status_detail></status_detail>
    <progress>100</progress>
    <image_version href='http://localhost:3000/tim/image_versions/2' id='2'></image_version>
    <provider_images></provider_images>
  </target_image>
```
## List Target Image
### Request
```
  curl --header "Accept: application/xml" http://localhost:3000/tim/target_images
```
### Response
####Headers
```
HTTP Status Code: 200
```
#### Body
```xml
  <target_images>
    <target_image href='http://localhost:3000/tim/target_images/1' id='1'></target_image>
    <target_image href='http://localhost:3000/tim/target_images/2' id='2'></target_image>
    <target_image href='http://localhost:3000/tim/target_images/3' id='3'></target_image>
  </target_images>
```
## Delete Target Image
### Request
```
  curl -X DELETE --header "Accept: application/xml" http://localhost:3000/tim/target_images/1
```
### Response

####Headers
```
HTTP Status Code: 204
```

## Update Target Image
### Request
```xml
  curl -X PUT --header "Accept: application/xml" --header \
  "Content-Type: application/xml" http://localhost:3000/tim/target_images/2 --data \
  "<target_image>
    <image_version id='3'></image_version>
  </target_image>"
```
### Response
####Headers
```
HTTP Status Code: 204
```