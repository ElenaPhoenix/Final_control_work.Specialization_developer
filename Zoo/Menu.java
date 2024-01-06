import java.util.InputMismatchException;
import java.util.Scanner;

public class Menu {
    private final Database database;
    private final Scanner scanner;

    public Menu(Database database) {
        this.database = database;
        scanner = new Scanner(System.in);
    }

    public void displayMenu() {
        while (true) {
            try {
                System.out.println("Menu:");
                System.out.println("1. Add a new animal");
                System.out.println("2. Show a list of all animals");
                System.out.println("3. View the list of animal commands");
                System.out.println("4. Train an animal to a new command");
                System.out.println("0. Exit");
                System.out.print("Select a menu item: ");
                int choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1 -> addNewAnimal();
                    case 2 -> database.displayAllAnimals();
                    case 3 -> displayAnimalCommands();
                    case 4 -> teachNewCommand();
                    case 0 -> {
                        System.out.println("Program is completed.");
                        return;
                    }
                    default -> System.out.println("Wrong choice. Try again.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Error: Incorrect input format. Try again.");
                scanner.nextLine(); // Очистка буфера сканера после ошибочного ввода
            }
        }
    }


    private void addNewAnimal() {
        System.out.println("Enter the name of the animal:");
        String name = scanner.nextLine();
        System.out.println("Enter a comma-separated list of commands:");
        String skills = scanner.nextLine();

        System.out.println("Choose an animal class:");
        System.out.println("1. Dog");
        System.out.println("2. Cat");
        System.out.println("3. Hamster");
        System.out.println("4. Donkey");
        System.out.println("5. Horse");
        int animalClass = scanner.nextInt();
        scanner.nextLine();

        Animals animal;
        switch (animalClass) {
            case 1 -> animal = new Dog(name, skills);
            case 2 -> animal = new Cat(name, skills);
            case 3 -> animal = new Hamster(name, skills);
            case 4 -> animal = new Donkey(name, skills);
            case 5 -> animal = new Horse(name, skills);
            default -> {
                System.out.println("Wrong choice of animal class.");
                return;
            }
        }

        database.addAnimal(animal);
        System.out.println("The animal has been successfully added to the database.");
    }

    private void displayAnimalCommands() {
        System.out.println("Enter the name of the animal:");
        String name = scanner.nextLine();

        database.displayAnimalCommands(name);
    }

    private void teachNewCommand() {
        System.out.println("Enter the name of the animal:");
        String name = scanner.nextLine();
        System.out.println("Enter new commands separated by commas:");
        String command = scanner.nextLine();

        database.teachNewCommand(name, command);
        System.out.println("Command has been successfully added for the animal.");
    }
}