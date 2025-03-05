// Import Turbo for Hotwire functionality
import "@hotwired/turbo-rails"; 

// This will load all controllers from app/javascript/controllers
import "controllers"; 

// Import Rails UJS to handle AJAX-based form submissions like DELETE
import Rails from "@rails/ujs"; 

// Initialize rails-ujs
Rails.start(); 
