import matplotlib.pyplot as plt
def plot_data(filename):
    x_values = []
    y_values = []

    # Read data from the file
    try:
        with open(filename, "r") as file:
            for line in file:
                x, y = map(float, line.strip().split(","))
                x_values.append(x)
                y_values.append(y)
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
        return
    except ValueError:
        print(f"Error: Invalid data format in file '{filename}'.")
        return

    # Plot the data points
    plt.figure(figsize=(10, 6))
    plt.scatter(x_values, y_values, color="blue", label="Generated Points", alpha=0.6)
    plt.plot(x_values, y_values, color="red", linestyle="--", alpha=0.5, label="Trend Line")
    plt.title("Generated Polynomial Data Points")
    plt.xlabel("X")
    plt.ylabel("Y")
    plt.legend()
    plt.grid(True)
    plt.savefig("plot.png")

if __name__ == "__main__":
    filename = input("Enter the filename containing the data points: ")
    plot_data(filename)
