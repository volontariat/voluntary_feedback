module VoluntaryFeedback
  module Concerns
    module Model
      module User
        module HasCommunities
          extend ActiveSupport::Concern
          
          included do
            has_many :communities, through: :organizations
          end
        end
      end
    end
  end
end