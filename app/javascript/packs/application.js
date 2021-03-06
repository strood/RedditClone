// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("packs/script")
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true))

window.test_func = function toggleReplyBox(id) {
  if(document.getElementById('reply_box' + id).classList.contains('hidden'))
    document.getElementById('reply_box' + id).classList.remove('hidden');
  else
    document.getElementById('reply_box_' + id).classList.add('hidden')
}

window.test_func = function toggleHeaderDropdown() {
  var e = document.getElementById('header_dropdown');
  var t = document.getElementById('option_dropdown');
  if(e.style.display == 'flex')
      e.style.display = 'none';
  else
      e.style.display = 'flex';
      t.style.display = 'none';
}

window.test_func = function toggleOptionDropdown() {

  var e = document.getElementById('option_dropdown');
  var t = document.getElementById('header_dropdown');
  if(e.style.display == 'flex')
      e.style.display = 'none';
  else
      e.style.display = 'flex';
      t.style.display = 'none';
}

window.test_func = function getYear() {
  document.write(new Date().getFullYear());
}
