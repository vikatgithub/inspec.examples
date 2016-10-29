#Custom matchers

RSpec::Matchers.define :be_subset_of do |valid_list|
  match do |actual_list|
    return true if actual_list.nil? or actual_list.empty?
    return false if valid_list.nil? or valid_list.empty?
    actual_list.each do |item|
      next if valid_list.include?item
      return false
    end
    return true
  end
end
