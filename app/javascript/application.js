/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "./jquery"
import * as bootstrap from "bootstrap"
import "trix";
import "@rails/actiontext";
import "@hotwired/turbo-rails"
import "chartkick";
import "chart.js";
import "@uppy/core/dist/style.css";
import "@uppy/progress-bar/dist/style.css";
import "@uppy/informer/dist/style.css";
import "@uppy/file-input/dist/style.css";
import "./uppy"


import "./stacktable"

// validate forms on submission
(function() {
  'use strict';

  const postFormSetup = () => {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });

    document.querySelectorAll('trix-editor.full-height').forEach((editor) => {
      editor.style.height = `${window.innerHeight * 0.87}px`;
    })
  }

  window.addEventListener('turbo:load', postFormSetup, false);
  window.addEventListener('load', postFormSetup, false);
})();

document.addEventListener('turbo:load', () => {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
})
