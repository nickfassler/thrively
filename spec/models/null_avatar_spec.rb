require 'spec_helper'

describe NullAvatar do
  describe '#url' do
    it 'is always the default silhouette'do
      NullAvatar.new.url(:anything).should == 'avatar_missing.png'
    end
  end
end
