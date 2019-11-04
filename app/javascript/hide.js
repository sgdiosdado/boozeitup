
document.addEventListener("click", function(event){
//console.log(event);
if(!event.target.matches('.delete.is-small')) return;
var content = document.querySelector('#warning');
if(!content) return;
content.classList.toggle('is-hidden');
});
