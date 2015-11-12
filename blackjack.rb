

def calculate_total(cards)
	arr = cards.map{ |e| e[1] }

	total = 0
	arr.each do |value|
		if value == "A"
			total += 11
		elsif value.to_i == 0 #this accounts for the face cards J Q K
			total += 10
		else
			total += value.to_i
		end
	end

	#consider Aces
	arr.select{|e| e == "A"}.count.times do
		total -= 10 if total > 21
	end

	total
end

#main Start
puts "BLACKJACK! Welcomes you"

suits = ['Heart', 'Diamond', 'Spade', 'Clover']
cards = ['2', '3', '4', '5', '6','7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

player_cards = []
dealer_cards = []

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

dealer_total = calculate_total(dealer_cards)
player_total = calculate_total(player_cards)

puts "Dealer has: #{dealer_cards[0]} and #{dealer_cards[1]}:  #{dealer_total}"
puts "Player has: #{player_cards[0]} and #{player_cards[1]}:  #{player_total}"
puts "\n"

if player_total == 21
	puts "BLACKJACK!! you win"
	exit
end

while player_total < 21
	puts "1. Hit   2. Stay"
	hit_or_stay = gets.chomp
	
	if !['1', '2'].include?(hit_or_stay)
		puts "You must enter 1 or 2"
		next
	end

	if hit_or_stay == "2"
		puts "Player stays"
		break
	end

	new_card = deck.pop
	puts "Players card: #{new_card}"
	player_cards << new_card
	player_total = calculate_total(player_cards)
	puts "Your total is now: #{player_total}"

	if player_total == 21
		puts "BLACKJACK!! you win"
		exit
	elsif player_total > 21
		puts "Player busts"
		exit		
	end
end

if dealer_total == 21
	puts "Dealer hits BLACKJACK!!  you lose"
	exit
end

while dealer_total < 17
	new_card = deck.pop
	puts "Dealer takes: #{new_card}"
	dealer_cards << new_card
	dealer_total = calculate_total(dealer_cards)
	puts "Dealer total is: #{dealer_total}"

	if dealer_total == 21
		puts "Dealer hits BLACKJACK"
		exit
	elsif dealer_total > 21
		puts "Dealer busts!  you win"
		exit
	end	
end

puts "Dealers cards: "
dealer_cards.each do |card|
	puts "#{card}"
end
puts "\n"

puts "Player cards: "
player_cards.each do |card|
	puts "#{card}"
end
puts "\n"

if dealer_total > player_total
	puts "Dealer wins"
elsif player_total > dealer_total
	puts "Player wins"
else
	puts "it's a tie"
end

exit

		

