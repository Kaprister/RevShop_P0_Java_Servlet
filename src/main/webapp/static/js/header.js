/**
 * 
 */


       let lastScrollTop = 0;
       const header = document.getElementById('header');
       
       window.addEventListener('scroll', function() {
           let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

           if (scrollTop > lastScrollTop) {
               // Scrolling down, hide the header
               header.style.top = '-100px';
           } else {
               // Scrolling up, show the header
               header.style.top = '0';
           }
           lastScrollTop = scrollTop;
       });


	// Toggle dropdown visibility on button click
	document.querySelectorAll('.dropdown > button').forEach(button => {
	    button.addEventListener('click', (e) => {
	        const dropdown = button.parentElement;
	        dropdown.classList.toggle('active'); // Toggle active class
	    });
	});
	
	// Close dropdowns if clicked outside
	window.addEventListener('click', (e) => {
	    if (!e.target.closest('.dropdown')) {
	        document.querySelectorAll('.dropdown').forEach(dropdown => {
	            dropdown.classList.remove('active'); // Remove active class
	        });
	    }
	});
	
	//make nav link active
	document.addEventListener("DOMContentLoaded", function() {
	     const navLinks = document.querySelectorAll('#navbar a');
	     const currentPath = window.location.pathname;

	     navLinks.forEach(link => {
	         if (link.href === window.location.href) {
	             link.classList.add('active'); // Add active class to the current link
	         }
	     });
	 });
