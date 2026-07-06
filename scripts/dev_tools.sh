#!/bin/bash


function print_usage()
{
    echo "Usage Instructions"
    echo -e "<mode>:
    code_coverage: Run Code Coverage Scan
    plantuml: Generate Plant UML images on all files in repo."
    exit 1
}
function check_setup {
    if [ -f $PWD"/repo_config.sh" ]; then # Running from the right location
        return 0
    else
        echo "ERROR: NOT Running from the root of the repo!"
        return 1
    fi
}
# PlantUML Generation
function plantuml {
    find . -type f -name '*.puml' ! -path './templates/*' | xargs -I {} java -jar /usr/bin/plantuml.jar "{}"
}
# Code Coverage Scan
function code_coverage_scan {
    coverage_dir="coverage"
    
    if [ -d "$coverage_dir" ]; then
        rm -r -f $coverage_dir
    fi
    mkdir $coverage_dir
    bin_dir=""
    if [ "$BUILD_TOOL" = "cmake" ]; then
        bin_dir=$PWD"/build/"
    elif [ "$BUILD_TOOL" = "catkin" ]; then
        bin_dir=$PWD"/../../build/"$REPO_NAME
    else
        echo "$BUILD_TOOL Not supported!"
    fi
    gcov_cmd="gcovr $bin_dir -x $coverage_dir/coverage.xml -s --html-details -o $coverage_dir/coverage.html  --filter '.*\.(hpp|cpp)$'   --exclude '.*/_deps/.*' --exclude '.*/test_.*' --exclude '.*/usr/include/.*' --exclude devel --fail-under-line $LINE_COVERAGE_THRESHOLD --fail-under-branch $BRANCH_COVERAGE_THRESHOLD --exclude-throw-branches --exclude-unreachable-branches"
    eval "$gcov_cmd"
    status=$?
    xdg-open $coverage_dir/coverage.html
    if [ "$status" -eq 0 ]; then
        echo "Coverage Scan OK!"
    else
        if [ "$status" -eq 2 ]; then
            echo "FAILED: Line Coverage!"
            exit 1
            elif [ "$status" -eq 4 ]; then
            echo "FAILED: Branch Coverage!"
            exit 1
        else
            echo "FAILED: Were Unit Tests Executed?"
            exit 1
        fi
    fi
}
if [ $# -eq 0 ]; then
    print_usage
else
    if ! check_setup; then
        echo "ERROR: Something wrong happened.  Please address."
        exit 1
    fi
    
    case $1 in
        "code_coverage") code_coverage_scan;;
        "plantuml") plantuml;;
    esac
fi
exit 0

