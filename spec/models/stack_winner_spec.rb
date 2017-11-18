require 'rails_helper'

RSpec.describe StackWinner, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:stack) }
end
