# Post Install script for Pop!_OS (22.04)

Post-installation script for the `Pop!_OS` distribution, based on Ubuntu. The script contains internet verification and whether `wget` is installed on the device. Also, install `apt`, `flatpak` and `deb` packages; updates repositories and performs system cleanup.

***
![image](https://user-images.githubusercontent.com/70844369/195471666-c7a930d4-19ac-4605-80e3-4bd3120c39c3.png#vitrinedev)

>Note: The script was designed for Pop!_OS 22.04 LTS, but it may also work on other Debian/Ubuntu-based distributions. However, please be cautious and ensure compatibility before running it on other systems.

1. Download

Download the entire "post-install-pop-os" folder containing the script files to your preferred location. You can clone the repository using Git or download it as a ZIP file from the repository's webpage.

```bash
git clone <repo url>
```

2. Navigate to the "Downloads" Directory:

Open your terminal and navigate to the "Downloads" directory, where you have saved the "post-install-pop-os" folder. You can use the cd command to change directories:

```bash
cd ~/Downloads/post-install-pop-os
```

3. Make the Scripts Executable:


```bash
chmod +x run.sh
```

4. Run the Post-Install Setup Script:

Execute the `run.sh` script to start the post-installation process. The script will automatically run and make executable the `post-install.sh` script and then the `alias.sh` script, installing necessary packages and setting up custom aliases.

```bash
./run.sh
```

5. Follow On-Screen Instructions:

The setup script will display colorful and informative messages as it progresses through the installation and configuration steps. You may need to provide your password for certain operations that require administrative privileges.

6. Review Installed Software and Aliases:

After the setup is completed, you can review the installed software and aliases on your system. The `post-install.sh` script installs software packages listed in its configuration, while `alias.sh` sets up custom aliases.


7. Customize Aliases and Installed programs Optional):

You can modify or add your own custom aliases in the `alias.sh` script to suit your workflow. Edit the CUSTOM_ALIASES array with the desired aliases, and run the `alias.sh` script again to update your .bash_aliases file.

```bash
CUSTOM_ALIASES=(
    'alias <aliasName>="<what it does"'
    .
    .
    .
    .
)
```

>**Important**: While the script aims to automate setup tasks, it's essential to review the code and understand what it does before running it on your machine. **Ensure that you back up critical data before proceeding**. The script provided is for **educational purposes** and comes with **no warranty or support**.


