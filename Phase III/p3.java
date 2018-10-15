import java.util.LinkedList;
import java.util.Scanner;
import java.sql.*;

public class p3 {
    /**
     * Main program
     *
     * @param args: specified by the user. Usage: <username> <password> [option]
     *              where option ranges from 1-5 inclusively
     */
    public static void main(String[] args) {
        // check command-line arguments first
        if (args.length < 2 || args.length > 3) {
            System.out.println("Incorrect amount of arguments.");
            System.out.println("Usage: ");
            System.out.println("java p3 <username> <password> [option]");
            return;
        }
        if (args.length == 2) {
            printOptions();
            return;
        }

        String USERID = args[0];
        String PASSWORD = args[1];
        System.out.println("-------Oracle JDBC Connection Testing ---------");
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
            return;
        }

        System.out.println("Oracle JDBC Driver Registered!");
        Connection connection;

        try {
            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", USERID, PASSWORD);
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;
        }
        System.out.println("Oracle JDBC Driver Connected!");

        String option = args[2];
        Scanner input = new Scanner(System.in);
        switch (Integer.parseInt(option)) {
            case 1:
                reportWineInfo(input, connection);
                break;
            case 2:
                getCompRepInfo(input, connection);
                break;
            case 3:
                getWineLabelFormInfo(input, connection);
                break;
            case 4:
                updatePhoneNum(input, connection);
                break;
            case 5:
                // exit program
                input.close();
                return;
            default:
                input.close();
                System.out.println("Invalid option chosen. Option ranges from 1-5 inclusively");
                return;
        }
        input.close();
    }

    /**
     * Display the available options to the user.
     * This function should only be called when user inputs option 1
     */
    private static void printOptions() {
        System.out.println("1 - Report Wine Information.");
        System.out.println("2 - Report Company Rep Information.");
        System.out.println("3 - Report Wine Label Form Information");
        System.out.println("4 - Update Phone Number");
        System.out.println("5 - Exit Program");
    }

    /**
     * Report wine information that the user requests
     *
     * @param input      Scanner object to get user's input
     * @param connection database's connection
     */
    private static void reportWineInfo(Scanner input, Connection connection) {
        System.out.println("Enter Wine ID: ");
        String inputWineID = input.nextLine();

        try {
            Statement stmt = connection.createStatement();
            String str = "SELECT * FROM WINES WHERE wineID = " + inputWineID;
            ResultSet rset = stmt.executeQuery(str);

            int wineID = 0;
            String brand = "";
            String classType = "";
            double alcohol = 0;
            String appelation = "";
            double netContent = 0;
            String bottleName = "";

            while (rset.next()) {
                wineID = rset.getInt("wineID");
                brand = rset.getString("brand");
                classType = rset.getString("classType");
                alcohol = rset.getDouble("alcohol");
                appelation = rset.getString("appellation");
                netContent = rset.getDouble("netContent");
                bottleName = rset.getString("bottlerName");
            }

            System.out.println("Wines Information");
            System.out.println("Wine ID: " + wineID);
            System.out.println("Brand Name: " + brand);
            System.out.println("Class/Type: " + classType);
            System.out.println("Alcohol: " + alcohol + "%");
            System.out.println("Appellation: " + appelation);
            System.out.println("Net Content: " + netContent);
            System.out.println("Bottler: " + bottleName);

            rset.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            catchException(e);
        }
    }

    /**
     * Retrieve the company rep information requested
     * @param input Scanner object to get user's input
     * @param connection database's connection
     */
    private static void getCompRepInfo(Scanner input, Connection connection) {
        System.out.println("Enter Company Rep login name:");
        String inputLogin = input.nextLine();

        try {
            Statement stmt = connection.createStatement();
            String str = "SELECT A.loginName, repID, name, phone, email, companyName " +
                    "FROM Reps R JOIN Accounts A ON R.loginName = A.loginName WHERE A.loginName = " + "\'" + inputLogin + "\'";
            ResultSet rset = stmt.executeQuery(str);

            String loginName = "";
            int repID = 0;
            String name = "";
            String phone = "";
            String email = "";
            String companyName = "";

            while (rset.next()) {
                loginName = rset.getString("loginName");
                repID = rset.getInt("repID");
                name = rset.getString("name");
                phone = rset.getString("phone");
                email = rset.getString("email");
                companyName = rset.getString("CompanyName");
            }

            System.out.println("Company Representative Information");
            System.out.println("Login Name: " + loginName);
            System.out.println("RepID: " + repID);
            System.out.println("Full Name: " + name);
            System.out.println("Phone: " + phone);
            System.out.println("Email Address" + email);
            System.out.println("Company Name: " + companyName);

            rset.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            catchException(e);
        }
    }

    /**
     * Retrieve information for specified wine label form
     *
     * @param input      Scanner object to get user's input
     * @param connection database's connection
     */
    private static void getWineLabelFormInfo(Scanner input, Connection connection) {
        System.out.println("Enter Wine Label Form ID:");
        String inputWineID = input.nextLine();

        try {
            Statement stmt = connection.createStatement();
            String str1 = "select A.name from forms F" +
                    " join reps R on F.repID = R.repID" +
                    " join accounts A on A.loginName = R.loginName" +
                    " where F.formID = " + inputWineID;

            String str2 = "select F.formID, F.status, W.brand, F.vintage, Ac.name" +
                    " from forms F join wines W on F.wineID = W.wineID" +
                    " join process P on P.formID = F.formID" +
                    " join Agents Ag on Ag.ttbID = P.ttbID" +
                    " join Accounts Ac on Ac.loginName = Ag.loginName" +
                    " where F.formID = " + inputWineID;

            int formID = 0;
            String status = "";
            String brand = "";
            String vintage = "";
            String companyRepName = "";
            LinkedList<String> names = new LinkedList<String>();

            ResultSet rset1 = stmt.executeQuery(str1);
            while (rset1.next()) {
                companyRepName = rset1.getString("name");
            }

            ResultSet rset = stmt.executeQuery(str2);
            while (rset.next()) {
                formID = rset.getInt("formID");
                status = rset.getString("status");
                brand = rset.getString("brand");
                vintage = rset.getString("vintage");
                names.add(rset.getString("name"));
            }

            System.out.println("Wine Label Form Information");
            System.out.println("Form ID: " + formID);
            System.out.println("Status: " + status);
            System.out.println("Wine Brand: " + brand);
            System.out.println("Vintage: " + vintage);
            System.out.println("Company Rep Full Name: " + companyRepName);
            System.out.print("Agent Full Names: ");

            //can just print names but will include []
            while (names.size() != 0) {
                System.out.print(names.remove());
                if (names.size() != 0) {
                    System.out.print(", ");
                }
            }
            System.out.println();
            rset1.close();
            rset.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            catchException(e);
        }
    }

    /**
     * Update the phone number of the rep given his/her login name
     *
     * @param input      Scanner object to get user's input
     * @param connection database's connection
     */
    private static void updatePhoneNum(Scanner input, Connection connection) {
        System.out.println("Enter Company Rep Login Name: ");
        String inputLogin = input.nextLine();
        System.out.println("Enter Updated Phone Number: ");
        String inputNewPhone = input.nextLine();

        try {
            Statement stmt = connection.createStatement();
            String str = "update Accounts set phone = " + "\'" + inputNewPhone + "\'" + " where loginname = \'" + inputLogin + "\'";
            int rset = stmt.executeUpdate(str);
            System.out.println(rset + " row affected.");

            stmt.close();
            connection.close();
        } catch (SQLException e) {
            catchException(e);
        }
    }

    /**
     * Handle SQL exception
     *
     * @param e: SQL exception engaged
     */
    private static void catchException(SQLException e) {
        System.out.println("Get Data Failed! Check output console!");
        e.printStackTrace();
    }
}
