import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
   console.log('test du slector')
  $('.select2').select2();
  $('#ingredient').select2({  data: mandant});
  $('#ingredient').select2({ data: mandant }); // (~ document.querySelectorAll)
};


const addToList = () => {
  const get = document.querySelector('.get');
  get.innerHTML = "<div class=ig>Eau</div>";
}





export { initSelect2, addToList };
