//// Script for user profile page
document.getElementById('editBtn').addEventListener('click', function () {
    document.getElementById('editBtn').classList.add('d-none');
    document.getElementById('saveBtn').classList.remove('d-none');
    document.getElementById('closeBtn').classList.remove('d-none');
    document.getElementById('profilePicInput').classList.remove('d-none');

    // Enable form fields for editing
    document.querySelectorAll('#profileForm input, #profileForm textarea').forEach(function (input) {
        input.removeAttribute('readonly');
    });
});

document.getElementById('closeBtn').addEventListener('click', function () {
    document.getElementById('editBtn').classList.remove('d-none');
    document.getElementById('saveBtn').classList.add('d-none');
    document.getElementById('closeBtn').classList.add('d-none');
    document.getElementById('profilePicInput').classList.add('d-none');

    // Disable form fields to make them read-only again
    document.querySelectorAll('#profileForm input, #profileForm textarea').forEach(function (input) {
        input.setAttribute('readonly', 'readonly');
    });
});

// Show order details script
document.addEventListener('DOMContentLoaded', function () {
    const viewOrdersBtn = document.getElementById('viewOrdersBtn');
    const orderDetailsModal = new bootstrap.Modal(document.getElementById('orderDetailsModal'));

    viewOrdersBtn.addEventListener('click', function () {
        // Fetch order details via AJAX or any other method here
        // For now, we'll just show the modal
        orderDetailsModal.show();
    });
});


// Place order
document.getElementById('placeOrderBtn').addEventListener('click', function () {
    // Here you can add form validation and submission logic
    $('#orderModal').modal('hide');
    $('#orderSuccessModal').modal('show');
});



// All Books script
$('#editModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var id = button.data('id');
    var name = button.data('name');
    var author = button.data('author');
    var price = button.data('price');
    var category = button.data('category');
    var status = button.data('status');

    var modal = $(this);
    modal.find('#edit-id').val(id);
    modal.find('#edit-name').val(name);
    modal.find('#edit-author').val(author);
    modal.find('#edit-price').val(price);
    modal.find('#edit-category').val(category);
    modal.find('#edit-status').val(status);
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

$('#editForm').submit(function (event) {
    event.preventDefault();
    var id = $('#edit-id').val();
    var name = $('#edit-name').val();
    var author = $('#edit-author').val();
    var price = $('#edit-price').val();
    var category = $('#edit-category').val();
    var status = $('#edit-status').val();
    // Add your edit logic here
    $('#editModal').modal('hide');
});