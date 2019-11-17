import $ from 'jquery';
import 'select2';



const initSelect2 = () => {
  document.addEventListener('DOMContentLoaded', function () {
   console.log('test du slector')
  $('.select2').select2();
  });
};







export { initSelect2 };
