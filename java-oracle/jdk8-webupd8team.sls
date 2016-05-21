#see https://launchpad.net/~webupd8team/+archive/ubuntu/java for details
java8-ppa:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/webupd8team-java.list
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com

java8-ppa-src:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/webupd8team-java.list
    - name: deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com

java8-accept-license:
  cmd.run:
    - name: echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
    - unless: debconf-get-selections | grep -q shared/accepted-oracle-license-v1-1
    - user: root

jdk8:
  pkg.installed:
    - name: oracle-java8-installer
    - require:
      - pkgrepo: java8-ppa
      - pkgrepo: java8-ppa-src
      - cmd: java8-accept-license

jdk8-default:
  pkg.installed:
    - name: oracle-java8-set-default
    - require:
      - pkg: jdk8
