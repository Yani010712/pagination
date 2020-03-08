class AppsController < ApplicationController
    protect_from_forgery except: :create

    def create
        by = get_by
        start = get_start by
        last = get_end by
        max = get_max
        order = get_order

        if by.eql? 'id' and (not start.is_a?(Integer) or not last.is_a?(Integer))
            @error = "'start' and 'end' values must be Integer when sorting by id"
            return
        end

        if by.eql? 'name' and (not start.is_a?(String) or not last.is_a?(String))
            @error = "'start' and 'end' values must be String when sorting by name"
            return
        end

        if by.eql? 'id' and last >= 0
            if start >= last
                @error = "'start' can't be major or equal than 'end'"
            end
        end

        if by.eql? 'name' and not last.empty?
            if start >= last
                @error = "'start' can't be major or equal than 'end'"
            end
        end
        
        max_size = 50
        all_apps = App.all
        # @response = [sort_by_id(all_apps, order)]
        # @response = [all_apps.sort { |a, b| b <=> a }]
        @response = [get_data(by, start, last, max, order)]
    end

    private
        def range_params
            params.permit({params: {range: [:by, :start, :end, :max, :order]}})
        end

        def get_data(by, start, last, max, order)
            if by.eql? 'id'
                query = "id >= #{start.to_s}"
                    if last.to_i > 0
                        query = "#{query} and id <= #{last.to_s}"
                    end
                if order.eql? 'asc'
                    App.where(query).limit(max).sort { |a, b| a.id <=> b.id }
                else
                    App.where(query).limit(max).sort { |a, b| b.id <=> a.id }
                end
            elsif by.eql? 'name'
                query = "name >= '#{start.to_s}'"
                if not last.to_s.empty?
                    query = "#{query} and name <= '#{last.to_s}'"
                end
                if order.eql? 'asc'
                    App.order(:name).where(query).limit(max).sort { |a, b| a.name <=> b.name }
                else
                    App.order(:name).where(query).limit(max).sort { |a, b| b.name <=> a.name }
                end
            end
        end

        def get_by
            by = range_params[:params][:range][:by]
            if by.nil?
                @error = "the 'by' parameter is required"
            elsif by != "id" and by != "name"
                @error = "the 'by' parameter must be either 'id' or 'name'"
            end
            by
        end

        def get_start(by)
            start = range_params[:params][:range][:start]
            if start.nil?
                if by.eql? 'id'
                    start = 0
                else start = ''
                end
            end
            start
        end

        def get_end(by)
            last = range_params[:params][:range][:end]
            if last.nil?
                if by.eql? 'id'
                    last = -1
                else last = ''
                end
            end
            last
        end

        def get_max
            max = range_params[:params][:range][:max]
            if max.nil?
                max = 50
            end
            max
        end

        def get_order
            order = range_params[:params][:range][:order]
            if order.nil? 
                order = "asc"
            end
            order
        end
end
