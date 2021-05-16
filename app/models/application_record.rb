# frozen_string_literal: true

# Add code to include in all models and then extend this rather than ActiveRecord::Base
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
