function  sortable(){
  $(document).ready(function(){
    $('.product').sortable({
      axis: 'y',
      dropOnEmpty: false,
      cursor: 'crosshair',
      items: 'tr',
      handle: '.handle',
      opacity: 0.4,
      scroll: true,
      update: function(){
        $.ajax({
          type: 'post',
          data: $('.product').sortable('serialize'),
          dataType: 'script',
          complete: function(request){
            $('.product').effect('highlight');
          },
        url: '/showroom/products/sort'})
      }
    });
  });
}
