#!/bin/bash

# Functions to execute SQL commands with SQLite
execute_sql() {
    sqlite3 contactsDB.db "$1"
}

# Function to create the contacts table
create_contacts_table() {
    execute_sql "CREATE TABLE IF NOT EXISTS contacts (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT
    );"
}

# Function to insert a new contact
insert_contact() {
    local name="$1"
    local email="$2"
    execute_sql "INSERT INTO contacts (name, email) VALUES ('$name', '$email');"
}

# Function to list all contacts
list_contacts() {
    execute_sql ".headers on\nSELECT * FROM contacts;"
}

# Function to delete a contact by ID
delete_contact() {
    local id="$1"
    execute_sql "DELETE FROM contacts WHERE id = $id;"
}

# Main script
create_contacts_table # Create the 'contacts' table if it doesn't exist

echo "Welcome to the Contacts Database"

while true; do
    echo "Choose an option:"
    echo "1. Add a contact"
    echo "2. List all contacts"
    echo "3. Delete a contact"
    echo "4. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) 
            read -p "Enter contact's name: " contact_name
            read -p "Enter contact's email: " contact_email
            insert_contact "$contact_name" "$contact_email"
            echo "Contact added successfully."
            ;;
        2)
            echo "Listing all contacts:"
            list_contacts
            ;;
        3)
            read -p "Enter the ID of the contact to delete: " contact_id
            delete_contact "$contact_id"
            echo "Contact deleted successfully."
            ;;
        4)
            echo "Exiting. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
done
