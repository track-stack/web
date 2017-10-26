require 'rails_helper'

RSpec.describe Round, type: :model do

  it { should have_many(:turns) }
  it { should belong_to(:game) }

end
