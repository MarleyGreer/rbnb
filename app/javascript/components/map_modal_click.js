const bindModalButton=() => {
 const button = document.querySelector("#map-btn");
 if (button) {
    button.addEventListener('click', (event) => {
    setTimeout(() => {window.map.resize()}, 300);
    })
  };
}

export {bindModalButton};
