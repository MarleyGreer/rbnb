// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

const showoncardclick = () => {
  const card = document.querySelector('.card');
    window.addEventListener('click', () => {
      $.get("<%= garment_path(garment) %>");
    });
};

