# Templates REST API

## Creating a new Template
### Request

```xml
  curl -X POST --header "Accept: application/xml" --header "Content-Type: application/xml" --data "
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
  " http://localhost:3000/tim/templates
```

### Response
#### Headers
```
  HTTP Status Code: 201
```
#### Body
```xml
  <template href='http://localhost:3000/tim/templates/34' id='34'>
    <name>mock</name><os>
        <name>RHEL-6</name>
        <version>1</version>
        <arch>x86_64</arch>
        <install type="iso">
          <iso>http://mockhost/RHELMock1-x86_64-DVD.iso</iso>
        </install>
        <rootpw>password</rootpw>
      </os><description>Mock Template</description>
    <base_images>
    </base_images>
    <custom_content>custom</custom_content>
  </template>
```

## Retrieving an existing Template
### Request

```
  curl --header "Accept:application/xml" http://localhost:3000/tim/templates/34
```

### Response
#### Headers
```
  HTTP Status Code: 200
```
#### Body
```xml
  <template href='http://localhost:3000/tim/templates/34' id='34'>
    <name>mock</name><os>
        <name>RHEL-6</name>
        <version>1</version>
        <arch>x86_64</arch>
        <install type="iso">
          <iso>http://mockhost/RHELMock1-x86_64-DVD.iso</iso>
        </install>
        <rootpw>password</rootpw>
      </os><description>Mock Template</description>
    <base_images>
    </base_images>
    <custom_content>custom</custom_content>
  </template>
```

## List Templates
### Request
```
  curl --header "Accept:application/xml" http://localhost:3000/tim/templates
```
### Response
#### Headers
```
  HTTP Status Code: 200
```

#### Body
```xml
  <templates>
    <template href='http://localhost:3000/tim/templates/33' id='33'></template>
    <template href='http://localhost:3000/tim/templates/35' id='35'></template>
    <template href='http://localhost:3000/tim/templates/36' id='36'></template>
  </templates>
```

## Update an existing Template: Not Implemented

## Delete Template
### Request
```
  curl -X DELETE --header "Accept: application/xml" http://localhost:3000/tim/templates/34
```

### Response
#### Headers
```
  HTTP Status Code: 204
```