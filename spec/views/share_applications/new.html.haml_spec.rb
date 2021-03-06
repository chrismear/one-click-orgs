require 'spec_helper'

describe 'share_applications/new' do

  let(:user) {mock_model(Member,
    :shares_count => 1
  )}
  let(:share_application) {mock_model(ShareApplication, :amount => nil).as_new_record}

  before(:each) do
    view.stub(:current_user).and_return(user)
    assign(:share_application, share_application)
  end

  it "renders an 'amount' field" do
    render
    rendered.should have_selector(:input, :name => 'share_application[amount]')
  end

  it "renders a submit button" do
    render
    rendered.should have_selector(:input, :type => 'submit')
  end

end
