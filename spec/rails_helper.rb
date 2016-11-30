require 'spec_helper'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request
  config.infer_spec_type_from_file_location!
end
