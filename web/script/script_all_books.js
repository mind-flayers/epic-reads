$('#editModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var id = button.data('id');
    var name = button.data('name');
    var author = button.data('author');
    var price = button.data('price');
    var category = button.data('category');
    var stock = button.data('stock');
    var imgurl = button.data('imgurl');

    var modal = $(this);
    modal.find('#edit-id').val(id);
    modal.find('#edit-name').val(name);
    modal.find('#edit-author').val(author);
    modal.find('#edit-price').val(price);
    modal.find('#edit-category').val(category);
    modal.find('#edit-stock').val(stock);
    modal.find('#edit-img-url').val(imgurl);
});

$('#deleteModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var id = button.data('id');

    var modal = $(this);
    modal.find('#delete-id').val(id);
});

$('#confirmDelete').click(function () {
    var id = $('#delete-id').val();
    // Add your delete logic here
    $('#deleteModal').modal('hide');
});