# Provider Images REST API

## Create Provider Image

### Request

```xml
  curl -X POST --header "Accept: application/xml" --header \
  "Content-Type: application/xml" http://localhost:3000/tim/provider_images --data \
  "<provider_image>
    <target_image id='1' />
  </provider_image>"
```

### Response

#### Headers

```
  HTTP Status Code: 201
```

#### Body
```xml
  <provider_image href='http://localhost:3000/tim/provider_images/85' id='85'>
    <provider>Amazon EC2</provider>
    <external_image_id>ami-123456</external_image_id>
    <snapshot>false</snapshot>
    <status>NEW</status>
    <status_detail></status_detail>
    <progress>0</progress>
    <target_image href='http://localhost:3000/tim/target_images/1' id='1'></target_image>
  </provider_image>
```
## Show Provider Image

### Request

```xml
  curl --header "Accept: application/xml" http://localhost:3000/tim/provider_images/1
```

### Response

#### Headers

```
  HTTP Status Code: 200
```
#### Body
```xml

  <provider_image href='http://localhost:3000/tim/provider_images/85' id='85'>
    <provider>Amazon EC2</provider>
    <external_image_id>ami-123456</external_image_id>
    <snapshot>false</snapshot>
    <status>NEW</status>
    <status_detail></status_detail>
    <progress>0</progress>
    <target_image href='http://localhost:3000/tim/target_images/1' id='1'></target_image>
  </provider_image>
```
## List Provider Images

### Request

```xml
  curl --header "Accept: application/xml" http://localhost:3000/tim/provider_images
```

### Response

#### Headers
```
  HTTP Status Code: 200

```
#### Body

```xml
  <provider_images>
    <provider_image href='http://localhost:3000/tim/provider_images/1' id='1'></provider_image>
    <provider_image href='http://localhost:3000/tim/provider_images/2' id='2'></provider_image>
    <provider_image href='http://localhost:3000/tim/provider_images/3' id='3'></provider_image>
  </provider_image>
```

## Delete Target Image

### Request

```xml
  curl -X DELETE --header "Accept: application/xml" http://localhost:3000/tim/provider_images/1
```

### Response

#### Headers

```
  HTTP Status Code: 204
```

## Update Target Image

### Request

```xml
  curl -X PUT --header "Accept: application/xml" --header \
  "Content-Type: application/xml" http://localhost:3000/tim/provider_images/2 --data \
  "<provider_image>
    <target_image id='3'></target_image>
  </provider_image>"
```

### Response

#### Headers

```
  HTTP Status Code: 204
```

#### Body

```xml
  <provider_image href='http://localhost:3000/tim/provider_images/84' id='84'>
    <provider></provider>
    <external_image_id></external_image_id>
    <snapshot></snapshot>
    <status></status>
    <status_detail></status_detail>
    <progress></progress>
    <target_image href='http://localhost:3000/tim/target_images/3' id='3'></target_image>
  </provider_image>
```