 $(document).keydown(function(e) {
    if (e.key === "Backspace") {
    $.post('http://DP_Impound/escape', JSON.stringify({}));2
    } else if (e.key === "Escape") {
    $.post('http://DP_Impound/escape', JSON.stringify({}));2
    } 
});

var toggle = false;

$(document).ready(function(){
    window.addEventListener('message', function( event ) {       
      if (event.data.action == 'open') {

        $(".head-switch-in").removeClass("selected"); 
        $(".head-switch-out").removeClass("selected");  
        $(".head-switch-in").addClass("selected"); 

        const vehicles = document.getElementById("vehicle-list");
          vehicles.innerHTML = '';

        $.post('http://DP_Impound/enable-parkout', JSON.stringify({}));

        toggle = false;

        $('.container').css('display', 'block');        
		
      } else if (event.data.action == 'add') {
                
        AddCar(event.data.plate, event.data.label, event.data.price);        

      } else {
        $('.container').css('display', 'none');
      }
    });
 
    $( ".close" ).click(function() {
      $('.container').css('display', 'none');
      $('.container1').css('display', 'none');

      $.post('http://DP_Impound/escape', JSON.stringify({}));
    }); 

    $( ".head-switch-in" ).click(function() {      
      $(".head-switch-in").removeClass("selected"); 
      $(".head-switch-out").removeClass("selected");  
      $(".head-switch-in").addClass("selected"); 

      const vehicles = document.getElementById("vehicle-list");
        vehicles.innerHTML = '';

      $.post('http://DP_Impound/enable-parkout', JSON.stringify({}));

      toggle = false;
    }); 

    $( ".head-switch-out" ).click(function() {     
      $(".head-switch-in").removeClass("selected");  
      $(".head-switch-out").removeClass("selected"); 
      $(".head-switch-out").addClass("selected");   
      
      const vehicles = document.getElementById("vehicle-list");
        vehicles.innerHTML = '';

      $.post('http://DP_Impound/enable-parking', JSON.stringify({}));

      toggle = true;
    }); 

    function AddCar(plate, label, price) {
      $("#vehicle-list").append
      (`
      
      <div class="vehicle" onclick="parkOut('` + plate + `');" data-plate="` + plate + `">
        <div class="vehicle-inner">
            <img class="inner-icon" src="car.png">
            <p class="inner-label-knz">` + plate + `</p>
            <p class="inner-label-knz2">` + label + `</p>
            <p class="inner-label-knz3">€` + price + `,-</p>
        </div>
      </div>

      `);

    }

});



function parkOut(plate) {
  if (toggle == false) {
    $('.container').css('display', 'none');
    $.post('http://DP_Impound/escape', JSON.stringify({}));
    $.post('http://DP_Impound/park-out', JSON.stringify({plate: plate}));
  } else if (toggle == true) {
    $('.container').css('display', 'none');
    $.post('http://DP_Impound/escape', JSON.stringify({}));
    $.post('http://DP_Impound/park-in', JSON.stringify({plate: plate}));
  }
}