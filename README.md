## How-To's  

Repository with technical indications to install, configure any interesting stuff. 

### Resources

1. [FizzBuzz Python test](src/fizzbuzz1.py)
2. [NewPassword Generator Java test](src/NewPasswordGenerator.java)
3. [Preparing-Python-Dev-Env-Mac-OSX](src/preparing_python_dev_env_mac_osx.md)
4. [Disabling sleeping when close laptop lid](src/disable_sleeping_when_close_laptop_lid.md)
5. [Install IDE and DevOps tools](src/devops_tools_install_v1.sh) (MS VSCode, extensions, Terraform, Packer, Java, AWS Cli, etc.) in **Ubuntu**
```sh
curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/devops_tools_install_v1.sh | bash
```  
6. Install IDE and DevOps tools:  
   * [Install](src/code_server_install.sh)/[Remove](src/code_server_remove.sh) only **Code-Server** in Ubuntu (amd64):
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/code_server_install.sh | bash
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/code_server_remove.sh | bash
   ```
   * [Install](src/code_server_install_rpi.sh)/[Remove](src/code_server_remove_rpi.sh) only **Code-Server** in Raspberry Pi (arm):
   ```sh
   wget -qN https://raw.githubusercontent.com/chilcano/how-tos/master/src/code_server_install_rpi.sh
   wget -qN https://raw.githubusercontent.com/chilcano/how-tos/master/src/code_server_remove_rpi.sh
   chmod +x code_server_*.sh
   . code_server_install_rpi.sh
   . code_server_remove_rpi.sh
   ```
   * [Install](src/code_server_install_wsl2.sh)/[Remove](src/code_server_remove_wsl2.sh) only **Code-Server** in WLS2 (Ubuntu 20.04):
   ```sh
   wget -qN https://raw.githubusercontent.com/chilcano/how-tos/master/src/code_server_install_wsl2.sh
   wget -qN https://raw.githubusercontent.com/chilcano/how-tos/master/src/code_server_remove_wsl2.sh
   chmod +x code_server_*.sh
   . code_server_install_wsl2.sh
   . code_server_remove_wsl2.sh
   ```
   * [Install](src/devops_tools_install_v3.sh)/[Remove](src/devops_tools_remove_v2.sh) DevOps tools v3. It works in Ubuntu (amd64), Raspberry Pi (arm) and WSL2 (Ubuntu/amd64).
   ```sh
   wget -qN https://raw.githubusercontent.com/chilcano/how-tos/master/src/devops_tools_install_v3.sh \
            https://raw.githubusercontent.com/chilcano/how-tos/master/src/devops_tools_remove_v3.sh
   chmod +x devops_tools_*.sh  
   . devops_tools_install_v3.sh --arch=[amd|arm] [--tf-ver=0.11.15-oci] [--packer-ver=1.5.5]
   ```
7. Customizing the Ubuntu Prompt  
   - [With Synth Shell](src/custom_prompt_with_synth_shell.md)  
   - [With Fancy GIT](src/custom_prompt_with_fancy_git.md)  
   - [With Powerline-Go](src/custom_prompt_with_powerline_go.md)  
8. [Install custom Fonts in Ubuntu](src/install_fonts_in_ubuntu.sh)  
   This script will install 3 patched fonts including glyphs to be used in custom Terminal Prompt:  
   - [Menlo-for-Powerline](https://github.com/abertsch/Menlo-for-Powerline)
   - [SourceCodePro Powerline Awesome Regular](https://github.com/diogocavilha/fancy-git/blob/master/fonts/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf)
   - [Droid Sans Mono Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf)
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/install_fonts_in_ubuntu.sh | bash
   ```  
9. Patching Fonts in Code-Server in Raspberry Pi   
   This process will patch Code-Server running in Raspberry Pi (installed in `/usr/lib/node_modules/code-server`) to use custom fonts.  
   Further info: [https://github.com/cdr/code-server/issues/1374](https://github.com/cdr/code-server/issues/1374)  
   ```sh
   git clone https://github.com/tuanpham-dev/code-server-font-patch
   sudo ./code-server-font-patch/patch.sh /usr/lib/node_modules/code-server
   systemctl --user restart code-server
   ```  
10. [Install **Jekyll** in Linux](src/jekyll_setting_in_linux.sh). Tested in Ubuntu 18.04, above and Raspbian/Raspberry Pi OS.  
   It will install also Ruby, Ruby-dev, build-essential, zlib1g-dev, Gem, Bundler, etc.  
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/jekyll_setting_in_linux.sh | bash
   ```   
   Running Jekyll:   
   ```sh
   JEKYLL_ENV=production bundle exec jekyll serve --incremental --watch
   JEKYLL_ENV=production bundle exec jekyll serve --incremental --watch --host=0.0.0.0
   JEKYLL_ENV=production bundle exec jekyll serve --watch --drafts
   RUBYOPT=-W0 JEKYLL_ENV=production bundle exec jekyll serve --incremental --watch 
   ```
11. GIT guides:
   - [Github - Frequent commands](src/git_frequent_commands.md)
   - [Github - Authentication](src/git_auth_guide.md)
   - [GitHub's Hub wrapper - Install and configure](src/git_and_hub_setting_in_linux.sh)
   ```sh
   source <(curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/git_and_hub_setting_in_linux.sh)
   source <(curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/git_and_hub_setting_in_linux.sh) -u=Chilcano -e=chilcano@intix.info
   ```
12. [Getting CPU and GPU temperature in Ubuntu 19.04](src/getting_temperature_cpu_gpu_hd_in_ubuntu.md)
13. [Installing Logitech Unifying (Keyboard adn mice) in Ubuntu 19.04](src/installing_logitech_unifying_in_ubuntu_19_04.md)
14. [Install and configure Asus MB168b screen in Ubuntu 18.04](src/install_and_setup_mb168b_in_ubuntu.md)
15. [Working with Tmux](src/working_with_tmux.md)
16. [File sharing through Samba(SMB)](src/install_and_config_samba.md)
17. [Terraforms samples - where is the issue?](aws-terraform-where-is-the-issue/) 
18. AWS CloudFormation samples:  
   - Convert JSON to YAML.  
   ```sh
   ruby -ryaml -rjson -e 'puts YAML.dump(JSON.load(ARGF))' < cloudformation_template_example.json > cloudformation_template_example.yaml
   ```
   - [Creating an Affordable Remote DevOps Desktop with AWS CloudFormation](https://github.com/chilcano/affordable-remote-desktop/tree/master/src/cloudformation)
   - [Deploying AWS ECS Networking and Architecture Patterns](https://github.com/chilcano/cfn-samples/tree/master/ECS/README.md)
19. [Install TightVNC](https://raw.githubusercontent.com/chilcano/how-tos/master/src/vnc_install.sh) (VNC remote access) on Ubuntu 20.04
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/vnc_install.sh | bash 
   ```
20. [Install Apache Guacamole](https://raw.githubusercontent.com/chilcano/how-tos/master/src/guacamole_install.sh) (Remote access Gateway) on Ubuntu 20.04
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/guacamole_install.sh | bash
   ``` 
21. Host a site on GitHub Pages and Hugo.  
   Install Hugo and GitHub tools:    
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/hugo_setting_in_linux.sh | bash
   ```   
   Host an existing GitHub Pages repo using Hugo:   
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/hugo_dpio_create.sh | bash
   ```  
   Publish generated Hugo content in a specific GitHub Pages branch:   
   ```sh
   curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/hugo_dpio_update.sh | bash
   ```  
   Run a local Hugo site:  
   ```sh
   git clone https://github.com/data-plane/ghpages-dpio $HOME/gitrepos/ghpages-dpio/
   cd $HOME/gitrepos/ghpages-dpio/
   git checkout main
   cd ghp-scripts
   // replace the IP address with yours
   hugo server -D --bind=0.0.0.0 --baseURL=http://192.168.1.59:1313/ghpages-dpio/
   ``` 
22. [Migration of GitHub Page site from Jekyll to Hugo](src/migrate_jekyll_to_hugo.md)  
23. [Creating booteable USB on Ubuntu](src/booteable_usb_on_ubuntu.md)  
24. [Google Drive on Ubuntu with XFCE](src/google_drive_on_linux.md)  
25. [Change the brightness level of a screen](src/set_brightness_level.sh)
```sh
source <(curl -s https://raw.githubusercontent.com/chilcano/how-tos/master/src/set_brightness_level.sh) --screen=DP-1 --level=0.90
```
26. [Screenshot and Screen Annotation Tools](src/screen_tools.md)
[Take screenshots silently in Ubuntu](src/silent_screenshooter.md)
