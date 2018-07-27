var formData = {};

$(document).ready(function() {
    console.log("Editor page is ready!");
    init();
});

function init(){
    alertify.parent(document.body);
    // debug buttons
    $('#validateForm').click(function(e){
        e.preventDefault();
        console.log('#validateForm clicked');
		validateForm();
	});
    $('#randomTrash').click(function(e){
        e.preventDefault();
        console.log('#randomTrash clicked');
		randomizeForm();
	});
    // submit button
    $('#submitTrash').click(function(e){
        e.preventDefault();
        console.log('#submitTrash clicked');
		if(!validateForm()){
	        console.log('#nog niet klaar');
            alertify.alert("Kijk nog even goed of je iets hebt ingevult");
			return;
		}

        $.ajax({
            type: 'POST',
            data: JSON.stringify(formData),
            contentType: 'application/json',
            url: '/api/trash',
            success: function(data) {
                console.log('success');
                // console.log((data));
                // {"success":true,"msg":"this is correct","url":"/editor"}
                location.replace(data.url); // got to the thx page
            },
			error : function(e) {
                console.log("ERROR: ", e);
            }
        });
    });
}


function randomizeForm() {
	var inputArr = $('input[type=number]');
	for (let i = 0; i < inputArr.length; i++) {
		const element = inputArr[i];
		element.value = Math.round(Math.random() * 100);
	}
}

function validateForm() {
	formData = {};
	formData.data = {};
    var totalValue = 0;
	var isvalid = false;
	var inputArr = $('input[type=number]');
	for (let i = 0; i < inputArr.length; i++) {
		const element = inputArr[i];
        var value = element.value;
        if(value === '') value = 0;
		formData[element.getAttribute('data-id')] = parseInt(value);
		var obj = formData.data;
		obj[element.getAttribute('data-id')] = parseInt(value);
		formData.data = obj;
		if(value > 0) {
			isvalid = true;
		}
        totalValue+=parseInt(value);
	}

    // add hidden data and extra textarea
    formData.uid = $('#input_uid').val();
    formData.isteacher = $('#input_isteacher').val();
    formData.lng = $('#input_lng').val();
    formData.lat = $('#input_lat').val();
    formData.total = totalValue;
    // console.log(formData);

	return isvalid;
}