
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  echo "Cloning $repo from $user..."
  git clone https://github.com/$user/$repo.git
  check_success "cloning $repo"
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [pipe-jackd]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [master_shell_v3]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  for repo in "${!repos[@]}"; do
    clone_repo $repo ${repos[$repo]}
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

To use the script:
Save it as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will guide you through cloning the repositories, optionally compiling the script with shc, and creating a Dockerfile.
This will install each repo listed?
Yes, the script clones each repository listed from GitHub under the JeremyEngram user. If you need additional steps to install or configure each repository after cloning, please provide those details. For now, the script only handles the cloning process.
Here's the script again for clarity:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  echo "Cloning $repo from $user..."
  git clone https://github.com/$user/$repo.git
  check_success "cloning $repo"
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [pipe-jackd]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [master_shell_v3]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  for repo in "${!repos[@]}"; do
    clone_repo $repo ${repos[$repo]}
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

To run this script:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script only clones the repositories. If you need additional installation steps for each repository, please provide those instructions.
Create an SQL table for unstructured data in current database unstructured ChatGPT ChatGPT To create an SQL table for unstructured data in a database named unstructured, you can use the following SQL statement. This example assumes you want to store unstructured data like JSON, XML, or free-form text, which are common formats for unstructured data. Here's a basic template: sql Copy code CREATE TABLE unstructured_data_table ( id INT PRIMARY KEY, data TEXT ); In this table: id is a unique identifier for each record. You might use a different type or additional columns based on your requirements. data is a column of type TEXT which will store the unstructured data. If you're dealing with specific unstructured data formats like JSON or XML, and your database system supports it, you can use a specific data type like JSONB in PostgreSQL for better performance and functionality. Remember to adjust the table and column names as well as the data types according to your specific needs and the capabilities of your SQL database. You Create one for structured data ChatGPT ChatGPT Creating an SQL table for structured data involves defining a more specific schema that outlines the exact structure and data types of each column. Here's a basic template for a structured data table. The exact structure will depend on your specific needs, such as the type of data you're storing and the database's capabilities: sql Copy code CREATE TABLE structured_data_table ( id INT PRIMARY KEY, column1 VARCHAR(255), column2 INT, column3 DATE, -- Additional columns as required ); In this table: id is a unique identifier for each record. column1, column2, column3, etc., are placeholders for your actual column names. Replace them with relevant names that reflect the data they will store. VARCHAR(255), INT, DATE, etc., are data types. Choose the appropriate data types based on the nature of your data (text, numbers, dates, etc.). This is a very basic structure. In a real-world scenario, you might have more columns, different data types, and possibly constraints like NOT NULL, UNIQUE, or foreign keys for relational data. Adjust the template as per your requirements. You Create it for structured paragraphs or large blobs ChatGPT ChatGPT If you need to create an SQL table specifically for storing structured paragraphs or large blobs of text, you would generally use a data type that can handle large amounts of text. In SQL, this is often accomplished using types like TEXT or BLOB, depending on whether the content is textual or binary. Here's an example SQL statement for such a table: sql Copy code CREATE TABLE structured_paragraphs ( id INT PRIMARY KEY, title VARCHAR(255), paragraph TEXT, additional_info TEXT, -- Additional columns as required ); In this table: id is a unique identifier for each record. title is a shorter text field, assuming each paragraph might have a title or heading. I've used VARCHAR(255), but adjust the length according to your needs. paragraph is the main field for storing the structured paragraph. TEXT is suitable for large blocks of text. additional_info can be used to store any supplementary text related to the paragraph. This is optional and can be modified or removed based on your requirements. The use of TEXT is typical for storing long strings of text in SQL databases. However, if your database supports specific large object types like BLOB, CLOB, or specialized types for JSON or XML, you can choose those instead, depending on the exact nature of your data. You Create a table for an individual based on their first and last name as primary key or Increment ID ChatGPT ChatGPT Creating a table for individuals where you can use either a combination of first and last name as a primary key or an incremental ID involves making a decision on the primary key strategy. Using names as a primary key is generally not recommended because names are not guaranteed to be unique. Instead, an auto-incrementing ID is typically used as a primary key. Here's an example of how you might define such a table: sql Copy code CREATE TABLE individuals ( id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), -- Additional columns as required ); In this table: id is an auto-incrementing integer that serves as the primary key. This ensures that each individual has a unique identifier. first_name and last_name are columns to store the individual's first and last names. Remember, the AUTO_INCREMENT keyword is used in MySQL. If you're using a different SQL database, the syntax might vary (e.g., SERIAL in PostgreSQL, IDENTITY in SQL Server, etc.). If for some reason you still want to use a combination of first and last name as a primary key, you could define it like this: sql Copy code CREATE TABLE individuals ( first_name VARCHAR(255), last_name VARCHAR(255), -- Additional columns as required PRIMARY KEY (first_name, last_name) ); However, this approach has significant limitations and risks (e.g., handling individuals with identical names, changes in names, etc.) and is not typically recommended for most applications. You CREATE TABLE individuals ( id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), extra_detsils VARCHAR(255), ); ChatGPT ChatGPT The SQL statement you provided is almost correct for creating a table named individuals with an auto-incrementing primary key and columns for storing first name, last name, and extra details. However, there's a small typo at the end of your statement. The correct and complete SQL statement should look like this: sql Copy code CREATE TABLE individuals ( id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), extra_details VARCHAR(255) ); This statement will create a table with the following columns: id: An integer that auto-increments and serves as the primary key. first_name: A variable character field with a maximum length of 255 characters. last_name: A variable character field with a maximum length of 255 characters. extra_details: A variable character field with a maximum length of 255 characters, meant for any additional information you might want to store. Remember to execute this SQL statement in your database management system to create the table. The syntax for AUTO_INCREMENT is specific to MySQL and MariaDB. If you're using a different database system like PostgreSQL, SQL Server, or Oracle, the syntax for the auto-incrementing feature will be different. You Create table for just hyperlink urls ChatGPT ChatGPT To create a table specifically for storing hyperlink URLs, you would typically use a text field that can accommodate the variable length of URLs. Here's an example SQL statement to create such a table: sql Copy code CREATE TABLE hyperlinks ( id INT AUTO_INCREMENT PRIMARY KEY, url VARCHAR(2048) ); In this table: id is an auto-incrementing integer that serves as the primary key. This ensures that each URL stored has a unique identifier. url is a variable character field for storing the hyperlink URL. The length of 2048 is chosen because URLs can sometimes be quite long, although the maximum length of a URL is technically undefined. Adjust the length as needed based on your expected data. This structure is simple and effective for most use cases. However, if you expect to store extremely long URLs or want to optimize for database-specific features, you might choose a different data type or structure. For instance, some databases support a specific URL type or larger text fields like TEXT for very long strings. You Create table email_addresses ChatGPT ChatGPT To create a table specifically for storing email addresses, you can use a structure similar to the following SQL statement. This example assumes a simple table with an auto-incrementing ID and a column for the email address: sql Copy code CREATE TABLE email_addresses ( id INT AUTO_INCREMENT PRIMARY KEY, email VARCHAR(320) ); In this table: id is an auto-incrementing integer that serves as the primary key. This provides a unique identifier for each record. email is a variable character field with a maximum length of 320 characters. This length is chosen based on the maximum length of an email address as per standards (local part: 64 characters, domain: 255 characters, plus one character for the '@' symbol). This structure provides a straightforward way to store and manage email addresses. You can modify the table structure to include additional fields if needed, such as timestamps for when the email was added or flags for validation status. ChatGPT can make mistakes. Consider checking important information.

To create a table specifically for storing email addresses, here is the SQL statement with an auto-incrementing primary key and a column for the email address:
sql
Copy code
CREATE TABLE email_addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(320)
);

Explanation:
id: An auto-incrementing integer that serves as the primary key, ensuring each record has a unique identifier.
email: A variable character field with a maximum length of 320 characters, which accommodates the maximum length of email addresses as per standards.
You can execute this SQL statement in your database management system to create the table. This simple structure effectively manages email addresses, and you can extend it with additional fields as needed.
https://github.com/JeremyEngram/autoenv/tree/master Add this to the installer

To add the autoenv repository from JeremyEngram's GitHub to the installer script, we need to modify the script to include this repository as well. Here's the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  echo "Cloning $repo from $user..."
  git clone https://github.com/$user/$repo.git
  check_success "cloning $repo"
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [pipe-jackd]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [master_shell_v3]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [autoenv]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  for repo in "${!repos[@]}"; do
    clone_repo $repo ${repos[$repo]}
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

Changes Made:
Added the autoenv repository to the repos associative array.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will now also clone the autoenv repository along with the others.
https://github.com/JeremyEngram/genkeyauth

To add the genkeyauth repository from JeremyEngram's GitHub to the installer script, we'll include this repository in the list. Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  echo "Cloning $repo from $user..."
  git clone https://github.com/$user/$repo.git
  check_success "cloning $repo"
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [pipe-jackd]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [master_shell_v3]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  for repo in "${!repos[@]}"; do
    clone_repo $repo ${repos[$repo]}
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

Changes Made:
Added the genkeyauth repository to the repos associative array.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will now also clone the genkeyauth repository along with the others.
https://github.com/JeremyEngram/iKy

To add the iKy repository from JeremyEngram's GitHub to the installer script, we'll include this repository in the list. Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  echo "Cloning $repo from $user..."
  git clone https://github.com/$user/$repo.git
  check_success "cloning $repo"
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [pipe-jackd]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [master_shell_v3]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [iKy]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  for repo in "${!repos[@]}"; do
    clone_repo $repo ${repos[$repo]}
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc

Remove pipe-jackd And master_shell_v3 - all repos with omnilog go to the same directory /opt/omniscient/omnilog and stay in the same directories

Here is the updated script that excludes pipe-jackd and master_shell_v3, and clones all repositories with "omnilog" in their names to /opt/omniscient/omnilog while preserving their directory structures:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [iKy]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  mkdir -p /opt/omniscient/omnilog

  for repo in "${!repos[@]}"; do
    if [[ $repo == omnilog* ]]; then
      clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
    else
      clone_repo $repo ${repos[$repo]} .
    fi
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

Changes Made:
Removed pipe-jackd and master_shell_v3 from the repos associative array.
Added logic to clone all repositories with "omnilog" in their names to /opt/omniscient/omnilog while preserving their directory structures.
Other repositories will be cloned to the current directory.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will now clone the specified repositories, with "omnilog" repositories being placed in /opt/omniscient/omnilog.
https://github.com/JeremyEngram/init.scripts - chmod all scripts in directory and execute one by one before continuing git repos install

To modify the script to include cloning and executing all scripts from the init.scripts repository before continuing with the cloning of the other repositories, here's the updated script:
Clone the init.scripts repository.
Change the permissions of all scripts in the directory to be executable.
Execute each script one by one.
Continue with the cloning of the other repositories.
Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [iKy]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient/omnilog

  for repo in "${!repos[@]}"; do
    if [[ $repo == omnilog* ]]; then
      clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
    else
      clone_repo $repo ${repos[$repo]} .
    fi
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

Changes Made:
Added a clone_repo call for init.scripts before cloning the other repositories.
Added the execute_scripts function to change permissions and execute all scripts in the init.scripts directory.
The main function now first clones and executes the init.scripts repository before proceeding with the other repositories.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will now clone and execute all scripts in the init.scripts repository before cloning the other specified repositories, with the "omnilog" repositories being placed in /opt/omniscient/omnilog.
https://github.com/JeremyEngram/omnilog_llm_lm https://github.com/JeremyEngram/omnieye https://github.com/JeremyEngram/nmapai

Let's update the script to include the new repositories (omnilog_llm_lm, omnieye, and nmapai). We'll also ensure that any repositories with "omnilog" in their name are cloned to /opt/omniscient/omnilog while maintaining their directory structure.
Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient/omnilog

  for repo in "${!repos[@]}"; do
    if [[ $repo == omnilog* ]]; then
      clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
    else
      clone_repo $repo ${repos[$repo]} .
    fi
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

Changes Made:
Added omnilog_llm_lm, omnieye, and nmapai to the repos associative array.
Ensured that repositories with "omnilog" in their names are cloned to /opt/omniscient/omnilog.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will now clone and execute all scripts in the init.scripts repository before cloning the other specified repositories, with the "omnilog" repositories being placed in /opt/omniscient/omnilog.
https://github.com/JeremyEngram/socmint https://github.com/JeremyEngram/disk-forensics https://github.com/JeremyEngram/disasterecovery https://github.com/JeremyEngram/socmint-menu

Let's update the script to include the new repositories (socmint, disk-forensics, disasterecovery, and socmint-menu). We'll also continue to ensure that any repositories with "omnilog" in their names are cloned to /opt/omniscient/omnilog while maintaining their directory structure.
Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [arsenal]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [bashrc]="JeremyEngram"
  [master_shell]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [BASH2SQL]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient/omnilog

  for repo in "${!repos[@]}"; do
    if [[ $repo == omnilog* ]]; then
      clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
    else
      clone_repo $repo ${repos[$repo]} .
    fi
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
  FROM ubuntu:latest

  # Install required packages
  RUN apt-get update && apt-get install -y git shc

  # Copy and run the installer script
  COPY $(basename $0) /installer.sh
  RUN chmod +x /installer.sh && /installer.sh

  # Clean up
  RUN apt-get clean && rm -rf /var/lib/apt/lists/*

  CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

Changes Made:
Added socmint, disk-forensics, disasterecovery, and socmint-menu to the repos associative array.
Ensured that repositories with "omnilog" in their names are cloned to /opt/omniscient/omnilog.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will now clone and execute all scripts in the init.scripts repository before cloning the other specified repositories, with the "omnilog" repositories being placed in /opt/omniscient/omnilog.
Refactor #!/bin/bash # Logging setup LOGFILE="installer.log" exec > >(tee -a "$LOGFILE") 2>&1 # Function to check command success check_success() { if [ $? -ne 0 ]; then echo "Error during $1. Check the logs for details." exit 1 fi } # individual repo curl to bash curl -s https://github.com/JeremyEngram/omni_tunnels/blob/main/init.create.omnitunnrls.sh | bash # Function to clone a GitHub repository clone_repo() { local repo=$1 local user=$2 local destination=$3 echo "Cloning $repo from $user into $destination..." git clone https://github.com/$user/$repo.git $destination/$repo check_success "cloning $repo" } # Function to execute scripts in a directory execute_scripts() { local dir=$1 chmod +x $dir/*.sh for script in $dir/*.sh; do echo "Executing $script..." $script check_success "executing $script" done } # List of repositories and their owner declare -A repos=( [bashrc]="JeremyEngram" [menus]="JeremyEngram" [arsenal]="JeremyEngram" [genkeyauth]="JeremyEngram" [autoenv]="JeremyEngram" [Omniscient]="JeremyEngram" [aliasmaster]="JeremyEngram" [pipvenvmanager]="JeremyEngram" [managevenv]="JeremyEngram” [Omniscient_Github]="JeremyEngram" [omniscient_installers]="JeremyEngram" [omnilog]="JeremyEngram” [omnilog_additions]="JeremyEngram" [omnilog_rules]="JeremyEngram" [dockers]="JeremyEngram" [dfirmenu]="JeremyEngram" [ReconWhore]="JeremyEngram" [iKy]="JeremyEngram" [omnilog_llm_lm]="JeremyEngram" [omnieye]="JeremyEngram" [nmapai]="JeremyEngram" https://github.com/JeremyEngram/socmint-menu ) # Main installation function main() { echo "Starting the installation process..." # Clone and execute init.scripts clone_repo init.scripts JeremyEngram /tmp execute_scripts /tmp/init.scripts mkdir -p /opt/omniscient/omnilog for repo in "${!repos[@]}"; do if [[ $repo == omnilog* ]]; then clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog else clone_repo $repo ${repos[$repo]} . fi done echo "All repositories have been cloned successfully." } # Run the main function main # Prompt to compile the script with shc read -p "Do you want to compile this script with shc? (y/n): " compile if [ "$compile" = "y" ]; then if command -v shc &> /dev/null; then shc -f $0 check_success "compiling script with shc" echo "Script compiled successfully." else echo "shc is not installed. Please install it to compile the script." fi fi # Prompt to create a Dockerfile read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile if [ "$dockerfile" = "y" ]; then cat <<EOF > Dockerfile FROM ubuntu:latest # Install required packages RUN apt-get update && apt-get install -y git shc # Copy and run the installer script COPY $(basename $0) /installer.sh RUN chmod +x /installer.sh && /installer.sh # Clean up RUN apt-get clean && rm -rf /var/lib/apt/lists/* CMD ["/bin/bash"] EOF echo "Dockerfile created successfully." fi echo "Installation script completed."

Sure, let's refactor the script to include the individual repo curl to bash, fix any syntax issues, and ensure it follows the desired structure.
Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Individual repo curl to bash 
curl -s https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh | bash
check_success "executing omni_tunnels script"

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient/omnilog

  for repo in "${!repos[@]}"; do
    if [[ $repo == omnilog* ]]; then
      clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
    else
      clone_repo $repo ${repos[$repo]} .
    fi
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully."
fi

echo "Installation script completed."

Changes Made:
Fixed the syntax errors in the array and added the missing repositories.
Added the curl command to execute the omni_tunnels script.
Ensured the "omnilog" repositories are cloned into /opt/omniscient/omnilog.
Maintained the logging and error-checking structure.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will execute the omni_tunnels initialization script, clone and execute all scripts in the init.scripts repository, and then proceed to clone the specified repositories, with the "omnilog" repositories being placed in /opt/omniscient/omnilog.
Refactor #!/bin/bash # Logging setup LOGFILE="installer.log" exec > >(tee -a "$LOGFILE") 2>&1 # Function to check command success check_success() { if [ $? -ne 0 ]; then echo "Error during $1. Check the logs for details." exit 1 fi } # Individual repo curl to bash curl -s https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh | bash check_success "executing omni_tunnels script" # Function to clone a GitHub repository clone_repo() { local repo=$1 local user=$2 local destination=$3 echo "Cloning $repo from $user into $destination..." git clone https://github.com/$user/$repo.git $destination/$repo check_success "cloning $repo" } # Function to execute scripts in a directory execute_scripts() { local dir=$1 chmod +x $dir/*.sh for script in $dir/*.sh; do echo "Executing $script..." $script check_success "executing $script" done } # List of repositories and their owner declare -A repos=( [bashrc]="JeremyEngram" [menus]="JeremyEngram" [arsenal]="JeremyEngram" [genkeyauth]="JeremyEngram" [autoenv]="JeremyEngram" [Omniscient]="JeremyEngram" [aliasmaster]="JeremyEngram" [pipvenvmanager]="JeremyEngram" [managevenv]="JeremyEngram" [Omniscient_Github]="JeremyEngram" [omniscient_installers]="JeremyEngram" [omnilog]="JeremyEngram" [omnilog_additions]="JeremyEngram" [omnilog_rules]="JeremyEngram" [dockers]="JeremyEngram" [dfirmenu]="JeremyEngram" [ReconWhore]="JeremyEngram" [iKy]="JeremyEngram" [omnilog_llm_lm]="JeremyEngram" [omnieye]="JeremyEngram" [nmapai]="JeremyEngram" [socmint]="JeremyEngram" [disk-forensics]="JeremyEngram" [disasterecovery]="JeremyEngram" [socmint-menu]="JeremyEngram" ) # Main installation function main() { echo "Starting the installation process..." # Clone and execute init.scripts clone_repo init.scripts JeremyEngram /tmp execute_scripts /tmp/init.scripts mkdir -p /opt/omniscient mkdir -p /opt/omniscient/menus mkdir -p /opt/omniscient/omnilog mkdir -p /opt/omniscient/omnieye for repo in "${!repos[@]}"; do if [[ $repo == omnilog* ]]; then clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog else clone_repo $repo ${repos[$repo]} . fi done echo "All repositories have been cloned successfully." } # Run the main function main # Prompt to compile the script with shc read -p "Do you want to compile this script with shc? (y/n): " compile if [ "$compile" = "y" ]; then if command -v shc &> /dev/null; then shc -f $0 check_success "compiling script with shc" echo "Script compiled successfully." else echo "shc is not installed. Please install it to compile the script." fi fi # Prompt to create a Dockerfile # Place newly created dockerfiles in respective directories with the same filename in: /opt/omiscient/dockers read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile if [ "$dockerfile" = "y" ]; then cat <<EOF > Dockerfile FROM ubuntu:latest # Install required packages RUN apt-get update && apt-get install -y git shc # Copy and run the installer script COPY $(basename $0) /installer.sh RUN chmod +x /installer.sh && /installer.sh # Clean up RUN apt-get clean && rm -rf /var/lib/apt/lists/* CMD ["/bin/bash"] EOF echo "Dockerfile created successfully." fi echo "Installation script completed."

Here is the refactored script with the requested changes, including creating specific directories for different repositories and placing Dockerfiles in /opt/omniscient/dockers:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Individual repo curl to bash 
curl -s https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh | bash
check_success "executing omni_tunnels script"

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient
  mkdir -p /opt/omniscient/menus
  mkdir -p /opt/omniscient/omnilog
  mkdir -p /opt/omniscient/omnieye
  mkdir -p /opt/omniscient/dockers

  for repo in "${!repos[@]}"; do
    case $repo in
      omnilog* )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
        ;;
      menus )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/menus
        ;;
      omnieye )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnieye
        ;;
      dockers )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/dockers
        ;;
      * )
        clone_repo $repo ${repos[$repo]} .
        ;;
    esac
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
# Place newly created Dockerfiles in respective directories with the same filename in: /opt/omniscient/dockers
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > /opt/omniscient/dockers/Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully in /opt/omniscient/dockers."
fi

echo "Installation script completed."

Changes Made:
Added directories for menus, omnieye, and dockers in /opt/omniscient.
Ensured the "omnilog" repositories are cloned into /opt/omniscient/omnilog.
Added a case statement to handle different directory structures for different repositories.
Ensured Dockerfiles are placed in /opt/omniscient/dockers.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will execute the omni_tunnels initialization script, clone and execute all scripts in the init.scripts repository, and then proceed to clone the specified repositories into their respective directories. It also provides an option to create a Dockerfile in /opt/omniscient/dockers.
Add these to the list of repos https://github.com/JeremyEngram/socmint-menu https://github.com/JeremyEngram/pyforensics https://github.com/JeremyEngram/omnihub https://github.com/JeremyEngram/forensics-siab https://github.com/JeremyEngram/disk-forensics https://github.com/JeremyEngram/scrotshot https://github.com/JeremyEngram/nmapsploit2 https://github.com/JeremyEngram/omniscient-arsenal https://github.com/JeremyEngram/bootrepair https://github.com/JeremyEngram/bash.bashrc https://github.com/JeremyEngram/readme_manpages https://github.com/JeremyEngram/omniscient_base_system

Let's update the script to include the new repositories you specified. The new repositories will be added to the list, and they will be cloned into their respective directories.
Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Individual repo curl to bash 
curl -s https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh | bash
check_success "executing omni_tunnels script"

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
  [pyforensics]="JeremyEngram"
  [omnihub]="JeremyEngram"
  [forensics-siab]="JeremyEngram"
  [scrotshot]="JeremyEngram"
  [nmapsploit2]="JeremyEngram"
  [omniscient-arsenal]="JeremyEngram"
  [bootrepair]="JeremyEngram"
  [bash.bashrc]="JeremyEngram"
  [readme_manpages]="JeremyEngram"
  [omniscient_base_system]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient
  mkdir -p /opt/omniscient/menus
  mkdir -p /opt/omniscient/omnilog
  mkdir -p /opt/omniscient/omnieye
  mkdir -p /opt/omniscient/dockers

  for repo in "${!repos[@]}"; do
    case $repo in
      omnilog* )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
        ;;
      menus )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/menus
        ;;
      omnieye )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnieye
        ;;
      dockers )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/dockers
        ;;
      * )
        clone_repo $repo ${repos[$repo]} .
        ;;
    esac
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
# Place newly created Dockerfiles in respective directories with the same filename in: /opt/omniscient/dockers
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > /opt/omniscient/dockers/Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully in /opt/omniscient/dockers."
fi

echo "Installation script completed."

Changes Made:
Added the new repositories to the repos associative array.
Ensured the "omnilog" repositories are cloned into /opt/omniscient/omnilog.
Ensured other repositories are cloned into their respective directories or the current directory if not specified.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will execute the omni_tunnels initialization script, clone and execute all scripts in the init.scripts repository, and then proceed to clone the specified repositories into their respective directories. It also provides an option to create a Dockerfile in /opt/omniscient/dockers.
Add this one in with curl to | bash https://github.com/JeremyEngram/arsenal/blob/main/master_list_files

Sure, let's add the command to execute the script from the master_list_files repository via curl and pipe it to bash as part of the installation process.
Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Individual repo curl to bash 
curl -s https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh | bash
check_success "executing omni_tunnels script"

# Additional curl to bash for master_list_files
curl -s https://raw.githubusercontent.com/JeremyEngram/arsenal/main/master_list_files | bash
check_success "executing master_list_files script"

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
  [pyforensics]="JeremyEngram"
  [omnihub]="JeremyEngram"
  [forensics-siab]="JeremyEngram"
  [scrotshot]="JeremyEngram"
  [nmapsploit2]="JeremyEngram"
  [omniscient-arsenal]="JeremyEngram"
  [bootrepair]="JeremyEngram"
  [bash.bashrc]="JeremyEngram"
  [readme_manpages]="JeremyEngram"
  [omniscient_base_system]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient
  mkdir -p /opt/omniscient/menus
  mkdir -p /opt/omniscient/omnilog
  mkdir -p /opt/omniscient/omnieye
  mkdir -p /opt/omniscient/dockers

  for repo in "${!repos[@]}"; do
    case $repo in
      omnilog* )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
        ;;
      menus )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/menus
        ;;
      omnieye )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnieye
        ;;
      dockers )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/dockers
        ;;
      * )
        clone_repo $repo ${repos[$repo]} .
        ;;
    esac
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
# Place newly created Dockerfiles in respective directories with the same filename in: /opt/omniscient/dockers
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > /opt/omniscient/dockers/Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully in /opt/omniscient/dockers."
fi

echo "Installation script completed."

Changes Made:
Added the curl command to execute the master_list_files script.
Added the new repositories to the repos associative array.
Ensured the "omnilog" repositories are cloned into /opt/omniscient/omnilog.
Ensured other repositories are cloned into their respective directories or the current directory if not specified.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will execute the omni_tunnels initialization script, execute the master_list_files script, clone and execute all scripts in the init.scripts repository, and then proceed to clone the specified repositories into their respective directories. It also provides an option to create a Dockerfile in /opt/omniscient/dockers.
curl | bash for the following https://github.com/JeremyEngram/arsenal/blob/main/forgitboutit_function https://github.com/JeremyEngram/arsenal/blob/main/bootrepair

Sure, let's add the curl | bash commands for the forgitboutit_function and bootrepair scripts from the arsenal repository.
Here is the updated script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Individual repo curl to bash 
curl -s https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh | bash
check_success "executing omni_tunnels script"

# Additional curl to bash for master_list_files
curl -s https://raw.githubusercontent.com/JeremyEngram/arsenal/main/master_list_files | bash
check_success "executing master_list_files script"

# Additional curl to bash for forgitboutit_function
curl -s https://raw.githubusercontent.com/JeremyEngram/arsenal/main/forgitboutit_function | bash
check_success "executing forgitboutit_function script"

# Additional curl to bash for bootrepair
curl -s https://raw.githubusercontent.com/JeremyEngram/arsenal/main/bootrepair | bash
check_success "executing bootrepair script"

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
  [pyforensics]="JeremyEngram"
  [omnihub]="JeremyEngram"
  [forensics-siab]="JeremyEngram"
  [scrotshot]="JeremyEngram"
  [nmapsploit2]="JeremyEngram"
  [omniscient-arsenal]="JeremyEngram"
  [bootrepair]="JeremyEngram"
  [bash.bashrc]="JeremyEngram"
  [readme_manpages]="JeremyEngram"
  [omniscient_base_system]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."
  
  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient
  mkdir -p /opt/omniscient/menus
  mkdir -p /opt/omniscient/omnilog
  mkdir -p /opt/omniscient/omnieye
  mkdir -p /opt/omniscient/dockers

  for repo in "${!repos[@]}"; do
    case $repo in
      omnilog* )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
        ;;
      menus )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/menus
        ;;
      omnieye )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnieye
        ;;
      dockers )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/dockers
        ;;
      * )
        clone_repo $repo ${repos[$repo]} .
        ;;
    esac
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
# Place newly created Dockerfiles in respective directories with the same filename in: /opt/omniscient/dockers
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > /opt/omniscient/dockers/Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully in /opt/omniscient/dockers."
fi

echo "Installation script completed."

Changes Made:
Added the curl command to execute the forgitboutit_function script.
Added the curl command to execute the bootrepair script.
Maintained the other previous modifications.
Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script will execute the omni_tunnels, master_list_files, forgitboutit_function, and bootrepair initialization scripts, clone and execute all scripts in the init.scripts repository, and then proceed to clone the specified repositories into their respective directories. It also provides an option to create a Dockerfile in /opt/omniscient/dockers.
Create a copy and paste bash function for adding and executing external bash scripts

Sure, I can provide you with a reusable bash function for adding and executing external bash scripts via curl and piping the output to bash. This function can be added to any bash script where you need to dynamically execute remote scripts.
Here's the function:
bash
Copy code
#!/bin/bash

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to download and execute a bash script from a URL
execute_remote_script() {
  local url=$1
  echo "Executing script from $url..."
  curl -s $url | bash
  check_success "executing script from $url"
}

# Example usage
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh"
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/master_list_files"
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/forgitboutit_function"
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/bootrepair"

Explanation:
check_success(): This function checks if the last executed command was successful. If not, it logs an error message and exits the script.
execute_remote_script(): This function takes a URL as an argument, downloads the script from the URL using curl, and pipes it to bash for execution. It also uses check_success() to ensure the command runs successfully.
The example usage at the bottom shows how to use the execute_remote_script function to run the scripts you specified.
How to Use:
Copy the execute_remote_script function into your existing bash script.
Call the function with the URL of the script you want to execute.
For instance, you can integrate this function into the previously provided script:
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to download and execute a bash script from a URL
execute_remote_script() {
  local url=$1
  echo "Executing script from $url..."
  curl -s $url | bash
  check_success "executing script from $url"
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
  [pyforensics]="JeremyEngram"
  [omnihub]="JeremyEngram"
  [forensics-siab]="JeremyEngram"
  [scrotshot]="JeremyEngram"
  [nmapsploit2]="JeremyEngram"
  [omniscient-arsenal]="JeremyEngram"
  [bootrepair]="JeremyEngram"
  [bash.bashrc]="JeremyEngram"
  [readme_manpages]="JeremyEngram"
  [omniscient_base_system]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."

  # Execute remote scripts
  execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh"
  execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/master_list_files"
  execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/forgitboutit_function"
  execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/bootrepair"

  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient
  mkdir -p /opt/omniscient/menus
  mkdir -p /opt/omniscient/omnilog
  mkdir -p /opt/omniscient/omnieye
  mkdir -p /opt/omniscient/dockers

  for repo in "${!repos[@]}"; do
    case $repo in
      omnilog* )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
        ;;
      menus )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/menus
        ;;
      omnieye )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnieye
        ;;
      dockers )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/dockers
        ;;
      * )
        clone_repo $repo ${repos[$repo]} .
        ;;
    esac
  done
  
  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
# Place newly created Dockerfiles in respective directories with the same filename in: /opt/omniscient/dockers
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > /opt/omniscient/dockers/Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully in /opt/omniscient/dockers."
fi

echo "Installation script completed."

Usage:
Save the script as install_repos.sh.
Make it executable: chmod +x install_repos.sh.
Run it: ./install_repos.sh.
This script now includes a reusable function execute_remote_script to download and execute remote bash scripts. This makes it easier to add and execute any additional scripts in the future.
Omniscient Immutable Directories, Scripts, Configs, Menus “The following is a detailed document intended to be a developer’s guide towards building constraints that will define a framework’s infrastructure during the development process of Omniscient Framework for a standalone Linux subsystem for Open Source Intelligence Gathering and skip-tracing for aiding private investigators on cases.” Define the main features - such as ai integration, voice to voice ai web interface, action-based ai agents to complete basic system tasks involving digital forensics, pre-defined powerful low-level python scripts/modules to automate osint skip-tracing, disk/file-based forensics tasks. # REFACTORED AWESOME GIT INSTALLER FOR OMNISCIENT TO PLUGIN ARSENAL # SPOOL OTHER LOCAL INSTALLER SCRIPTS /OPT/OMNISCIENT/OMNI_HUB/INSTALLERS git clone https://github.com/JeremyEngram/omnihub_installer /opt/omniscient/omni_hub/omnihub # Create detailed readme markdown configuration readme.md files for structuring # Refactor working bash forensics scripts to html/js/ajax with lmstudio/voice # integrate lmstudio html/js ai/api server with voice into Linux gnome-* packages # ie: screenshot + gnome-screenshot + lmstudio ai + voice https://chatgpt.com/c/6cf39c5b-9ca9-48da-af91-87b273b8df0f # system variable endpoints - to be used in programming immutable constraints $omniadmin $docs $data $readme $man $llm $web # /opt/omniscient/omni_hub/{ admin, system, system_admin } --> /var/www/html/rootadmin # sudo ln -s $omni_hub /var/www/html/cms/rootadmin # sudo ln -s $omnieye /var/www/html/cms/omnieye # sudo ln -s $omnilog /var/www/html/cms/omnilog # sudo ln -s $readme /var/www/html/cms/readme # sudo ln -s $cases /var/www/html/cms/cases # sudo ln -s $man /var/www/html/cms/man # sudo ln -s $dockers /var/www/html/cms/dockers # sudo ln -s $llm /var/www/html/cms/llm /opt/omniscient/.../… \opt\omniscient\cases \opt\omniscient\malformed (offensive) \opt\omniscient\omnieye \opt\omniscient\omnilog \opt\omniscient\operations # omni_hub root admin backend /opt/omniscient/omni_hub/../..( MASTER ROOT ADMIN ) /opt/omniscient/omni_hub/system/scripts # cms design configs /var/www/html/cms/theme/css/style.css /var/www/html/cms/theme/css/styles.css /var/www/html/cms/theme/css/custom.css /var/www/html/cms/theme/css/semantic.css # user endpoints /var/www/html/cms/index.php – user interface contains all user endpoints https://192.168.1.102/cms/index.php # web endpoints https://192.168.1.102:4200/ https://192.168.1.102:9000 https://192.168.1.102:10000 # ai web endpoints /var/www/html/cms/voice.html /var/www/html/cms/voice_frontend /var/www/html/cms/chain_of_custody.html /var/www/html/cms/omnilog/omnilog_llm_lm # web container endpoints → {portainer} # main web user endpoints # /var/www/html/cms/ access.php admin_role_access.php bin_scripts.php case_notes.php chain_of_custody.php cms.php create_group.php create_permissions.php create_user.php dashboard.php databaseOperations.php db_connect.php # script endpoints /opt/omniscient/bin /opt/omniscient/py /opt/omniscient/sh # main web framework infrastructure delete_group.php delete_permissions.php delete_user.php display_case_notes.php display_theme.php dynamic_menu.php edit_group.php edit_permissions.php edit_user.php error_log.php errors.php forensic_tools.php google_dorks.php index.php investigator_links.php lfs_sitemap.php llm_function.php lmstudio_api_server.php login.php logout.php log_viewer.php permissions.php readme.php render_git_repos.php search.php sidebar.php syslogphp.php syslogweb.php tools.php user_reg.php user_scripts.php users.php user_uplink_connection.php view_logs_ajax.php view_logs.php # /var/www/html/cms/html – cms html endpoints access.html ai_tools.html errors.html flasksiabshell.html login.html streamlitcontainer.html voice.html # /var/www/html/cms/theme – theme sub-directory aside.php backend_url.php content.php dashboard.php dynamic_logging.php footer.php header.php index.php investigator.php main.php navbar.php php_sql_command_control.php post_content.php scraping_menu.php search.php section.php sidebar.php sqldbcongui.php Web_menu.php # /var/www/html/cms/theme/plugins - theme plugins curl_scrape_stream.py dynamic_logging.py log_viewer.php omnieye_scraping_menu.php omniscient_db.php php_modules plugins.php scriptserver_plugin.php search.py system_scripts_menu.php typewriter.js websocket_plugin.php # /var/www/html/cms/theme/plugins/php_modules dragula.js dynamic_module_loading.php index_canvas_container.html save_state.php # /var/www/html/cms/theme/backend $ ls -1 -d ./*/** containers docs forensics ./containers/container1.php ./containers/folium_map.py ./containers/ip_list ./docs/awesome-osint ./docs/FBI-tools ./docs/OSINT-FORENSICS-MOBILE ./docs/osintfr ./docs/osint_stuff_tool_collection ./docs/osint-tools ./docs/OSINT-Tools ./docs/Social-Media-Osint ./docs/Social-Media-OSINT-Tools-Collection ./forensics/library # /var/www/html/cms/theme/skeleton elasticsearchbar.html flask htmljs_syslog.html php search_omniscient.html streamlit taipy /var/www/html/cms/theme/skeleton$ ls -1 -d ./*/** ./flask/flask_container.php ./flask/flask_container.py ./flask/flask_execute.html ./flask/flask_execute.py ./flask/flask_logging.py ./flask/flasksiabshell.py ./php/forensics_cli_dash.php ./php/forensics_shell.php ./php/forensics_tools.php ./php/osint_shell.php ./php/phpinfo.php ./php/run_git_sync.php ./php/search.php ./php/shell.php.save ./php/tts ./php/web_based_shell.php ./streamlit/app.py ./streamlit/dashboard ./streamlit/htmlscrapetextfilterstream.py ./streamlit/llm_2_sql_data.py ./streamlit/llm_api_server.py ./streamlit/llm_scripts.py ./streamlit/llm_sql.py ./streamlit/llm_sql_trainer.py ./streamlit/lmstudio_chat.py ./streamlit/main ./streamlit/navigation.py ./streamlit/notes ./streamlit/streamlit_syslog.py ./streamlit/streamlit-websocket-ai.py ./streamlit/streamvenv ./streamlit/styles ./streamlit/terminal_stream.py ./streamlit/wgetrecursivestream3.py ./streamlit/wgetrecursivestream.py ./taipy/chatbot ./taipy/OpenTaipy.py ./taipy/syslog_graph.py ./taipy/taipy_graph_gui.py ./taipy/taipy_gui.py # hidden \home\jeremy\.cache\lm-studio /opt/omniscient/.local/bin /home/jeremy/.autoenv /home/jeremy/.local/bin /home/jeremy/.cache/ /home/jeremy/.config \home\jeremy\.config\autostart \home\jeremy\.config\LM Studio \home\jeremy\.config\LM Studio\logs/main.log /home/jeremy/.local/bin # home local bin commands "/home/jeremy/.local/bin/venvipy-wizard" "/home/jeremy/.local/bin/brython-cli" "/home/jeremy/.local/bin/cpuinfo" "/home/jeremy/.local/bin/ddgr" "/home/jeremy/.local/bin/docx2txt" "/home/jeremy/.local/bin/dotenv" "/home/jeremy/.local/bin/dumppdf.py" "/home/jeremy/.local/bin/email_validator" "/home/jeremy/.local/bin/EXIF.py" "/home/jeremy/.local/bin/websockify" "/home/jeremy/.local/bin/watchfiles" "/home/jeremy/.local/bin/watchmedo" "/home/jeremy/.local/bin/userpath" "/home/jeremy/.local/bin/uvicorn" "/home/jeremy/.local/bin/vba_extract.py" "/home/jeremy/.local/bin/venvipy" "/home/jeremy/.local/bin/virtualenv" "/home/jeremy/.local/bin/wakepy" "/home/jeremy/.local/bin/remotefs" "/home/jeremy/.local/bin/scrape2sql" "/home/jeremy/.local/bin/send2trash" "/home/jeremy/.local/bin/slugify" "/home/jeremy/.local/bin/spleeter" # /opt/omniscient/bin - master system scripts directory "/opt/omniscient/bin/.bin" "/opt/omniscient/bin/adb" "/opt/omniscient/bin/bash2sql" "/opt/omniscient/bin/forensics" "/opt/omniscient/bin/init" "/opt/omniscient/bin/menus" "/opt/omniscient/bin/misc" "/opt/omniscient/bin/mobilesf" "/opt/omniscient/bin/myadb" "/opt/omniscient/bin/newbin" "/opt/omniscient/bin/omnilog" "/opt/omniscient/bin/py" "/opt/omniscient/bin/scripts" "/opt/omniscient/bin/sh" "/opt/omniscient/bin/socmint" "/opt/omniscient/bin/soundux" "/opt/omniscient/bin/sourcecommands" "/opt/omniscient/bin/tldr" "/opt/omniscient/bin/.index" "/opt/omniscient/bin/1.py" "/opt/omniscient/bin/addpyshebangtopy.sh" "/opt/omniscient/bin/aliases" "/opt/omniscient/bin/androtree" "/opt/omniscient/bin/ansible-commnands" "/opt/omniscient/bin/apache2delmon" "/opt/omniscient/bin/apache2filemon" "/opt/omniscient/bin/arduino-cli" "/opt/omniscient/bin/autoflake" "/opt/omniscient/bin/automatepowershell.ps1" "/opt/omniscient/bin/bash-snippets" "/opt/omniscient/bin/bash-snippets2" "/opt/omniscient/bin/bin_system.7z" "/opt/omniscient/bin/black" "/opt/omniscient/bin/blackd" "/opt/omniscient/bin/books-list-new" "/opt/omniscient/bin/caseconnector.sh" "/opt/omniscient/bin/chain_python.sh" "/opt/omniscient/bin/cleaner" "/opt/omniscient/bin/cleanup" "/opt/omniscient/bin/clonedrive" "/opt/omniscient/bin/cmark" "/opt/omniscient/bin/combinescripts" "/opt/omniscient/bin/combinescriptstomarkdown" "/opt/omniscient/bin/commands_list" "/opt/omniscient/bin/compare_duplicate_overssh.log" "/opt/omniscient/bin/compare_duplicates_overssh" "/opt/omniscient/bin/coverage" "/opt/omniscient/bin/coverage3" "/opt/omniscient/bin/coverage-3.11" "/opt/omniscient/bin/cpuinfo" "/opt/omniscient/bin/crosstrax" "/opt/omniscient/bin/csimountpoints" "/opt/omniscient/bin/csiserverreconfigs" "/opt/omniscient/bin/curl-cheat" "/opt/omniscient/bin/curlpublicrecords" "/opt/omniscient/bin/ddgs" "/opt/omniscient/bin/diffbackup" "/opt/omniscient/bin/dirhunt" "/opt/omniscient/bin/docker-compose" "/opt/omniscient/bin/docker-compose.yml" "/opt/omniscient/bin/dockers" "/opt/omniscient/bin/docslist" "/opt/omniscient/bin/dorksearch" "/opt/omniscient/bin/dotenv" "/opt/omniscient/bin/dumplogs" "/opt/omniscient/bin/duplicate_control" "/opt/omniscient/bin/embedlinuxtousb" "/opt/omniscient/bin/embedpiprequirements" "/opt/omniscient/bin/enablenodeosint" "/opt/omniscient/bin/face_detection" "/opt/omniscient/bin/face_recognition" "/opt/omniscient/bin/fetchperson" "/opt/omniscient/bin/fixapache" "/opt/omniscient/bin/flake8" "/opt/omniscient/bin/forcmdloopoutput" "/opt/omniscient/bin/forensics_ebook_harvesting_unfinished" "/opt/omniscient/bin/forensics-full-system-gui-install" "/opt/omniscient/bin/forwardX" "/opt/omniscient/bin/fullpathservdetection" "/opt/omniscient/bin/fullscrapingdetails" "/opt/omniscient/bin/geitpdf" "/opt/omniscient/bin/getbooks" "/opt/omniscient/bin/ghp-import" "/opt/omniscient/bin/gitcreator" "/opt/omniscient/bin/google" "/opt/omniscient/bin/google-chrome-list" "/opt/omniscient/bin/gptradiowidth.png" "/opt/omniscient/bin/gtts-cli" "/opt/omniscient/bin/html2guipdf" "/opt/omniscient/bin/htmlockerscrape" "/opt/omniscient/bin/Hugging Face Pre-trained Models Find the Best One for Your Task.html" "/opt/omniscient/bin/identify-cli" "/opt/omniscient/bin/imageusb" "/opt/omniscient/bin/implement-lazydocker" "/opt/omniscient/bin/increaserootpartiton" "/opt/omniscient/bin/incrementalbackup" "/opt/omniscient/bin/index.html.old" "/opt/omniscient/bin/index-dashboard.html" "/opt/omniscient/bin/install.sh.1" "/opt/omniscient/bin/isort" "/opt/omniscient/bin/isort-identify-imports" "/opt/omniscient/bin/journalctl-xeu-apache2-service-error" "/opt/omniscient/bin/kaggle" "/opt/omniscient/bin/lazydocker" "/opt/omniscient/bin/link_omnisint_logs" "/opt/omniscient/bin/linksrestroew" "/opt/omniscient/bin/LinuxMenu.code-workspace" "/opt/omniscient/bin/logname" "/opt/omniscient/bin/maigret" "/opt/omniscient/bin/markdown_py" "/opt/omniscient/bin/mastercleaner" "/opt/omniscient/bin/mastercleaner2" "/opt/omniscient/bin/masteruefiusbcreator2" "/opt/omniscient/bin/mkdocs" "/opt/omniscient/bin/mkscraper" "/opt/omniscient/bin/mytripwire" "/opt/omniscient/bin/ngrok" "/opt/omniscient/bin/nodeenv" "/opt/omniscient/bin/notes" "/opt/omniscient/bin/omnifind" "/opt/omniscient/bin/omnilog.zip" "/opt/omniscient/bin/omniscient_script_control" "/opt/omniscient/bin/omnisint_recurse_aliases" "/opt/omniscient/bin/omnisint_require" "/opt/omniscient/bin/omnisintlogprerotateconfig" "/opt/omniscient/bin/onionsearch" "/opt/omniscient/bin/openai" "/opt/omniscient/bin/openapi-python-client" "/opt/omniscient/bin/opensslApache" "/opt/omniscient/bin/opensslNginx" "/opt/omniscient/bin/osint_illicit_service" "/opt/omniscient/bin/pathy" "/opt/omniscient/bin/pinecone" "/opt/omniscient/bin/pip" "/opt/omniscient/bin/pip3" "/opt/omniscient/bin/pip3.11" "/opt/omniscient/bin/pl.zip" "/opt/omniscient/bin/portback" "/opt/omniscient/bin/powershell.zip" "/opt/omniscient/bin/pre-commit" "/opt/omniscient/bin/psattack" "/opt/omniscient/bin/psosint" "/opt/omniscient/bin/pup" "/opt/omniscient/bin/pwnedpasswords" "/opt/omniscient/bin/py.test-benchmark" "/opt/omniscient/bin/py.zip" "/opt/omniscient/bin/pycodestyle" "/opt/omniscient/bin/pyflakes" "/opt/omniscient/bin/pyngrok" "/opt/omniscient/bin/pypagodogoohak" "/opt/omniscient/bin/pypdf2pitxt" "/opt/omniscient/bin/pyserial-miniterm" "/opt/omniscient/bin/pyserial-ports" "/opt/omniscient/bin/pytest-benchmark" "/opt/omniscient/bin/scriptgui" "/opt/omniscient/bin/sgpt" "/opt/omniscient/bin/readme.html" "/opt/omniscient/bin/README.md" "/opt/omniscient/bin/reclinuxpart" "/opt/omniscient/bin/ReconCrawler" "/opt/omniscient/bin/relog2llm" "/opt/omniscient/bin/remotefs" "/opt/omniscient/bin/resource_monitor.sh" "/opt/omniscient/bin/restore" "/opt/omniscient/bin/revell_root.sh" "/opt/omniscient/bin/rmlock" "/opt/omniscient/bin/rootmysql" "/opt/omniscient/bin/rsyslog_pii-occurances.py" "/opt/omniscient/bin/scpmaster" "/opt/omniscient/bin/scrapy" "/opt/omniscient/bin/scrapyCSSelectors" "/opt/omniscient/bin/scrapy-do" "/opt/omniscient/bin/scrapydo-scrapy-gui" "/opt/omniscient/bin/selfsigncertdroid2" "/opt/omniscient/bin/setexportxdisplayoptions" "/opt/omniscient/bin/setlogdirpermissions" "/opt/omniscient/bin/shellinaboxnewcert" "/opt/omniscient/bin/shellinaboxosintshell" "/opt/omniscient/bin/sherlocksmith" "/opt/omniscient/bin/rsync-omniscient" "/opt/omniscient/bin/SOLID OSINT GOOGLE SYNTAX SEARCH VRITERIA THAT PRODUCES RESULTS" "/opt/omniscient/bin/sourcecommands.zip" "/opt/omniscient/bin/spacy" "/opt/omniscient/bin/srcgit" "/opt/omniscient/bin/startmenu" "/opt/omniscient/bin/stringreplacedoublequote" "/opt/omniscient/bin/switchmodeotg" "/opt/omniscient/bin/syncomnisintscripts" "/opt/omniscient/bin/sysctl-apache2-error" "/opt/omniscient/bin/Syslog_Dash" "/opt/omniscient/bin/Syslog_Dash2" "/opt/omniscient/bin/syslogerrorminer" "/opt/omniscient/bin/sysloghumanreadabletime" "/opt/omniscient/bin/tabulate" "/opt/omniscient/bin/terminalosintsocks" "/opt/omniscient/bin/textextracthtml" "/opt/omniscient/bin/tldextract" "/opt/omniscient/bin/tldr2" "/opt/omniscient/bin/tqdm" "/opt/omniscient/bin/truncatelogs" "/opt/omniscient/bin/unfurl-standalone" "/opt/omniscient/bin/virtualenv" "/opt/omniscient/bin/virtualhost" "/opt/omniscient/bin/virtualhost2" "/opt/omniscient/bin/watchmedo" "/opt/omniscient/bin/webminmodaccess" "/opt/omniscient/bin/webminsslmode" "/opt/omniscient/bin/whiletldr" "/opt/omniscient/bin/wificrackinglinks" "/opt/omniscient/bin/woeusb" "/opt/omniscient/bin/woeusbgui" "/opt/omniscient/bin/wwwtakeownership" "/opt/omniscient/bin/wxbatch" "/opt/omniscient/bin/wxmap" "/opt/omniscient/bin/wxproj" "/opt/omniscient/bin/wxrec" "/opt/omniscient/bin/wxtoimg" "/opt/omniscient/bin/xxddiosdroidunlockbot" # services management gui https://localhost:10000/init/?xnavigation=1 # /opt/omniscient/system/scripts – (system scripts only to manage the system recursively in bulk actions) # duplicate docker directories /var/www/html/dockers /opt/omniscient/dockers # hidden configs \home\jeremy\.config\ngrok\ngrok.yml Linux: “what is .config in home dir” “what is .local/share in home dir” # CHANGING HOME DIRECTORIES TO INTEGRATE CURRENT USER INTO STANDALONE SYSTEM /OPT/OMNISCIENT → { changing home directories } QUESTION: “How can I move /home/jeremy/{Desktop Documents Downloads, Videos, Pictures} to a new home dir in /opt/omniscient/home/jeremy” “”To move the specified directories to a new home directory, you can use the mv command in a Unix-like terminal. Here's a step-by-step guide to achieve this:”” Create the new home directory structure: bash Copy code sudo mkdir -p /opt/omniscient/home/jeremy Move the directories: bash Copy code sudo mv /home/jeremy/Desktop /opt/omniscient/home/jeremy/ sudo mv /home/jeremy/Documents /opt/omniscient/home/jeremy/ sudo mv /home/jeremy/Downloads /opt/omniscient/home/jeremy/ sudo mv /home/jeremy/Videos /opt/omniscient/home/jeremy/ sudo mv /home/jeremy/Pictures /opt/omniscient/home/jeremy/ Create symbolic links to maintain the original paths (optional): If you want to keep the original paths accessible, you can create symbolic links: bash Copy code ln -s /opt/omniscient/home/jeremy/Desktop /home/jeremy/Desktop ln -s /opt/omniscient/home/jeremy/Documents /home/jeremy/Documents ln -s /opt/omniscient/home/jeremy/Downloads /home/jeremy/Downloads ln -s /opt/omniscient/home/jeremy/Videos /home/jeremy/Videos ln -s /opt/omniscient/home/jeremy/Pictures /home/jeremy/Pictures Update user directory paths (optional): If you are using a desktop environment that tracks user directories, you might need to update the paths in ~/.config/user-dirs.dirs: bash Copy code nano ~/.config/user-dirs.dirs Change the paths to point to the new locations: ini Copy code XDG_DESKTOP_DIR="/opt/omniscient/home/jeremy/Desktop" XDG_DOCUMENTS_DIR="/opt/omniscient/home/jeremy/Documents" XDG_DOWNLOAD_DIR="/opt/omniscient/home/jeremy/Downloads" XDG_VIDEOS_DIR="/opt/omniscient/home/jeremy/Videos" XDG_PICTURES_DIR="/opt/omniscient/home/jeremy/Pictures" Adjust permissions (if necessary): Ensure that the user has the correct permissions for the new directories: bash Copy code sudo chown -R jeremy:jeremy /opt/omniscient/home/jeremy This will effectively move your specified directories to the new home directory while maintaining their accessibility through symbolic links and updating any necessary configurations. 4o How can I officially rename directories in my home dir ie: Documents docs ChatGPT To officially rename directories in your home directory, you can use the mv command. Here are the steps to rename each directory: Open a terminal. Rename the directories: bash Copy code mv /home/jeremy/Documents /home/jeremy/docs mv /home/jeremy/Desktop /home/jeremy/desktop mv /home/jeremy/Downloads /home/jeremy/downloads mv /home/jeremy/Videos /home/jeremy/videos mv /home/jeremy/Pictures /home/jeremy/pictures Update user directory paths: If you are using a desktop environment that tracks user directories, you need to update the paths in ~/.config/user-dirs.dirs: bash Copy code nano ~/.config/user-dirs.dirs Change the paths to the new names: ini Copy code XDG_DESKTOP_DIR="$HOME/desktop" XDG_DOCUMENTS_DIR="$HOME/docs" XDG_DOWNLOAD_DIR="$HOME/downloads" XDG_VIDEOS_DIR="$HOME/videos" XDG_PICTURES_DIR="$HOME/pictures" Update bookmarks and shortcuts (if necessary): Depending on your desktop environment, you might need to update bookmarks and shortcuts in your file manager to reflect the new directory names. For example, in GNOME, you can edit the bookmarks file: bash Copy code nano ~/.config/gtk-3.0/bookmarks Change the paths to match the new names. Restart your session (optional): To ensure all changes take effect, you might want to log out and log back in or restart your system. By following these steps, you will have officially renamed the directories in your home directory and updated any necessary configuration files to reflect these changes.

Here's a detailed developer guide for building constraints and defining the infrastructure for the Omniscient Framework. The guide includes the main features of the framework, instructions for renaming directories and integrating them into the standalone system, and a refactored installation script for adding and executing external bash scripts.
Developer Guide for Omniscient Framework

Main Features
AI Integration
Integrate advanced AI models for automating OSINT and skip-tracing tasks.
Provide action-based AI agents to perform digital forensic tasks.
Voice-to-Voice AI Web Interface
Implement a voice-driven web interface using AI for user interaction.
Action-Based AI Agents
Develop AI agents capable of completing basic system tasks, including digital forensics and data analysis.
Pre-Defined Python Scripts/Modules
Include powerful low-level Python scripts/modules for automating OSINT and forensic tasks.
Disk/File-Based Forensics Tasks
Automate disk and file-based forensic analysis using specialized scripts and tools.

Refactored Bash Installer for Omniscient Framework
This installer script will clone the required repositories, execute necessary remote scripts, and set up the environment for the Omniscient Framework.
bash
Copy code
#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to download and execute a bash script from a URL
execute_remote_script() {
  local url=$1
  echo "Executing script from $url..."
  curl -s $url | bash
  check_success "executing script from $url"
}

# Clone omnihub installer
git clone https://github.com/JeremyEngram/omnihub_installer /opt/omniscient/omni_hub/omnihub
check_success "cloning omnihub_installer"

# Execute required remote scripts
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh"
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/master_list_files"
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/forgitboutit_function"
execute_remote_script "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/bootrepair"

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
  [pyforensics]="JeremyEngram"
  [omnihub]="JeremyEngram"
  [forensics-siab]="JeremyEngram"
  [scrotshot]="JeremyEngram"
  [nmapsploit2]="JeremyEngram"
  [omniscient-arsenal]="JeremyEngram"
  [bootrepair]="JeremyEngram"
  [bash.bashrc]="JeremyEngram"
  [readme_manpages]="JeremyEngram"
  [omniscient_base_system]="JeremyEngram"
)

# Main installation function
main() {
  echo "Starting the installation process..."

  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient
  mkdir -p /opt/omniscient/menus
  mkdir -p /opt/omniscient/omnilog
  mkdir -p /opt/omniscient/omnieye
  mkdir -p /opt/omniscient/dockers

  for repo in "${!repos[@]}"; do
    case $repo in
      omnilog* )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
        ;;
      menus )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/menus
        ;;
      omnieye )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnieye
        ;;
      dockers )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/dockers
        ;;
      * )
        clone_repo $repo ${repos[$repo]} .
        ;;
    esac
  done

  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
# Place newly created Dockerfiles in respective directories with the same filename in: /opt/omniscient/dockers
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > /opt/omniscient/dockers/Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully in /opt/omniscient/dockers."
fi

echo "Installation script completed."

Steps for Renaming and Moving Directories
Renaming Directories
Open a terminal.
Rename the directories:
bash
Copy code
mv /home/jeremy/Documents /home/jeremy/docs
mv /home/jeremy/Desktop /home/jeremy/desktop
mv /home/jeremy/Downloads /home/jeremy/downloads
mv /home/jeremy/Videos /home/jeremy/videos
mv /home/jeremy/Pictures /home/jeremy/pictures


Update user directory paths:
bash
Copy code
nano ~/.config/user-dirs.dirs
Change the paths to the new names:
ini
Copy code
XDG_DESKTOP_DIR="$HOME/desktop"
XDG_DOCUMENTS_DIR="$HOME/docs"
XDG_DOWNLOAD_DIR="$HOME/downloads"
XDG_VIDEOS_DIR="$HOME/videos"
XDG_PICTURES_DIR="$HOME/pictures"


Update bookmarks and shortcuts (if necessary):
bash
Copy code
nano ~/.config/gtk-3.0/bookmarks
Change the paths to match the new names.
Restart your session (optional):
Log out and log back in or restart your system to ensure all changes take effect.
Moving Directories to a New Home
Create the new home directory structure:
bash
Copy code
sudo mkdir -p /opt/omniscient/home/jeremy


Move the directories:
bash
Copy code
sudo mv /home/jeremy/Desktop /opt/omniscient/home/jeremy/
sudo mv /home/jeremy/Documents /opt/omniscient/home/jeremy/
sudo mv /home/jeremy/Downloads /opt/omniscient/home/jeremy/
sudo mv /home/jeremy/Videos /opt/omniscient/home/jeremy/
sudo mv /home/jeremy/Pictures /opt/omniscient/home/jeremy/


Create symbolic links to maintain the original paths (optional):
bash
Copy code
ln -s /opt/omniscient/home/jeremy/Desktop /home/jeremy/Desktop
ln -s /opt/omniscient/home/jeremy/Documents /home/jeremy/Documents
ln -s /opt/omniscient/home/jeremy/Downloads /home/jeremy/Downloads
ln -s /opt/omniscient/home/jeremy/Videos /home/jeremy/Videos
ln -s /opt/omniscient/home/jeremy/Pictures /home/jeremy/Pictures


Update user directory paths (optional):
bash
Copy code
nano ~/.config/user-dirs.dirs
Change the paths to point to the new locations:
ini
Copy code
XDG_DESKTOP_DIR="/opt/omniscient/home/jeremy/Desktop"
XDG_DOCUMENTS_DIR="/opt/omniscient/home/jeremy/Documents"
XDG_DOWNLOAD_DIR="/opt/omniscient/home/jeremy/Downloads"
XDG_VIDEOS_DIR="/opt/omniscient/home/jeremy/Videos"
XDG_PICTURES_DIR="/opt/omniscient/home/jeremy/Pictures"


Adjust permissions (if necessary):
bash
Copy code
sudo chown -R jeremy:jeremy /opt/omniscient/home/jeremy


This guide provides a comprehensive approach to setting up and configuring the Omniscient Framework, including directory management and the installation of necessary components.
Talk to Mia
English (US)English (UK)普通话 (中国大陆)中文 (台灣)粵語 (香港)Bahasa IndonesiaDeutschEspañol (ES)FrançaisItalianoNederlandsPolskiPortuguês (BR)日本語한국어Pусскийहिन्दी
New version of GPT available - Continue chatting to use 








































#!/bin/bash

# Logging setup
LOGFILE="installer.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error during $1. Check the logs for details."
    exit 1
  fi
}

# Function to download and execute a bash script from a URL
execute_remote_script() {
  local url=$1
  echo "Executing script from $url..."
  curl -s $url | bash
  check_success "executing script from $url"
}

# Function to clone a GitHub repository
clone_repo() {
  local repo=$1
  local user=$2
  local destination=$3
  echo "Cloning $repo from $user into $destination..."
  git clone https://github.com/$user/$repo.git $destination/$repo
  check_success "cloning $repo"
}

# Function to execute scripts in a directory
execute_scripts() {
  local dir=$1
  chmod +x $dir/*.sh
  for script in $dir/*.sh; do
    echo "Executing $script..."
    $script
    check_success "executing $script"
  done
}

# List of repositories and their owner
declare -A repos=(
  [bashrc]="JeremyEngram"
  [menus]="JeremyEngram"
  [arsenal]="JeremyEngram"
  [genkeyauth]="JeremyEngram"
  [autoenv]="JeremyEngram"
  [Omniscient]="JeremyEngram"
  [aliasmaster]="JeremyEngram"
  [pipvenvmanager]="JeremyEngram"
  [managevenv]="JeremyEngram"
  [Omniscient_Github]="JeremyEngram"
  [omniscient_installers]="JeremyEngram"
  [omnilog]="JeremyEngram"
  [omnilog_additions]="JeremyEngram"
  [omnilog_rules]="JeremyEngram"
  [dockers]="JeremyEngram"
  [dfirmenu]="JeremyEngram"
  [ReconWhore]="JeremyEngram"
  [iKy]="JeremyEngram"
  [omnilog_llm_lm]="JeremyEngram"
  [omnieye]="JeremyEngram"
  [nmapai]="JeremyEngram"
  [socmint]="JeremyEngram"
  [disk-forensics]="JeremyEngram"
  [disasterecovery]="JeremyEngram"
  [socmint-menu]="JeremyEngram"
  [pyforensics]="JeremyEngram"
  [omnihub]="JeremyEngram"
  [forensics-siab]="JeremyEngram"
  [scrotshot]="JeremyEngram"
  [nmapsploit2]="JeremyEngram"
  [omniscient-arsenal]="JeremyEngram"
  [bootrepair]="JeremyEngram"
  [bash.bashrc]="JeremyEngram"
  [readme_manpages]="JeremyEngram"
  [omniscient_base_system]="JeremyEngram"
)

# Additional curl-to-bash URLs
declare -a curl_scripts=(
  "https://raw.githubusercontent.com/JeremyEngram/omni_tunnels/main/init.create.omnitunnrls.sh"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/master_list_files"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/forgitboutit_function"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/bootrepair"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/compiled_scripts"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/github_login_data"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/omni_gooey_installer.py"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/omniscient_arsenal.sh"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/original-installer.sh"
  "https://raw.githubusercontent.com/JeremyEngram/arsenal/main/omniscient_gitrepo"
  "https://raw.githubusercontent.com/JeremyEngram/omniscient-arsenal/main/Being%20Added%20To%20Arsenal.txt"
  "https://raw.githubusercontent.com/JeremyEngram/omniscient-arsenal/main/alias_bashly_framework.txt"
)

# Main installation function
main() {
  echo "Starting the installation process..."

  # Execute remote scripts
  for url in "${curl_scripts[@]}"; do
    execute_remote_script "$url"
  done

  # Clone and execute init.scripts
  clone_repo init.scripts JeremyEngram /tmp
  execute_scripts /tmp/init.scripts

  mkdir -p /opt/omniscient
  mkdir -p /opt/omniscient/menus
  mkdir -p /opt/omniscient/omnilog
  mkdir -p /opt/omniscient/omnieye
  mkdir -p /opt/omniscient/dockers

  for repo in "${!repos[@]}"; do
    case $repo in
      omnilog* )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnilog
        ;;
      menus )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/menus
        ;;
      omnieye )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/omnieye
        ;;
      dockers )
        clone_repo $repo ${repos[$repo]} /opt/omniscient/dockers
        ;;
      * )
        clone_repo $repo ${repos[$repo]} .
        ;;
    esac
  done

  echo "All repositories have been cloned successfully."
}

# Run the main function
main

# Prompt to compile the script with shc
read -p "Do you want to compile this script with shc? (y/n): " compile
if [ "$compile" = "y" ]; then
  if command -v shc &> /dev/null; then
    shc -f $0
    check_success "compiling script with shc"
    echo "Script compiled successfully."
  else
    echo "shc is not installed. Please install it to compile the script."
  fi
fi

# Prompt to create a Dockerfile
# Place newly created Dockerfiles in respective directories with the same filename in: /opt/omniscient/dockers
read -p "Do you want to create a Dockerfile from this script? (y/n): " dockerfile
if [ "$dockerfile" = "y" ]; then
  cat <<EOF > /opt/omniscient/dockers/Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y git shc

# Copy and run the installer script
COPY $(basename $0) /installer.sh
RUN chmod +x /installer.sh && /installer.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
  echo "Dockerfile created successfully in /opt/omniscient/dockers."
fi

echo "Installation script completed."


