There are three plots : 
	1. index_1.html
	2. improve_coloring.html
	3. index_3.html

* index_1.html is the main plot - where I try to bring accross a narrative (Martini-glass) and has animations as well as user interactivity.

* index_3 html I've used D3 and GeoMap dependency. This has improved readability by doing a lot of pre-processing  and has additional features like - zoom on click, Tooltips based on data etc. Here I've plotted the distribution of average delays across states, but there is no 'finding' that might come as a revelation, also the narrative is entirely author-driven.

* improve_coloring.html is a work under progress. I've basically written the code underneath GeoMap and tried to create my own Choropleth - everything is fine but for colouring. I'm experimenting with the quantizer at the moment.

index_1.html :

Initial design : 

Initially, I used stacked bars to show delay by airline and the types of delays in the stack. There was no proper trend observable here.
Then, I used bar-graph to plot average delays by airline (taking mean of all the possible delays). After this, I have since proceeded to use DimpleJS and Storyboard controls to animate the data of delay by airline through the years.(https://discussions.udacity.com/t/mini-project-2-take-two-dand/25145/169?u=thiduck). ALthough this helped to show how airline performed through the years, I decided against using this.
Finally,  I decided to analyse delays by months across the years - to see if there is a observable pattern common among all the years.

index_1.html' -> which is the main plot. This is a martini-glass type narrative - where I animate through the data but users can pause and get their own insights and understandings from the data.

Does the visualization have a clear finding?

I'm trying to convery that the delays are more likely to happen during time of 
	a. Summer Vacation (June- July)
	b. Christmas and new-year (December - January)
since the air-traffic will be much higher than expected. This is especially clear from increasing trends in Nov-Dec and May-June , in all the years.

Does the visualization focus on its finding?
I've tried to use colours as pre-attentive processing and used line-graph to show the variation with time and trends. I've also used different colours and size to highlight the two trends I want the users to focus on.

Feedbacks :
1. Suggestion to show trends with time instead of airline. (Used line-graph and changed the plot x-axis to months of a year).
2. Highlight data I wanted the users to look at (I decided to add color and size to the circles).
3. Add a legend as the message wasn't really straightforward from the 'months' x-axis (I have added a legend).
4. Change font-size of X and Y-axis labels (Font size increased).
5. Change position of animating storyboard control box (Box now on the bottom left corner - without overlaying the line-graph).
6. Suggestion to use bootstrap to display the title (I have used bootstrap).
7. Suggestion to use the data to also plot a choropleth and show distribution of delays across states(I have created two choropleths).
