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

var addRow = function(){
    var text = $("#translationFields tr:last").html();
    var lastTranslationCount = $("#translationFields tr:last").data('translation-count');
    var newTranslation = text.replaceAll(lastTranslationCount,lastTranslationCount+1);
    $("#translationFields tbody").append('<tr>' + newTranslation + '</tr>');
    $('.languageSelect').selectunique('refresh');
    $("#translationFields tr:last").data('translation-count', lastTranslationCount+1);
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
    $('#translationFields textarea').each(function(input){
      if(mceEnabled)
        {
          tinymce.execCommand("mceAddEditor", false, $(this).attr('id'));
        }
    })
  });
  removeRow();
};

$(document).ready(ready);
$(document).on('page:load', ready);
