require 'spec_helper'

describe CheckIn do
  it { should have_valid(:state).when("pending", "on_time", "missed")}
  it { should_not have_valid(:state).when("", nil,)}
end
