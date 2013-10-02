require 'spec_helper'

describe Task do
  it { should have_valid(:name).when("Remember keys")}
  it { should_not have_valid(:name).when(" ", nil)}

  it { should belong_to(:user)}

end
