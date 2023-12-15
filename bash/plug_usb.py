import os

path = '/mnt/usb'
usb_folder_exists = os.path.isdir(path) and os.path.exists(path)
list_partitions_command = 'lsblk'

def mount_usb():
    mode = input('Is for mount?: ')
    if mode == "yes":
        os.system(list_partitions_command)
        letters = input('Enter the letter and number of the partition: ')
        mount_usb_command = f'sudo mount /dev/sd{letters} {path}'

        os.system(mount_usb_command)
        print('Mounted!')
    else:
        if len(os.listdir(path)) == 0:
            print('What do you mean? the usb folder is empty')
        else:
            os.system(f'sudo umount {path}')
            print('Unmounted!')

if __name__ == "__main__":
    if usb_folder_exists:
        mount_usb()
    else:
        print("The folder hasn't been created")
