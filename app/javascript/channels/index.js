// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/);
channels.keys().forEach(channels);

const selectcategory = () => {
  const categoryselect = document.querySelector('#GarmentSelector');
  categoryselect.addEventListener('change', () => {
      console.log(categoryselect.value);
      console.log("/garments?category="+categoryselect.value);
      window.location.href= "/garments?category="+categoryselect.value;
    });
};

export { selectcategory }
