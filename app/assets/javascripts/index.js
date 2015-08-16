/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

$( document ).ready(function() {


	// var refreshIntervalID = null;
 //    	refreshIntervalID = setInterval(updateUserLocation, 10000);


    $('#request-cash').click(function(){
        $('#cash-request-page').fadeIn('slow'); 
        $('#logged-in').fadeOut('slow');
        $('#cash-request-page').css('display', 'flex');
    });

    // $("#stop-location-tracking").click(function(e) {
    // 	alert("User stopped location tracking");
    // 	clearInterval(refreshIntervalID);
    // });

 //    function updateUserLocation() {
	// 	Parse.GeoPoint.current({
	// 	    success: function (point) {
	// 	        //use current location
	// 	        console.log("Point found:"+point);
	// 	        currentUser = Parse.User.current();
	// 	        if (currentUser) {
	// 		        currentUser.set("location", point);
	// 		        currentUser.save(null, {
	// 		    		success:function(object) {
	// 		      			console.log("Saved the location to the user object!");
	// 		    		}, 
	// 		    		error:function(object,error) {
	// 		      			console.dir(error);
	// 		    		}
	// 		  		});
	// 	    	} else {
	// 	    		console.log("There is no user logged in, so the location was not saved");
	// 	    	}
	// 	    },
	// 	    error: function (error) {
	// 	    	console.dir("Error:"+error);
	// 	    }
	// 	});
	// }
    
    // $("#logout").click(function(){
    //     Parse.User.logOut();
    //     $('#logged-in').fadeOut('slow'); $('#home').fadeIn('slow');
    //     clearInterval(refreshIntervalID);
    // });

    $(function() {
        var Accordion = function(el, multiple) {
            this.el = el || {};
            this.multiple = multiple || false;

            // Variables privadas
            var links = this.el.find('.link');
            // Evento
            links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
        }

        Accordion.prototype.dropdown = function(e) {
            var $el = e.data.el;
                $this = $(this),
                $next = $this.next();

            $next.slideToggle();
            $this.parent().toggleClass('open');

            if (!e.data.multiple) {
                $el.find('.submenu').not($next).slideUp().parent().removeClass('open');
            };
        }   

        var accordion = new Accordion($('#accordion'), false);
    });    

    $('.text-box').keydown(function(){
        $(".request").fadeIn('slow');
    })

    $(".request").click(function(){
        alert('Request Received');
    })


});

