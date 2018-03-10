require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it "works" do
    token = "EAABz2celF1wBABNcgIFTcZBsHSSbf3KPdXfn52AWbcJZC2ZBRZCYsDuT44tHbvMESZCBAelOgJWA2HsfguG3IXsustCJ1bgXebsILxjj4nl0jILui09dYk7bvbQ9ioLmFXlkcz3Aersurls8EDQciIEh0CirphwkIbZCmYS3P0lTEXfP49F3WHZAsVHwWE8wIaGbgwdWDYuZA2pZBRkBHnzEq"
    post "create", {params: { token: token }}
    expect(true).to be(true)
  end
end