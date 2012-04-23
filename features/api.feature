Feature: Manage Images API
As a client of the conductor management API
In order to manage the full life cycle of images in the system
I want to be able to Build, Push, Import, View, Update and Delete Images and Image related objects

Background:
    Given I am an authorised user
    And I use my authentication credentials in each request

  Scenario: Building an Image
    Given I have created an TDL description of an image
    When I request to build an image from the TDL for a particular type of Provider
    Then an Image should be created
    And I should receive an accepted response
    And the response should contain a new image as XML
    And the response should contain a new image version as XML
    And the response should contain a new target image as XML
    And the response should contain a a new template as XML

  Scenario: Building an Image request fails
    Given I have created an TDL description of an image
    When I request to build an image from the TDL for a particular type of Provider
    And conductor was unable to fulfill the request
    Then I should received a failure response
    And that response should contain a description explaining why the request failed
    And that response should contain a specific error code appropriate for the failure
    And no Image, Image Version or Target Image should be created

  Scenario: Pushing an Image
    Given there exists a provider with suitable credentials
    And there exists an image which has already been built for this provider type
    When I request to push that image
    Then a Provider Image should be created
    And the Image should start to get pushed to the provider
    And I should receive an accepted response
    And the response should contain a new provider image as XML

  Scenario: Pushing an Image request fails
    When I request to push an image
    And conductor was unable to fulfill the request
    Then I should received a failure response
    And that response should contain a description explaining why the request failed
    And that response should contain a specific error code appropriate for the failure
    And no Provider Image should be created

  Scenario: Import an Image
    Given there exists a provider
    And a provider image has been created for that provider outside of conductor
    When I request to import that image into conductor
    Then a new conductor Image, Image Version, Target Image and Provider Image should be created
    And I should received an accepted response
    And the response should contain the image hierarchy as XML

  Scenario: Importing an Image request fails
    When I request to import an image
    And conductor was unable to fulfill the request
    Then I should received a failure response
    And that response should contain a description explaining why the request failed
    And that response should contain a specific error code appropriate for the failure
    And no Image, Image Version, Target Image or Provider Image should be created

  Scenario: List All Images
    Given there exists some images
    When I request to list the images
    Then I should received an accepted response
    And that response should contain a list of all images as XML
    And each image in the list should contain all the fields and values for that image
    And each image should contain a list of image versions
    And each image should contain a reference to its template

  Scenario: List All Image Version for a particular Image
    Given there exists an Image
    And that image has some image versions
    When I request to list the image versions for that image
    Then I should received an accepted response
    And that response should contain a list of only the image versions associated with the images as XML
    And each image version in the list should contain all the fields and values for that image version
    And each image version should contain a list of target images

  Scenario: List all target images for a particular image version
    Given there exists an image version
    And that image version has some target images
    When I request a list of the target images for that image version
    Then I should receive an accepted response
    And the response should contain a list of only the target images for that image version as XML
    And each target image in the list should contain all the fields and values for that target image
    And each target image should contain a list of provider images

  Scenario: List all provider images for a particular target image
    Given there exists a target image
    And that image version has some provider images
    When I request a list of the provider images for that target image
    Then I should receive an accepted response
    And the response should contain a list of only the provider images for that image version as XML
    And each provider image in the list should contain all the fields and values for that provider image

  Scenario: List all Image Versions
    Given I have some image versions
    When I request to list the image versions
    Then I should received an accepted response
    And that response should contain a list of all image versions as XML

  Scenario: List all Target Images
    Given I have some target images
    When I request to list the target images
    Then I should received an accepted response
    And that response should contain a list of all target images as XML

  Scenario: List all Provider Images
    Given I have some provider images
    When I request to list the provider images
    Then I should received an accepted response
    And that response should contain a list of all provider images as XML

  Scenario: Get details of an image
    Given there exists an image
    When I request to view those details as XML
    Then I should receive an accepted response
    And that response should contain all fields and values for that image
    And that response should contain a list of all image versions for that image
    And that response should contain a reference to the image template

  Scenario: Get details of an image version
    Given there exists an image version
    When I request to view those details as XML
    Then I should receive an accepted response
    And that response should contain all fields and values for that image version
    And that response should contain a list of all target images for that image

  Scenario: Get details of a target image
    Given there exists a target image
    When I request to view those details as XML
    Then I should receive an accepted response
    And that response should contain all fields and values for that target image
    And that response should contain a list of all provider images for that image

  Scenario: Get details of a provider image
    Given there exists a provider image
    When I request to view those details as XML
    Then I should receive an accepted response
    And that response should contain all fields and values for that provider image

  Scenario: Update an image
    Given there is an image
    When I update that image
    Then I should receive an ok response
    And the image should be updated with the new details
    And that response should contain the updated image as XML

  Scenario: Update an image version
    Given there is an image version
    When I update that image version
    Then I should receive an ok response
    And the image version should be updated with the new details
    And that response should contain the updated image version as XML

  Scenario: Update an target image
    Given there is an target image
    When I update that target image
    Then I should receive an ok response
    And the target image should be updated with the new details
    And that response should contain the updated target image as XML

  Scenario: Update an provider image
    Given there is an provider image
    When I update that provider image
    Then I should receive an ok response
    And the provider image should be updated with the new details
    And that response should contain the updated provider image as XML

  Scenario: Delete an image
    Given there exists an image
    And I request to delete that image
    Then the image should be deleted
    And any Image Versions, Target Images, Provider Images and templates should be deleted
    And I should receive an deleted response

  Scenario: Delete an image version
    Given there exists an image version
    And I request to delete that image version
    Then the image version should be deleted
    And any Target Images, Provider Images should be deleted
    And I should receive an deleted response

  Scenario: Delete an target image
    Given there exists an target image
    And I request to delete that target image
    Then the target image should be deleted
    And any Provider Images and templates should be deleted
    And I should receive an deleted response

  Scenario: Delete a provider image
    Given there exists a provider image
    And I request to delete that provider image
    Then the provider image should be deleted
    And I should receive an deleted response

  Scenario: Delete an image request failed
    When I request to delete that image
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error

  Scenario: Delete a image version request failed
    When I request to delete an image version
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error

  Scenario: Delete a target image request failed
    When I request to delete a target image
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error

  Scenario: Delete a provider image request failed
    When I request to delete a pro image
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error

  Scenario: Delete an image version
    Given there exists an image version
    And I request to delete that image version
    Then the image version should be deleted
    And any Target Images, Provider Images should be deleted
    And I should receive an deleted response

  Scenario: Update an image
    When I request to update an image
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error

  Scenario: Update an image version
    When I request to update an image versoin
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error

  Scenario: Update a target image
    When I request to update a target image
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error

  Scenario: Update a provider image
    When I request to update a provider image
    And that request fails
    Then I should receive an error response
    And the response should contain an appropriate error code
    And the response should contain a description of the error
