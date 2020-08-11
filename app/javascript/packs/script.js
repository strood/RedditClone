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
