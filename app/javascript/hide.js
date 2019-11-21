// document.addEventListener("click", function(event){
//   if(!event.target.matches('.delete')) return;
//   let content = document.querySelector('#warning');
//   if(!content) return;
//   content.classList.toggle('is-hidden');
// });

document.addEventListener('click', (e) => {
  const appear = document.getElementById('eliminate')
  const content = document.getElementById('confirmation')
  const cancel = document.getElementById('cancel')
  if(content && e.target == cancel){
      content.classList.add('is-hidden');
  }
});
