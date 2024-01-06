import java.io.*;
import java.util.*;

public class Database {
    private final List<Animals> animals;
    private static final String FILE_PATH = "database.txt";

    public Database() {
        animals = new ArrayList<>();
        loadDatabase();
    }

    public void addAnimal(Animals animal) {
        animals.add(animal);
        saveDatabase();
    }

    public void displayAnimalCommands(String name) {
        for (Animals animal : animals) {
            if (animal.getName().equals(name)) {
                animal.displayCommands();
                return;
            }
        }
        System.out.println("Animal " + name + " not found.");
    }



    public void teachNewCommand(String name, String command) {
        for (Animals animal : animals) {
            if (animal.getName().equals(name)) {
                String[] commands = command.split(",");
                for (int i = 0; i < commands.length; i++) {
                    String trimmedCommand = commands[i].trim();
                    commands[i] = trimmedCommand;
                }
                animal.teachNewCommand(command);
                saveDatabase();
                System.out.println("New command has been successfully added.");
                return;
            }
        }
        System.out.println("Animal " + name + " not found.");
    }


    private void loadDatabase() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 3) {
                    String className = data[0];
                    String name = data[1];
                    String skills = String.join(",", Arrays.copyOfRange(data, 2, data.length));

                    Animals animal;
                    switch (className) {
                        case "Dog" -> animal = new Dog(name, skills);
                        case "Cat" -> animal = new Cat(name, skills);
                        case "Hamster" -> animal = new Hamster(name, skills);
                        case "Donkey" -> animal = new Donkey(name, skills);
                        case "Horse" -> animal = new Horse(name, skills);
                        default -> {
                            System.out.println("Unknown animal class: " + className);
                            continue;
                        }
                    }
                    animals.add(animal);
                } else {
                    System.out.println("Incorrect data in the file: " + line);
                }
            }
            System.out.println("Database has been loaded successfully.");
        } catch (IOException e) {
            System.out.println("Error while trying to read database: " + e.getMessage());
        }
    }


    public void displayAllAnimals() {
        try {
            File file = new File(FILE_PATH);
            Scanner fileScanner = new Scanner(file);

            while (fileScanner.hasNextLine()) {
                String animalData = fileScanner.nextLine();
                System.out.println(animalData);
            }

            fileScanner.close();
        } catch (FileNotFoundException e) {
            System.out.println("File was not found.");
        }
    }

    private void saveDatabase() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Animals animal : animals) {
                String className = animal.getClass().getSimpleName();
                String name = animal.getName();
                String skills = animal.getSkills().replaceAll(",\\s+", ",");

                String line = className + " " + name + " " + skills;
                writer.write(line);
                writer.newLine();
            }
            System.out.println("Database has been saved successfully.");
        } catch (IOException e) {
            System.out.println("Error when trying to save the database: " + e.getMessage());
        }
    }

}
