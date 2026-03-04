import java.sql.*;

public class TestQuery {
        public static void main(String[] args) throws Exception {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/placement_cell?useSSL=false&serverTimezone=UTC",
                                "root", "triveni9100@");

                System.out.println("=== CIRCULARS TABLE ===");
                try {
                        ResultSet rs = conn.createStatement().executeQuery("SELECT COUNT(*) FROM circulars");
                        if (rs.next())
                                System.out.println("Circulars count: " + rs.getInt(1));
                } catch (Exception e) {
                        System.out.println("Circulars table error: " + e.getMessage());
                }

                System.out.println("=== STUDENTS TABLE ===");
                try {
                        ResultSet rs = conn.createStatement().executeQuery("SELECT COUNT(*) FROM students");
                        if (rs.next())
                                System.out.println("Students count: " + rs.getInt(1));
                } catch (Exception e) {
                        System.out.println("Students table error: " + e.getMessage());
                }

                System.out.println("\n=== ANNOUNCEMENTS TABLE ===");
                try {
                        ResultSet rs = conn.createStatement().executeQuery("SELECT COUNT(*) FROM announcements");
                        if (rs.next())
                                System.out.println("Announcements count: " + rs.getInt(1));
                } catch (Exception e) {
                        System.out.println("Announcements table error: " + e.getMessage());
                }

                conn.close();
        }
}
