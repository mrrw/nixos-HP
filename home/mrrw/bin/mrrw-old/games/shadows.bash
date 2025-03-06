#!/bin/bash

# Variables to track player's influence and control
influence=50
control=50

# Function to display the introduction and instructions
introduction() {
    clear
    echo "Welcome to the Shadow Government Simulator!"
    echo "Your goal is to maintain and increase influence and control from the shadows."
    echo "Navigate through the choices and see the consequences of your actions."
    echo "Let's begin!"
    read -p "Press Enter to continue..."
}

# Function to display the current status
display_status() {
    clear
    echo "Your Influence: $influence"
    echo "Your Control: $control"
    echo "-------------------------"
}

# Function to display options and handle user input
show_options() {
    display_status
    echo "What would you like to do?"
    echo "1. Spy on rival factions"
    echo "2. Bribe government officials"
    echo "3. Sabotage opponents"
    echo "4. Expand influence through propaganda"
    echo "5. Make strategic alliances"
    echo "6. Quit"
    read -p "Enter your choice: " choice
    case $choice in
        1)
            influence=$((influence + 5))
            control=$((control - 5))
            display_status
            read -p "You ordered spies to gather intel. Press Enter to continue..."
            ;;
        2)
            influence=$((influence + 10))
            control=$((control - 10))
            display_status
            read -p "You bribed officials to gain favor. Press Enter to continue..."
            ;;
        3)
            influence=$((influence - 10))
            control=$((control + 5))
            display_status
            read -p "You executed a sabotage operation. Press Enter to continue..."
            ;;
        4)
            influence=$((influence + 15))
            control=$((control - 5))
            display_status
            read -p "Launched a propaganda campaign. Press Enter to continue..."
            ;;
        5)
            influence=$((influence + 5))
            control=$((control + 10))
            display_status
            read -p "Formed strategic alliances. Press Enter to continue..."
            ;;
        6)
            echo "Exiting the game. Goodbye!"
            exit
            ;;
        *)
            echo "Invalid choice. Please try again."
            read -p "Press Enter to continue..."
            ;;
    esac
}

# Main game loop
introduction

while true; do
    show_options
done
