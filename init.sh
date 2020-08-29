function ensure_packer() {
    local packer_version;
    import_args "$@";
    check_required_arguments "ensure_packer" packer_version;

    export PACKER="packer-$packer_version";
    if [ $(which "$PACKER") ]; then
        log_info "Packer version $packer_version is already installed at $(which $PACKER).";
    else
        log_info "Packer version $packer_version not available. Installing it now in the project cache.";
        curl -Lo "/tmp/packer.zip" https://releases.hashicorp.com/packer/$packer_version/packer_${packer_version}_linux_amd64.zip;
        cd /tmp;
        unzip packer.zip;
        mv packer "/cache/project/bin/$PACKER";
        chmod u+x "/cache/project/bin/$PACKER";
        rm -f packer.zip;
        cd -;
        log_info "Packer $packer_version is available at $(which $PACKER)";
    fi;
}