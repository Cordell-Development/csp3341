module Admin
  class ApiUsagesController < ApplicationController
    def index
      @api_usages = ApiUsage.all
    end
  end
end
