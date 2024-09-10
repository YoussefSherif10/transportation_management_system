# frozen_string_literal: true

class FetchTrucksJob < ApplicationJob
    queue_as :default
  
    def perform
      page = 1
      total_inserted = 0
  
      loop do
        trucks = fetch_trucks(page)
        break if trucks.nil?
  
        inserted_count = process_trucks(trucks)
        total_inserted += inserted_count
  
        Rails.logger.info "Processed page #{page}, inserted/updated #{inserted_count} trucks"
  
        page += 1
        break if page > trucks.headers['total-pages'].to_i
      end
  
      Rails.logger.info "Job completed. Total trucks inserted/updated: #{total_inserted}"
    end
  
    private
  
    def fetch_trucks(page)
      response = HTTParty.get(
        "https://api-task-bfrm.onrender.com/api/v1/trucks",
        headers: { "API_KEY" => ENV['EXTERNAL_API_KEY'] },
        query: { page: page }
      )
  
      if response.code == 200
        JSON.parse(response.body)
      else
        Rails.logger.error "Failed to fetch trucks: #{response.code} - #{response.body}"
        nil
      end
    rescue StandardError => e
      Rails.logger.error "Error fetching trucks: #{e.message}"
      nil
    end
  
    def process_trucks(trucks)
      return 0 if trucks.empty?
  
      prepared_trucks = trucks.map do |truck|
        "(#{truck['id']}, #{sanitize(truck['name'])}, #{sanitize(truck['truck_type'])}, '#{truck['created_at']}', NOW())"
      end
  
      sql = <<-SQL
        INSERT INTO trucks (id, name, truck_type, created_at, updated_at)
        VALUES #{prepared_trucks.join(', ')}
        ON CONFLICT (id) DO UPDATE
        SET name = EXCLUDED.name,
            truck_type = EXCLUDED.truck_type,
            updated_at = NOW();
      SQL
  
      Truck.connection.execute(sql)
      trucks.size
    rescue StandardError => e
      Rails.logger.error "Error processing trucks: #{e.message}"
      0
    end
  
    def sanitize(value)
      ActiveRecord::Base.connection.quote(value)
    end
  end