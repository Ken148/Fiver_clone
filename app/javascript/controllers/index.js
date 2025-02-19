// Import the main Stimulus application
import { application } from "controllers/application";

// Automatically load all controllers in controllers/ folder
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);

// Manually import and register specific controllers
import OccupationController from "./occupation_controller";
application.register("occupation", OccupationController);
