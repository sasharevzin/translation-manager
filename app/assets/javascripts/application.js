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
  $('#main').on('click','.removeEditor', function(){
    $('textarea').each(function(idx){
       tinymce.execCommand("mceRemoveEditor", false, $(this).attr('id'));
     });
  });
}

var addEditor = function(){
  $('#main').on('click','.enableEditor', function(){
    $('textarea').each(function(idx){
          tinymce.execCommand("mceAddEditor", false, $(this).attr('id'));
     });
  });
}

var addRow = function(){
    var lastRow = $("#translationFields tr:last").clone();
    var tinymceDiv = lastRow.find('.mce-tinymce').remove();
    var lastTranslationCount = lastRow.data('translation-count');
    var selectBox = lastRow.find('td select')
    selectBox.attr('name', 'source[translations_attributes]['+ (lastTranslationCount+1)+'][language]')
    selectBox.attr('id', 'source_translations_attributes_'+ (lastTranslationCount+1)+'_language')

    var textArea = lastRow.find('td textarea')
    textArea.attr('name', 'source[translations_attributes]['+ (lastTranslationCount+1)+'][text]')
    textArea.attr('id', 'source_translations_attributes_'+ (lastTranslationCount+1)+'_text')
    //textArea.show();
    tinymce.execCommand("mceAddEditor", false, textArea.attr('id'));
    lastRow.attr('data-translation-count', (lastTranslationCount+1));

    $("#translationFields tbody").append(lastRow);
    //if(tinymceDiv[0] != null)
    //  {
        addEditor();
    //  }
    $('.languageSelect').selectunique('refresh');

}

var removeRow = function(){
  $('#translationFields').on('click', '.remove', function(){
    $(this).parent().parent().remove();
  });
}
var ready = function(){

  $('.languageSelect').selectunique();

  $('#translationFields').on('click', '.addMore', function(){
    mceEnabled = checkMceEnabled();
    addRow();
    console.log('addin row successful');
    /*$('#translationFields textarea').each(function(input){
      if(mceEnabled)
        {
          tinymce.execCommand("mceAddEditor", false, $(this).attr('id'));
        }
    })*/
  });

  removeRow();
  addEditor();
};

$(document).ready(ready);
$(document).on('page:load', ready);
