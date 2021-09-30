# Docker Kata! #
## What is Docker and why do we care about it? ##

Well! According to wikipedia:
>Docker is a set of platform as a service (PaaS) products that use OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their own software, libraries and configuration files; they can communicate with each other through well-defined channels. Because all of the containers share the services of a single operating system kernel, they use fewer resources than virtual machines.

At the most basic level of understanding, Docker containers are significantly more efficient virtual machine. But how do they actually differ?

- VMs emulate a computer system, but Docker containers emulate an operating system

Each virtual machine has its own operating system, and the hardware is virtualized. A VM requires a hypervisor that sits between the host OS and VM to create, run, and manage the VM. Each VM needs a full copy of the underlying OS, and a virtual copy of the hardware it is running on. It is essentially another computer running on your computer!

Containers, on the other hand, only emulate the OS and share the host machine's OS kernal. All of the shared host resources are read-only, but sharing host resources typically makes containers significantly lighter than VMs. They start up in seconds vs minutes with VMs and are MUCH smaller.

For a more in depth comparison, check this out: https://www.backblaze.com/blog/vm-vs-containers/

What this means for us is that we can create, ship, and run lightweight, self contained applications anywhere that supports Docker!

Check out the Instructions.md to get started!
