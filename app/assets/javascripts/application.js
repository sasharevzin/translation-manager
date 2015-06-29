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

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

var ready = function(){
  $('.languageSelect').selectunique();
  $('#translationFields').on('click', '.addMore', function(){
    var text = $("#translationFields tr:last").html();
    var lastTranslationCount = $("#translationFields tr:last").data('translation-count');
    var newTranslation = text.replaceAll(lastTranslationCount,lastTranslationCount+1);
    $("#translationFields tbody").append('<tr>' + newTranslation + '</tr>');
    $('.languageSelect').selectunique('refresh');
    $("#translationFields tr:last").data('translation-count', lastTranslationCount+1);
  });

  $('#translationFields').on('click', '.remove', function(){
    $(this).parent().parent().remove();
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);