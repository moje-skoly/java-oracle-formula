#see https://launchpad.net/~webupd8team/+archive/ubuntu/java for details
java7_ppa:
  pkgrepo.managed:
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com

java7_ppa_src:
  pkgrepo.managed:
    - name: deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com

accept-license:
  cmd.run:
    - name: echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
    - unless: debconf-get-selections | grep -q shared/accepted-oracle-license-v1-1
    - user: root

jdk7:
  pkg.installed:
    - name: oracle-java7-installer
    - pkgrepo: apt-get
    - require:
      - cmd: accept-license
      - pkgrepo: java7_ppa
      - pkgrepo: java7_ppa_src
