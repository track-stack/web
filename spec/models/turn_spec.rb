require 'rails_helper'

RSpec.describe Turn, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game) }
end
