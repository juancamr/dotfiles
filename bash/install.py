import os


def install_pacman(package: str):
    try:
        if "yay" in package:
            command = f"yay -S {package.split()[1]}"
        elif "remove" in package:
            command = f"sudo pacman -R {package.replace('remove', '')}"
        else:
            command = f"sudo pacman -S {package}"
        os.system(command)
    except KeyboardInterrupt:
        print(" Exiting...")


if __name__ == "__main__":
    package = input("Enter the package name: ")
    install_pacman(package)
