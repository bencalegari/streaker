require 'spec_helper'

describe User do
  it {should have_many(:tasks)}  
  it {should have_many(:check_ins).through(:tasks)}
end
