require "bundler/setup"
require "filterable_attributes"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

class UserSerializer < ActiveModel::Serializer
  include ActiveModelSerializers::FilterableAttributes

  def self.defined_and_filtered(name, options = {})
    attribute name do
      "attributed_#{name}"
    end
    filter_attribute name, options do
      "#{name}"
    end
  end

  [
      [:filtered_true, { if: :true? }],
      [:filtered_unless, { unless: :false? } ],
      [:filtered_if_proc, { if: -> { true } }],
      [:filtered_unless_proc, { unless: -> { false } }],
      [:unfiltered_true, { if: :true? }],
      [:unfiltered_unless, { unless: :false? } ],
      [:unfiltered_if_proc, { if: -> { true } }],
      [:unfiltered_unless_proc, { unless: -> { false } }],
  ].each do |name, options|
    defined_and_filtered(name, options)
  end

  def true?
    true
  end

  def false?
    false
  end
end
