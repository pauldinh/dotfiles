if which catkin >/dev/null 2>&1; then
    alias ckc='catkin config'

    function ce() {
        catkin config --install --extend $1
    }

    function cb() {
        catkin build $1 -j 10
    }

    function cbt() {
        catkin build --no-deps --this
    }

    function cbo() {
        catkin build --no-deps $1
    }

    function cbe() {
        catkin build --env-cache $1
    }

    function cbd() {
        catkin build --profile debug $1
    }

    function cbde() {
        catkin build --profile debug --cache-env $1
    }

    function cbr() {
        catkin build --profile release $1
    }

    function cbre() {
        catkin build --profile release --cache-env $1
    }

    function crt() {
        catkin run_tests --no-deps $1
    }

    function ct() {
        catkin test --no-deps $1
    }

    function ccov() {
        catkin build --no-deps $1 --cmake-args -DCMAKE_BUILD_TYPE=Coverage --make-args run_coverage_$1
    }

    function cfor() {
        catkin build --no-deps $1 --make-args format_code_$1
    }

    function ccd() {
        catkin profile add --copy-active debug
        catkin profile set debug
        catkin config --log-space logs_debug
        catkin config -b build_debug
        catkin config -d devel_debug
        catkin config -i install_debug
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Debug
    }

    function ccr() {
        catkin profile add --copy-active release
        catkin profile set release
        catkin config --log-space logs
        catkin config -b build
        catkin config -d devel
        catkin config -i install
        #catkin config --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
    }

    function ccrdevel() {
        catkin profile add --copy-active release_devel
        catkin profile set release_devel
        catkin config --log-space logs_devel
        catkin config -b build_devel
        catkin config -d devel_devel
        catkin config --no-install
        #catkin config --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
    }

    function ccrrr() {
        catkin profile add --copy-active release
        catkin profile set release
        catkin config --log-space logs_release
        catkin config -b build_release
        catkin config -d devel_release
        catkin config -i install_release
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
    }

    function ccrunner() {
        catkin profile add --copy-active runner
        catkin profile set runner
        catkin config --log-space logs_runner
        catkin config -b build_runner
        catkin config -d devel_runner
        catkin config -i install_runner
        #catkin config --cmake-args -DCMAKE_BUILD_TYPE=ReleaseWithDebInfo
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
    }
fi