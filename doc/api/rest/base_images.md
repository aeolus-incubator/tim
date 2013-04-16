# Base Images REST API

## Create Base Image

### using an existing Template

#### Request
```xml
  curl -X POST --header "Accept: application/xml" --header "Content-Type: application/xml" --data "
  <base_image>
    <name>MyFirstBaseImage</name>
    <description>This is my very first base image</description>
    <template href='http://localhost:3000/tim/templates/3' id='3'></template>
  </base_image>
  " http://localhost:3000/tim/base_images
```

#### Response

##### Headers

```
  HTTP Status Code: 201
```

##### Body
```xml
  <base_image href='http://localhost:3000/tim/base_images/15' id='15'>
    <name>MyFirstBaseImage</name>
    <description>This is my very first base image</description>
    <template href='http://localhost:3000/tim/templates/36' id='36'></template>
    <image_versions>
    </image_versions>
  </base_image>
```

### and create a new Template

#### Request
```xml
  curl -X POST --header "Accept: application/xml" --header "Content-Type: application/xml" --data "
  <base_image>
    <name>MyFirstBaseImage</name>
    <description>This is my very first base image</description>
    <template>
      <name>mock</name>
      <os>
        <name>RHEL-6</name>
        <version>1</version>
        <arch>x86_64</arch>
        <install type'iso'>
          <iso>http://mockhost/RHELMock1-x86_64-DVD.iso</iso>
        </install>
        <rootpw>password</rootpw>
      </os>
      <description>Mock Template</description>
    </template>
  </base_image>
  " http://localhost:3000/tim/base_images
```

#### Response

##### Headers
```
  Code: 201
```

##### Body
```xml
  <base_image href='http://localhost:3000/tim/base_images/15' id='15'>
    <name>MyFirstBaseImage</name>
    <description>This is my very first base image</description>
    <template href='http://localhost:3000/tim/templates/36' id='36'></template>
    <image_versions>
    </image_versions>
  </base_image>
```

### Create Base Image with Template, a single Image Version with a Single Target Image

#### Request
```xml
  curl -X POST --header "Accept: application/xml" --header "Content-Type: application/xml" --data "
  <base_image>
    <name>MyFirstBaseImage</name>
    <description>ThisIsABaseImage</description>
    <template>
      <name>mock</name>
      <os>
        <name>RHEL-6</name>
        <version>1</version>
        <arch>x86_64</arch>
        <install type='iso'>
          <iso>http://mockhost/RHELMock1-x86_64-DVD.iso</iso>
        </install>
        <rootpw>password</rootpw>
      </os>
      <description>Mock Template</description>
    </template>
    <image_versions type='array'>
     <image_version>
        <target_images type='array'>
          <target_image>
            <target>MockSphere</target>
          </target_image>
        </target_images>
      </image_version>
    </image_versions>
  </base_image>
  " http://localhost:3000/tim/base_images
```

#### Response

##### Headers
```xml
  Code: 201
```

#####  Body
```xml
  <base_image href='http://localhost:3000/tim/base_images/16' id='16'>
    <name>MyFirstBaseImage</name>
    <description>ThisIsABaseImage</description>
    <template href='http://localhost:3000/tim/templates/37' id='37'></template>
    <image_versions>
      <image_version href='http://localhost:3000/tim/image_versions/12' id='12'></image_version>
    </image_versions>
  </base_image>
```

### Import Image

#### Request
```xml
  curl -X POST --header "Accept: application/xml" --header "Content-Type: application/xml" --data "
  <base_image>
    <name>MyFirstBaseImage</name>
    <description>This is my very first base image</description>
    <template href='http://localhost:3000/tim/templates/3' id='3'></template>
    <import>true</import>
    <image_versions type='array'>
      <image_version>
        <target_images type='array'>
          <target_image>
            <target>ec2</target>
            <provider_images type='array'>
              <provider_image>
                <provider>Amazon EC2</provider>
                <external_image_id>ami-123456</external_image_id>
              </provider_image>
            </provider_images>
          </target_image>
        </target_images>
      </image_version>
    </image_versions>
  </base_image>
  " http://localhost:3000/tim/base_images
```

#### Response

##### Headers
```
  HTTP Status Code: 201
```

##### Body
```xml
  TODO
```

### Show Base Image

#### Request
```xml
  curl --header "Accept: application/xml" http://localhost:3000/tim/base_images/1
```

#### Response

##### Headers

```
  HTTP Status Code: 200
```

##### Body
```xml
  <base_image href='http://localhost:3000/tim/base_images/1' id='1'>
    <name>MyFirstBaseImage</name>
    <description>This is my very first base image</description>
    <image_versions>
      <image_version href='http://localhost:3000/tim/image_versions/1' id='1'></image_version>
    </image_versions>
  </base_image>
```

### List Base Images

#### Request
```xml
  curl --header "Accept: application/xml" http://localhost:3000/tim/base_images
```

#### Response

##### Headers
```
  HTTP Status Code: 200
```

##### Body
```xml
  <base_images>
    <base_image href='http://localhost:3000/tim/base_images/1' id='1'></base_image>
    <base_image href='http://localhost:3000/tim/base_images/2' id='2'></base_image>
    <base_image href='http://localhost:3000/tim/base_images/3' id='3'></base_image>
  </base_images>
```

### Delete Base Image

#### Request
```xml
  curl -X DELETE --header "Accept: application/xml" http://localhost:3000/tim/base_images/1
```
#### Response

##### Headers
```
  HTTP Status Code: 204
```