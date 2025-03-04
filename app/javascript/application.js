import "@hotwired/turbo-rails";  // This imports Turbo for Hotwire functionality
import "controllers";  // This will load all controllers from app/javascript/controllers
import Rails from "@rails/ujs";  // Import rails-ujs to handle AJAX-based form submissions like DELETE
Rails.start();  // Initialize rails-ujs
