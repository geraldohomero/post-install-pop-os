# Post Install script for Pop!_OS (22.04)

Post-installation script for the `Pop!_OS` distribution, based on Ubuntu. The script contains internet verification and whether `wget` is installed on the device. Also, install `apt`, `flatpak` and `deb` packages; updates repositories and performs system cleanup.

***

>**Note**: The script was designed for **Pop!_OS 22.04 (LTS)**, but it may also work on other Debian/Ubuntu-based distributions. However, please be cautious and ensure compatibility before running it on other systems.

>**Important**: While the script aims to automate setup tasks, it's essential to review the code and understand what it does before running it on your machine. **Ensure that you back up critical data before proceeding**. The script provided is for **educational purposes** and comes with **no warranty or support**.

1. Download

Download the entire "post-install-pop-os" folder containing the script files to your preferred location. You can clone (to the **Downloads** folder) the repository using Git or download it as a ZIP file from the repository's webpage.

At the terminal, run:

```bash
git clone https://github.com/geraldohomero/post-install-pop-os.git $HOME/Downloads
```

2. Make the Scripts Executable:

```bash
chmod +x $HOME/Downloads/post-install-pop-os/run.sh
```

3. Run the Post-Install Setup Script:

Execute the `run.sh` script to start the post-installation process. The script will automatically run and make executable the `post-install.sh` script and then the `alias.sh` script, installing necessary packages and setting up custom aliases.

```bash
$HOME/Downloads/post-install-pop-os/run.sh
```

Or just copy and paste the following command in the terminal:

```bash
git clone https://github.com/geraldohomero/post-install-pop-os.git $HOME/Downloads
chmod +x $HOME/Downloads/post-install-pop-os/run.sh
$HOME/Downloads/post-install-pop-os/run.sh
```

4. Follow On-Screen Instructions:

The setup script will display colorful and informative messages as it progresses through the installation and configuration steps. You may need to provide your password for certain operations that require administrative privileges.

5. Review Installed Software and Aliases:

After the setup is completed, you can review the installed software and aliases on your system. The `post-install.sh` script installs software packages listed in its configuration, while `alias.sh` sets up custom aliases.

6. Customize Aliases and Installed programs (Optional):

You can modify or add your own custom aliases in the `alias.sh` script to suit your workflow. Edit the CUSTOM_ALIASES array with the desired aliases, and run the `alias.sh` script again to update your .bash_aliases file. The same principle is valid for the `post-install.sh` and the arrays of the `flatpak` and `apt`. 

```bash
CUSTOM_ALIASES=(
    'alias <aliasName>="<what it does>"'
    .
    .
    .
)
```
7. This script also adds `update.sh` and `syncthingStatus.sh` to the home directory with execution permissions so that their aliases can work as intended. See it in `run.sh` for more information.

8. The script will add the `swapAudio.sh` script to the home directory with execution permissions so that its alias can work as intended. See it in `run.sh` and `/misc/swapAudio.sh` for more information.

