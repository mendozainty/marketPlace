$(document).ready(function(){

    // banner owl carousel
    $("#banner-area .owl-carousel").owlCarousel({
        autoplay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: false,
        loop: true,
        dots: true,
        items: 1
    });

    // as cores mais quentes owl carousel
    $("#top-sale .owl-carousel").owlCarousel({
        autoplay: true,
        autoplayTimeout: 3000,
        autoplayHoverPause: false,
        loop: true,
        nav: true,
        dots: false,
        responsive:{
            0:{
                items: 1
            },
            600:{
                items: 3
            },
            1000:{
                items: 5
            }
        }
    })

    // isotope filter
    var $grid = $(".grid").isotope({
        itemSelector: '.grid-item',
        layoutMode : 'fitRows'
    });

    // filter items on button click
    $(".button-group").on("click", "button", function(){
        var filterValue = $(this).attr('data-filter');
        $grid.isotope({filter: filterValue});
    })

    // new-products owl-carousel
    $("#new-products .owl-carousel").owlCarousel({
        autoplay: true,
        autoplayTimeout: 3000,
        autoplayHoverPause: false,
        loop: true,
        nav: false,
        dots: true,
        responsive:{
            0:{
                items: 1
            },
            600:{
                items: 3
            },
            1000:{
                items: 5
            }
        }
    })

    //blog owl carousel
    $("#blogs .owl-carousel").owlCarousel({
        loop: true,
        nav: true,
        dots: false,
        responsive:{
            0:{
                items: 1
            },
            600:{
                items: 3
            }
        }
    })

    // qty button
    let $qty_up = $(".qty .qty-up");
    let $qty_down = $(".qty .qty-down");
    //let $input = $(".qty .qty_input")

    $qty_up.click(function(e){
        let $input = $(`.qty_input[data-id='${$(this).data("id")}']`);
        
        if($input.val() >= 1 && $input.val() <= 9){
            $input.val(function(i, oldvalue){
                return ++oldvalue;
            })
        }
    })

    $qty_down.click(function(e){
        let $input = $(`.qty_input[data-id='${$(this).data("id")}']`);
        if($input.val() > 1 && $input.val() <= 10){
            $input.val(function(i, oldvalue){
                return --oldvalue;
            })
        }
    })
    

});