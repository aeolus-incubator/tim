class ProviderAccount < ActiveRecord::Base
  has_many :provider_images, :class_name => "Tim::ProviderImage"

  # Provider Accounts must implement this method.  It should return a string
  # containing an XML definition of this accounts credentials.  The format
  # should take the form described in the imagefactory documentation found here:
  # http://imgfac.org/documentation/cred_provider_examples.html
  def format_credentials
    "<provider_credentials>
       <mock_credentials>
         <username>mockuser</username>
         <password>moscpassword</password>
       </mock_credentials>
     </provider_credentials>"
  end
end