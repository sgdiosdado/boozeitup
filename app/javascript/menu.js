const open = () => {
    const toggle = document.getElementById('toggle');
    const menu = document.getElementById('menu');

    if (toggle && menu) {
        toggle.addEventListener('click', e => {
            menu.classList.toggle('open');
            e.stopPropagation();
        });

        document.addEventListener('click', e => {
            if (e.target != menu) {
                menu.classList.remove('open');
                e.stopPropagation();
            }
        })
    }
}
open();
