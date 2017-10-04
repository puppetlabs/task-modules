#! /bin/bash

# Determine the OS name
if [[ -f /etc/redhat-release ]]
then
    if egrep -iq centos /etc/redhat-release
    then
        name=CentOS
    elif egrep -iq 'Fedora release' /etc/redhat-release
    then
         name=Fedora
    fi
    release=$(sed -r -e 's/^.* release ([0-9]+(\.[0-9]+)?).*$/\1/' \
                  /etc/redhat-release)
fi

if [[ -z "${name}" ]]
then
    LSB_RELEASE=$(command -v lsb_release)
    if [[ -n "$LSB_RELEASE" ]]
    then
        if [[ -z "$name" ]]
        then
            name=$($LSB_RELEASE -i | sed -re 's/^.*:[ \t]*//')
        fi
        release=$($LSB_RELEASE -r | sed -re 's/^.*:[ \t]*//')
    fi
fi

case $name in
    RedHat|Fedora|CentOS|Scientific|SLC|Ascendos|CloudLinux)
        family=RedHat;;
    HuaweiOS|LinuxMint|Ubuntu|Debian)
        family=Debian;;
    *)
        family=Other;;
esac

# Print it all out
if [[ -z "$name" ]]
then
    cat <<EOF
{
  "_error": {
    "kind": "minfact/noname",
    "msg": "Could not determine OS name"
  }
}
EOF
else

    # The joy of JSON in shell
    echo "{ \"os\": {"
    echo "    \"name\": \"${name}\","
    if [[ -n "$release" ]]
    then
        echo "      \"release\": {"
        echo "        \"full\": \"${release}\","
        echo "        \"major\": \"${release%.*}\","
        echo "        \"minor\": \"${release#*.}\" },"
    fi
    echo "    \"family\": \"${family}\" } }"
fi
