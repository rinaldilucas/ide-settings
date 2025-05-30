# Show all commands with descriptions
function help() {
    echo "Available commands list:"
    echo "---------------------------------------------------------------------------------------"
    grep -B1 '^function' ~/alias.zshrc | grep -v '^--' | while read -r line; do
        if [[ "$line" =~ ^# ]]; then
            desc="${line#\# }"
        elif [[ "$line" =~ ^function ]]; then
            fname=$(echo "$line" | sed 's/function \([^ ]*\)().*/\1/')
            if [[ -n "$desc" ]]; then
                printf "  %-35s - %s\n" "$fname" "$desc"
            else
                printf "  %-35s - (no description)\n" "$fname"
            fi
            desc=""
        fi
    done
    echo "---------------------------------------------------------------------------------------"
}

# Refresh CLI environment
function up() {
    source ~/.zshrc
}

# Generate files tree
function file_tree() {
    find . -type f -exec sh -c 'echo "=== {} ==="; cat "{}"; echo ""; echo ""' \; > cat.txt 
}

# Generate files tree without test folder
function file_tree_no_tests() {
    find . -type f -not -path "./test/*" -exec sh -c 'echo "=== {} ==="; cat "{}"; echo ""; echo ""' \; > no_test.txt
}

# Show all running containers
function show_containers() {
    docker ps -a --format "table {{.Names}}\t{{.Status}}"
}

# Starts Docker
function run_docker() {
    sudo service docker start
}

# Run commands to equalize the repo
function run_pull_v3() {
    go_v3;
    ./Scripts/clean-dist
    ./Scripts/subs update
}

# Run git auxiliary pull function
function git_pull() {
    cd ~/code/SoftExpertExcellenceSuiteV3/
    git checkout .
    git clean -fd
    ./Scripts/clean-dist
    git pull --all
    ./Scripts/subs update
    ./Scripts/hooks/post-checkout
    git status
}

# Open .zshrc file
function open_env() {
    code ~/.zshrc
}

# Open .zshrc_alias file
function open_aliases() {
    code ~/.zshrc_aliases
}

# Copies the compiled history project to the folder
function copy_katana() {
    cd ~/code/SoftExpertExcellenceSuiteV3/JavaSuiteSrc/startup/target/katana-distribution && sudo cp -rf ./ ~/code/SoftExpertExcellenceSuiteV3/System/tools/katana/
}

# Go to v3 root folder
function go_v3() {
    cd ~/code/SoftExpertExcellenceSuiteV3/
}

# Go to reactor components
function go_reactor() {
    go_v3;
    cd ./System/web/wwwroot/ui/reactorCmps/
}

# Go to machete folder
function go_machete() {
    go_v3;
    cd ./System/machete/
}

# Go to composes default folder
function go_default() {
    go_v3;
    cd ./composes/default/
}

# Go to Chatbot backend
function go_chatbot_backend() {
    cd ~/code/SoftExpertExcellenceSuiteV3/System/web/include/exp/pmapping/chatbot
}

# Go to FDA backend
function go_fda_backend() {
    cd ~/code/SoftExpertExcellenceSuiteV3/System/web/include/exp/pmapping/processmodeler
}

# Run React in development mode (risk, generic, requirement, workspace)
function dev_react() {
    go_reactor;
    npm run tokens;
    npm run dev --path=risk,generic,requirement,workspace
}

# Run React in development mode with custom path
function dev_react_custom() {
    go_reactor;
    npm run tokens;
    npm run dev --path=generic,workspace,$1
}

# Run FDA React development
function dev_fda() {
    go_reactor;
    npm run dev --path=causeAnalysisTools
}

# Run Maven history development
function dev_maven_history() {
    cd ~/code/SoftExpertExcellenceSuiteV3/JavaSuiteSrc/suite/workspace/workspace-history/ && mvn clean install && cd ~/code/SoftExpertExcellenceSuiteV3/JavaSuiteSrc/startup/ && mvn clean install
}

# Run React unit tests without coverage file
function run_react_tests_no_coverage() {
    export CHROME_BIN='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe';
    go_reactor;
    npm run tdd --path=$1
}

# Run React unit tests with coverage file
function run_react_tests() {
    export CHROME_BIN='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe';
    go_reactor;
    npm run test --path=$1
}

# Run baseclass unit tests
function run_base_tests() {
    docker exec -w /usr/local/se/web/ -it se-baseclass /bin/bash -c "XDEBUG_MODE=coverage php /tmp/phpunit.phar $1"
}

# Run baseclass GRC unit tests
function run_grc_tests() {
    docker exec -w /usr/local/se/web/ -it se-baseclass /bin/bash -c "XDEBUG_MODE=coverage php /tmp/phpunit.phar tests/include/exp/grc"
}

# Run machete unit tests
function run_machete_tests() {
    go_machete;
    bin/remote bin/test $1
}

# Run machete integration tests
function run_machete_integration_tests() {
    go_machete;
    bin/remote bin/integration $1
}

# Run machete lint
function run_machete_lint() {
    go_machete;
    bin/remote bin/lint
}

# Run React lint
function run_react_lint() {
    go_reactor;
    npm run lint --path=$1
}

# Run equalizer
function run_equalizer() {
    cd ~/code/docker-db;
    bash common/equalize.sh
}

# Initialize the sub repositories
function init_subrepos() {
    go_v3;
    ./Scripts/subs init
}

# Update the sub repositories
function update_subrepos() {
    go_v3;
    ./Scripts/subs update
}

# Update the sub repositories (alternative)
function update_subrepos_alt() {
    go_v3;
    git submodule update --init System/platform;
    git submodule update --init System/tools;
    git submodule update --init System/web/wwwroot/document/app;
    git submodule update --init System/web/wwwroot/documentation;
    git submodule update --init System/web/wwwroot/generic/app;
    git submodule update --init System/web/wwwroot/ui/desktop/lite/dist;
    git submodule update --init System/web/wwwroot/ui/reactor/dist;
    git submodule update --init System/web/wwwroot/ui/reactor2/dist;
    git submodule update --init System/web/wwwroot/ui/reactorCmps/dist;
    git submodule update --init System/web/wwwroot/common/images;
    git submodule update --init System/machete/dist;
    git submodule update --init System/web/include/baseclass/dist
}

# Clean the sub repositories
function clean_subrepos() {
    perm;
    go_v3;
    ./Scripts/subs clean
}

# Clean the sub repositories (alternative)
function clean_subrepos_alt() {
    go_v3;
    sudo ./Scripts/subs clean;
    echo -e "\n=====> Update submodule(s)\n";
    echo -e "\n=====> Update System/platform\n"
    git submodule update --depth=1 System/platform;
    echo -e "\n=====> Update System/tools\n"
    git submodule update --depth=1 System/tools;
    echo -e "\n=====> Update System/web/wwwroot/document/app\n"
    git submodule update --depth=1 System/web/wwwroot/document/app;
    echo -e "\n=====> Update System/web/wwwroot/documentation\n"
    git submodule update --depth=1 System/web/wwwroot/documentation;
    echo -e "\n=====> Update System/web/wwwroot/generic/app\n"
    git submodule update --depth=1 System/web/wwwroot/generic/app;
    echo -e "\n=====> Update System/web/wwwroot/ui/desktop/lite/dist\n"
    git submodule update --depth=1 System/web/wwwroot/ui/desktop/lite/dist;
    echo -e "\n=====> Update System/web/wwwroot/ui/reactor/dist\n"
    git submodule update --depth=1 System/web/wwwroot/ui/reactor/dist;
    echo -e "\n=====> Update System/web/wwwroot/ui/reactor2/dist\n"
    git submodule update --depth=1 System/web/wwwroot/ui/reactor2/dist;
    echo -e "\n=====> Update System/web/wwwroot/ui/reactorCmps/dist\n"
    git submodule update --depth=1 System/web/wwwroot/ui/reactorCmps/dist;
    echo -e "\n=====> Update System/web/wwwroot/common/images\n"
    git submodule update --depth=1 System/web/wwwroot/common/images;
    echo -e "\n=====> Update System/machete/dist\n"
    git submodule update --depth=1 System/machete/dist;
    echo -e "\n=====> Update System/web/include/baseclass/dist\n"
    git submodule update --depth=1 System/web/include/baseclass/dist;
    echo -e "\n=====> Submodule(s) updated\n"
    echo -e "\n=====> Status\n"
    git status
}

# Clean machete cache
function clean_machete_cache() {
    go_machete;
    bin/remote bin/clear-cache
}

# Swap database to SQL Server
function swap_mssql() {
    cp ~/code/docker-db/sqlserver/database_config.xml ~/code/SoftExpertExcellenceSuiteV3/System/conf/;
    cd ~/code/docker-db && bash mssql/scripts/stop.sh;
    cd ~/code/docker-db && bash mssql/scripts/start.sh
}

# Swap database to Oracle
function swap_oracle() {
    cp ~/code/docker-db/oracle/database_config.xml ~/code/SoftExpertExcellenceSuiteV3/System/conf/;
    cd ~/code/docker-db && bash oracle/scripts/stop.sh;
    cd ~/code/docker-db && bash oracle/scripts/start.sh
}

# Swap database to PostgreSQL
function swap_pg() {
    cp ~/code/docker-db/postgres/database_config.xml ~/code/SoftExpertExcellenceSuiteV3/System/conf/;
    cd ~/code/docker-db && bash postgres/scripts/stop.sh;
    cd ~/code/docker-db && bash postgres/scripts/start.sh
}