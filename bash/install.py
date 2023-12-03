import os

try:
    package: str = input("Enter the package name: ")

    extra = "extra"
    yay = "yay"

    if extra in package:
        package = package.split()[1]
        command = f"sudo pacman -Ss -r {extra} {package}"
    elif yay in package:
        package = package.split()[1]
        command = f'yay -S {package}'
    else:
        command = f'sudo pacman -S {package}'

    os.system(command)
except KeyboardInterrupt:
    print(' Exiting...')
