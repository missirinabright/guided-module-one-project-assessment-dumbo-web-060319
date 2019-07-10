require 'pry'

class CLI
  def initialize
    @prompt = TTY::Prompt.new
  end

  def space
    puts "               "
  end

  def greet
    system "clear"
    puts "Welcome"
    space
    puts "to the"
    space
    puts "Regenerative Village Life!"
    space
    puts "🥵🥵🥵     🥵🥵     🥵🥵🥵"
    puts "🥬"
    sleep 2
    main_menu
  end

  def main_menu
    system 'clear'
    @prompt.select("What would you like to do?") do |menu|
      menu.per_page 20
      menu.choice "QUIT✌️"
      menu.choice "🍅 adults join here", -> { c_create_adult }
      menu.choice "🥬 recruit a kid", -> { c_create_kid }
      menu.choice "🥦 create a farmchore", -> { c_create_farmchore }
      menu.choice "🍓 show me who's in charge!", -> { r_all_adults }
      menu.choice "🥒 view the workforce", -> { r_see_the_current_kids_team }
      menu.choice "🌽 what are the job options?", -> { r_see_the_farmchores }
      menu.choice "🥔 view farmchores in progress 🥳", -> { r_assigned_chores }
      menu.choice "🥑 find a specific kid", -> { r_find_a_kid }
      menu.choice "🌶  see all farmchores of a special kid", -> { r_this_kid_chore_list }
      menu.choice "🍠 update a kid's portfolio", -> { u_update_kid }
      menu.choice "🍐 update a farm chore", -> { u_update_famchore } ##
      menu.choice "🤸‍♀️ send a kid to Disney Land", -> { d_delete_kid }
      menu.choice "🤹‍♀️ layoff an adult", -> { d_delete_adult }
      menu.choice "🚜 outsource a farm chore assignment", -> { d_delete_farmchore }
      menu.choice "QUIT✌️"
    end
  end

  def back_button
    space
    @prompt.ask "press enter to return to the main menu"
    main_menu
  end

  def r_all_adults
    system 'clear'
    puts "Adults are..."
    space
    Adult.adult_list
    back_button
  end

  def c_create_adult
    system 'clear'
    puts "Enter your name, adult"
    space
    @adult_name = gets.chomp
    @adult = Adult.create(name: @adult_name)
    space
    puts "WELCOME ABOARD, #{@adult_name}!"
    space
    sleep 1
    puts "....and you are the last on the list, but not least!"
    space
    Adult.adult_list
    back_button
  end

  def r_see_the_current_kids_team
    system 'clear'
    puts "Let's see our dream team!"
    space
    Child.child_list
    back_button
  end

  def c_create_kid
    system 'clear'
    puts "Enter kid's name"
    space
    @child_name = gets.chomp
    @child = Child.create(name: @child_name)
    space
    puts "Saved your kid's name, thanks!"
    space
    sleep 1
    r_see_the_current_kids_team
    back_button
  end

  def r_see_the_farmchores
    system 'clear'
    puts "Today, we need you to ..."
    space
    Farmchore.all.each {|chore| puts chore[:description]}
    space
    puts "K 🙏 thanks 😻 love you 🤛 bye"
    space
    puts "NOW GET TO WORK!!!!!!!!!!!"
    space
    back_button
  end

  def c_create_farmchore
    system 'clear'
    chosen_adult = @prompt.select("Which adult?", Adult.adult_hash)
    system 'clear'
    chosen_child = @prompt.select("Which kid?", Child.child_hash)
    system 'clear'
    puts "Which farmchore should you make this child do?"
    space
    @farmchore_description = gets.chomp
    Farmchore.create(description: @farmchore_description, adult_id: chosen_adult.id, child_id: chosen_child.id)
    puts "#{chosen_adult.name} has created the #{@farmchore_description} for #{chosen_child.name}!"
    r_assigned_chores
    main_menu
  end

  def r_assigned_chores
    system 'clear'
    puts "We are so proud to present..."
    space
    Farmchore.all.each do |chore|
      puts "#{chore.adult.name} has assigned #{chore.child.name} a task to #{chore.description}!"
      sleep 1
    end
    back_button
  end

  def r_find_a_kid
    system 'clear'
    puts "Enter kid's name"
    space
    @user_input = gets.chomp
    @user_input = Child.find_by(:name => @user_input)
    if @user_input != nil
      puts "We know #{@user_input.name}! What a great kid!!!! 🤗"
    else
      puts "Oops, we don't know this kid... 😬"
    end
    back_button
  end

    def r_this_kid_chore_list

      empty_farmchore_list = []
    #plan: to iterate over an array of all farmchores
    #and pull all the chores for the specific child.
    #from the select.prompt we are getting a hash. do I need the hash?
    #I can work with an object instead. Or I can call on the hash's key
    #
    #what we have
    # I can use r_see_the_farmchores that will give me a list of all existing
    #farmchores
    # but I need to only see it for a specific name and
    # from the object name that I get via the menu
    chosen_child = @prompt.select("Which kid?", Child.child_hash)
      Farmchore.all.select do |farmchore|
        if farmchore.child_id == chosen_child.id
          empty_farmchore_list << farmchore
            result = empty_farmchore_list.map {|x| x.description}
        end
          puts result
      end
      back_button
    end

    # Farmchore.create(description: @farmchore_description, adult_id: chosen_adult.id, child_id: chosen_child.id)
    # puts "#{chosen_adult.name} has created the #{@farmchore_description} for #{chosen_child.name}!"
    # # back_button


  def u_update_kid
    system 'clear'
    puts "Sorry we misspelled your kid's name..."
    chosen_child = @prompt.select("Which kid?", Child.child_hash)
    puts "Please enter the correct name"
    @user_input = gets.chomp
    # binding.pry
    chosen_child[:name] = @user_input
    chosen_child.update("name" => @user_input)
    r_see_the_current_kids_team
  end

  def u_update_famchore
    system 'clear'
    puts "Please update the farm chore"
    chosen_farmchore = @prompt.select("Which farm chore?", Farmchore.farmchore_hash)
    puts "Please enter the correct farm chore name"
    @user_input = gets.chomp
    chosen_farmchore[:description] = @user_input
    chosen_farmchore.update("description" => @user_input)
    r_see_the_farmchores
  end

  def d_delete_kid
    system 'clear'
    @prompt.select("Which kid do you want to send on vacation?") do |menu|
      Child.all.each do |child|
        menu.choice child.name, -> { child.destroy }
      end
    end
    puts "Vacations are nice,
    but nothing is sweeter than
    farming with these
    REMAINING kids..."
    space
    Child.child_list
    back_button
  end

  def d_delete_adult
    system 'clear'
    @prompt.select("Which adult do you want to retire?") do |menu|
      Adult.all.each do |adult|
        menu.choice adult.name, -> { adult.destroy }
      end
    end
    r_all_adults
    back_button
  end

  def d_delete_farmchore
    system 'clear'
    @prompt.select("Which farm chore assignment do you want to delete?") do |menu|
      Farmchore.all.each do |farmchore|
        menu.choice farmchore.description, -> { farmchore.destroy; main_menu}
      end
    end
  end
end
