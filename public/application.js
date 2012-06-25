$(function(){
  $('form').submit(function(){
    $.post('/comments',$(this).serialize(),function(data){
      data = $.parseJSON(data)
      $('#testimonials').append('<li><strong>'+data.name+' says</strong> '+data.body+'</li>')
    })
    return false
  })
})
