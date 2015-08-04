// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery.selectunique.js
//= require tinymce
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

var checkMceEnabled = function(){
    var mceEnabledFlag = false;
    $('#translationFields tr:last textarea.tinymce').each(function(input){
      mceEnabledFlag = true;
      tinymce.execCommand("mceRemoveEditor", false, $(this).attr('id'));
    })
   return mceEnabledFlag;
}

var removeEditor = function(){
  $('.main').on('click','.removeEditor', function (){
    $('textarea').each(function(idx){
       tinymce.execCommand("mceRemoveEditor", false, $(this).attr('id'));
     });
  });
}

var addEditor = function(){
  $('body').on('click', '.enable-editor', function(){
    $('textarea').each(function(idx){
	  tinymce.execCommand("mceAddEditor", false, $(this).attr('id'));
     });
  });
}

var createTranslationRow = function() {
    return $(  $('#translation-row').text().replace('//<![CDATA[', '').replace('//]]>', '') );
};

var addRow = function() {
    var newRow = createTranslationRow(), rowNumber = $('.translation').size() + 1;

    var selectBox = newRow.find('td select');
    selectBox.attr('name', 'source[translations_attributes]['+ rowNumber +'][language]');
    selectBox.attr('id', 'source_translations_attributes_'+ rowNumber +'_language');

    var textArea = newRow.find('td textarea');
    textArea.attr('name', 'source[translations_attributes]['+ rowNumber +'][text]');
    textArea.attr('id', 'source_translations_attributes_'+ rowNumber + '_text');

    $('#translationFields tbody').append(newRow);

    $('.languageSelect').selectunique('refresh');
};

var removeRow = function(){
  $('body').on('click', '.translation .remove', function(e) {
    console.log('aaaaa');
      e.preventDefault();
    $(this).parents('.translation').remove();
    $('.languageSelect').selectunique('refresh');
  });
}
var ready = function(){
  $('.languageSelect').selectunique();
  $('body').on('click', '.add-translation', function(e) {
    e.preventDefault();
    mceEnabled = checkMceEnabled();
    addRow();
  });

  removeRow();
  addEditor();
  removeEditor();
};

$(document).ready(ready);
$(document).on('page:load', ready);
