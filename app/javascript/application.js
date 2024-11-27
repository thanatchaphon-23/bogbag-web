// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// โหลด Rails UJS สำหรับจัดการ method: :delete
import Rails from "@rails/ujs";
Rails.start();
