// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/);
channels.keys().forEach(channels);


const selectPrice = () => {
  const priceselect = document.querySelector('#query');
  priceselect.addEventListener('change', () => {
    console.log(priceselect.value);
    priceselect.submit();
  });
};

export { selectPrice }