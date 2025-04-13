package app.classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Book {

    private String book_id;
    private String book_name;
    private String author_name;
    private double price;
    private int quantity;
    private String category;
    private String img_url;
    private String description;
    private float rating;

    public Book() {
    }

    public Book(String book_id, String book_name, String author_name, double price, int quantity, String category,
            String img_url, String description, float rating) {
        this.book_id = book_id;
        this.book_name = book_name;
        this.author_name = author_name;
        this.price = price;
        this.quantity = quantity;
        this.category = category;
        this.img_url = img_url;
        this.description = description;
        this.rating = rating;
    }

    public Book(String book_name, String author_name, double price, int quantity, String category, String img_url, String description) {
        this.book_name = book_name;
        this.author_name = author_name;
        this.price = price;
        this.quantity = quantity;
        this.category = category;
        this.img_url = img_url;
        this.description = description;
    }

    // Getters and Setters
    public String getBook_id() {
        return book_id;
    }

    public void setBook_id(String book_id) {
        this.book_id = book_id;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public String getAuthor_name() {
        return author_name;
    }

    public void setAuthor_name(String author_name) {
        this.author_name = author_name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public List<Book> getAllBooks(Connection con) {
        List<Book> bookList = new ArrayList<>();
        try {
            String query = "SELECT * FROM books";
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Book book = new Book(rs.getString("book_id"), rs.getString("book_name"), rs.getString("author_name"),
                        rs.getDouble("price"), rs.getInt("quantity"), rs.getString("category"),
                        rs.getString("img_url"), rs.getString("description"), rs.getFloat("rating"));
                bookList.add(book);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Book.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bookList;
    }

    public boolean addBook(Connection con) {
        try {
            String query = "INSERT INTO books(book_name, author_name, price, quantity, category, img_url, description, rating) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.book_name);
            pstmt.setString(2, this.author_name);
            pstmt.setDouble(3, this.price);
            pstmt.setInt(4, this.quantity);
            pstmt.setString(5, this.category);
            pstmt.setString(6, this.img_url);
            pstmt.setString(7, this.description);
            pstmt.setFloat(8, this.rating);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Book.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean deleteBook(Connection conn) {
        String sql = "DELETE FROM books WHERE book_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, this.book_id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateBook(Connection con) {
    String query = "UPDATE books SET book_name = ?, author_name = ?, price = ?, quantity = ?, category = ?, img_url = ? WHERE book_id = ?";
    try (PreparedStatement pstmt = con.prepareStatement(query)) {
        pstmt.setString(1, this.book_name);
        pstmt.setString(2, this.author_name);
        pstmt.setDouble(3, this.price);
        pstmt.setInt(4, this.quantity);
        pstmt.setString(5, this.category);
        pstmt.setString(6, this.img_url);
        pstmt.setString(7, this.book_id);
        return pstmt.executeUpdate() > 0; // Returns true if a row was updated
    } catch (SQLException ex) {
        Logger.getLogger(Book.class.getName()).log(Level.SEVERE, null, ex);
        return false;
    }
}

    public Book getBookById(Connection con, String bookId) {
        String query = "SELECT * FROM books WHERE book_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                this.book_id = rs.getString("book_id");
                this.book_name = rs.getString("book_name");
                this.author_name = rs.getString("author_name");
                this.price = rs.getDouble("price");
                this.quantity = rs.getInt("quantity");
                this.category = rs.getString("category");
                this.img_url = rs.getString("img_url");
                this.description = rs.getString("description");
                this.rating = rs.getFloat("rating");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Book.class.getName()).log(Level.SEVERE, null, ex);
        }
        return this;
    }

    public int countTotalBooks(Connection con) {
        String query = "SELECT COUNT(*) AS total FROM books";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Book.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Book> getLatestBooks(int limit) {
        List<Book> latestBooks = new ArrayList<>();
        String query = "SELECT * FROM books ORDER BY added_at DESC LIMIT ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setBook_id(rs.getString("book_id"));
                    book.setBook_name(rs.getString("book_name"));
                    book.setAuthor_name(rs.getString("author_name"));
                    book.setPrice(rs.getDouble("price"));
                    book.setQuantity(rs.getInt("quantity"));
                    book.setCategory(rs.getString("category"));
                    book.setImg_url(rs.getString("img_url"));
                    book.setDescription(rs.getString("description"));
                    book.setRating(rs.getFloat("rating"));
                    latestBooks.add(book);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Book.class.getName()).log(Level.SEVERE, null, ex);
        }
        return latestBooks;
    }
    
    
    public List<Book> getAllBooks1(Connection con) {
    List<Book> bookList = new ArrayList<>();
    String query = "SELECT * FROM books";
    try (PreparedStatement pstmt = con.prepareStatement(query);
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            Book book = new Book(
                    rs.getString("book_id"),
                    rs.getString("book_name"),
                    rs.getString("author_name"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getString("category"),
                    rs.getString("img_url"),
                    rs.getString("description"),
                    rs.getFloat("rating")
            );
            bookList.add(book);
        }
    } catch (SQLException ex) {
        Logger.getLogger(Book.class.getName()).log(Level.SEVERE, null, ex);
    }
    return bookList;
    }
}