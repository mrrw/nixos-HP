#!/bin/bash

echo "Welcome to the Library Catalog Database Tutorial"
echo "In this tutorial, we'll demonstrate basic SQLite commands using a library catalog as an example."

# Check if the database file exists
if [ ! -f library_catalog.db ]; then
    echo "Creating a new database 'library_catalog.db'..."
    sqlite3 library_catalog.db <<EOF
    .echo on
    -- Create a table to store books
    CREATE TABLE IF NOT EXISTS books (
        id INTEGER PRIMARY KEY,
        title TEXT,
        author TEXT,
        genre TEXT
    );
EOF
else
    echo "Database 'library_catalog.db' already exists."
fi

# Function to display books
display_books() {
	echo
    sqlite3 library_catalog.db "SELECT * FROM books;"
		echo
}

# Function to add a book
add_book() {
    read -p "Enter the title of the book: " title
    read -p "Enter the author of the book: " author
    read -p "Enter the genre of the book: " genre

    sqlite3 library_catalog.db "INSERT INTO books (title, author, genre) VALUES ('$title', '$author', '$genre');"
    echo "Book '$title' by $author added to the catalog."
}

# Function to update book genre
update_genre() {
    read -p "Enter the title of the book to update: " title
    read -p "Enter the new genre for '$title': " new_genre

    sqlite3 library_catalog.db "UPDATE books SET genre = '$new_genre' WHERE title = '$title';"
    echo "Genre updated for '$title'."
}

# Function to remove a book
remove_book() {
    read -p "Enter the title of the book to remove: " title

    sqlite3 library_catalog.db "DELETE FROM books WHERE title = '$title';"
    echo "Book '$title' removed from the catalog."
}

# Interactive menu
while true; do
    echo "Choose an option:"
    echo "1. Display Books"
    echo "2. Add a Book"
    echo "3. Update Genre"
    echo "4. Remove a Book"
    echo "5. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1) display_books ;;
        2) add_book ;;
        3) update_genre ;;
        4) remove_book ;;
        5) echo "Exiting. Goodbye!"; exit 0 ;;
        *) echo "Invalid choice. Please enter a valid option." ;;
    esac
done
