# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without a name' do
    user = described_class.new

    user.validate

    expect(user.errors['name']).to include "can't be blank"
  end
end
