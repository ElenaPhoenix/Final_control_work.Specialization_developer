**Задание 1.**  

  405  apt update -y
  406  apt upgrade
  409  cd WindLinux/
  410  mkdir f_task
  412  cd f_task/
  415  cat > pets
  416  cat > pack_animals
  417  cat pets pack_animals > animals
  418  cat animals
  419  mv animals mans_friends
  420  ls -ali
  **Задание 2.**  

  421  cd ..
  422  mkdir db_linux
  423  cd f_task
  424  mv mans_friends ../db_linux/
  426  ls -ali
  428  cd ../
  429  cd db_linux/
  430  ls -ali
  **Задание 3.**  

  431  apt install mysql-server
  432  sudo service mysql status
  **Задание 4.**  

  441  wget https://dev.mysql.com/get/mysql-apt-config_0.8.26-1_all.deb
  442  dpkg -i mysql-apt-config_0.8.26-1_all.deb
  444  dpkg -r mysql-apt-config
  445  history
**Задание 5.**  
См. выше
**Задание 6.**  
![Диаграмма](Diagram.drawio)
**Задания 7-12**
![База Данных](DB_animals.sql)
**Задание 13-15**
![Zoo](Zoo)



