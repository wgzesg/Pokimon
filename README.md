# README

This application makes use of Pokimon API to simulate a tournament among 8 randomly 
selected pokimons.
Follow the following steps to try it out.

1. download the package.
2. Install relevant dependencies with `yarn install --check-files`
3. Go into the Pokemon/ folder and type `rails s`
4. Go to `localhost:3000` or `localhost:3000/mons` to view the result
The selected Pokimons will be displayed in a list. 
The combat log will be displayed at the botton of the page.


The main logic can be found in `./app/controllers/mons_controller.rb`. 
Other important classes are `Poki.rb` where the Pokimon model is defined.
This simplified model captures information required for simulating the combat.
