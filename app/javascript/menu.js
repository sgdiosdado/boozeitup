const open = () => {
    const toggle = document.getElementById('toggle');
    const menu = document.getElementById('menu');

    if(toggle){
        toggle.addEventListener('click', () => {
            if(menu){
                menu.classList.toggle('open');
            }
        });
    }
}
open();