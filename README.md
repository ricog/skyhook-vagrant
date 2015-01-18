# Skyhook Development using Vagrant

This vagrant configuration will install the Skyhook Bitcoin ATM software into
a Vagrant/Virtualbox VM for development purposes. It is a work in progress, is
not officially supported, and since there is no way to receive bills, will not
complete transactions. It may be possible to use a mock serial connection to
simulate receiving dollar bills.

I was curious about Skyhook and decided to test it in a VM. This is the result.

## Requirements

- Virtualbox
- Vagrant

## Installation

Make sure you have the requirements above. Clone this repo and run vagrant.

    git clone https://github.com/ricog/skyhook-vagrant.git
    cd skyhook-vagrant
    vagrant up

This will create the virtual machine and run the currently known installation
steps. See [exec-always](puphpet/files/exec-once/skyhook.sh) for the exact
commands run.

## Usage

Visit [http://192.168.56.101/](http://192.168.56.101/) and you will see the
admin setup screens.

You will also want to log into the VM and tail the web server log.

    vagrant ssh
    tail -f /var/log/nginx/skyhook.dev.error.log

Assuming you have funded your Blockchain.info account and attempt to buy
bitcoins, you should see something like this indicating that the serial
connection is not found.

    PHP message: PHP Fatal error:  Uncaught exception 'Exception' with message 'Device not known, maybe permissions?' in /var/www/includes/Serial/LinuxSerial.php:80
