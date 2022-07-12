function get_image(e,image_source){
  var files = e.target.files;
  var d = (new $.Deferred()).resolve();
  console.log('called 4')
  $.each(files,function(i,file){
    var x = d.then(function() {
        console.log('called 5');
        return Uploader.upload(file)});
      x.then(function(data){
        console.log('called 6');
        return previewImage(file, data.image_id);
    });
  });
  $(image_source).val('');
};
  
$(document).ready(function() {
  console.log('called 0')
  $('.images-field').on('click','.btn-edit', function(e){
    e.preventDefault();
    console.log('btn-edit clicked');
    $(this).parent().find('.edit-image-file-input').trigger("click");
  });
  
  $('.images-field').on('change','.edit-image-file-input', function(e){
    var file = e.target.files[0];
    var image_box = $(this).parent();
    console.log(file);
    Uploader.upload(file).done(function(data){
      replaceImage(file, data.image_id, image_box);
      console.log(data.image_id);
    });
  });
  
  $('.images-field').on('click','.btn-delete', function(e){
    console.log('btn-delete clicked');
    e.preventDefault();
    $(this).parent().remove();
  });
})
  
  var replaceImage = function(imageFile, image_id, element){
    var reader = new FileReader();
    var img = element.find('img');
    var input = element.find('.order-images-input');
    var filename = element.find('p');
    reader.onload = function(e){
      input.attr({value: image_id});
      filename.html(imageFile.name);
      img.attr("src", e.target.result);
    };
    reader.readAsDataURL(imageFile);
  }
  
  var previewImage = function(imageFile, image_id){
    var reader = new FileReader();
    var img = new Image();
    var def =$.Deferred();
    reader.onload = function(e){
      var image_box = $('<div>',{class: 'image-box'});
      image_box.append(img);
      image_box.append($('<p>').html(imageFile.name));
      image_box.append($('<input>').attr({
            name: "order[images][]",
            value: image_id,
            style: "display: none;",
            type: "hidden",
            class: "order-images-input"}));
      image_box.append('<a href="" class= "btn-edit">Edit</a>');
      image_box.append($('<input>').attr({
            name: "edit-image[]",
            style: "display: none;",
            type: "file",
            class: "edit-image-file-input file-input"}));
      image_box.append('<a href="" class="btn-delete">Delete</a>');
      $('.images-field').append(image_box);
      img.src = e.target.result;
      img.width = '200'
      def.resolve();
    };
    reader.readAsDataURL(imageFile);
    return def.promise();
  }
  
  var Uploader = {
    upload: function(imageFile){
      var def =$.Deferred();
      var formData = new FormData();
      formData.append('image', imageFile);
      $.ajax({
        type: "POST",
        url: '/orders/upload_image',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false,
        success: def.resolve
      })
      return def.promise();
    }
  }
  


$(document).ready(function() {
  console.log('called 1');
  $('#order_images').on('change',function(e){
    console.log('called 2');
    get_image(e,'#order_images');
  });
  $('#suggestion_images').on('change',function(e){
    console.log('called 3')
    get_image(e,'#suggestion_images');
  });
})