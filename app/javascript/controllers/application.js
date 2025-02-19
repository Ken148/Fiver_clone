// app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

const application = Application.start();

eagerLoadControllersFrom("controllers", application);

application.debug = false;
window.Stimulus = application;

export { application };
