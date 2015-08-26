module VoluntaryFeedback
  module Concerns
    module Model
      module Organization
        module HasCommunities
          extend ActiveSupport::Concern
          
          included do
            has_many :communities
          end
        end
      end
    end
  end
end