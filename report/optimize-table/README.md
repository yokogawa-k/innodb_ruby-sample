## OPTIMIZE TABLE demo1

以下の構造のテーブルに value = "happy-bose-cocky-euler-laughing-goldstine-DATA" で1万件データを投入、その後、idが 3001 から 4000 までのデータを DELETE し id 11001 から 21000 までデータを insert を実施したテーブルを OPTIMIZE TABLE した結果。

```sql
CREATE TABLE base(
  id INT(11) NOT NULL AUTO_INCREMENT,
  value INT(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);
```

### MySQL 5.5.46

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.46.svg' width='150%'>

### MySQL 5.5.47

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.47.svg' width='150%'>

### MySQL 5.5.48

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.48.svg' width='150%'>

### MySQL 5.5.49

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.49.svg' width='150%'>

### MySQL 5.5.50

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.50.svg' width='150%'>

### MySQL 5.5.51

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.51.svg' width='150%'>

### MySQL 5.5.52

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.52.svg' width='150%'>

### MySQL 5.5.53

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.53.svg' width='150%'>

### MySQL 5.5.54

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.54.svg' width='150%'>

### MySQL 5.5.55

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.55.svg' width='150%'>

### MySQL 5.5.56

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.56.svg' width='150%'>

### MySQL 5.5.57

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.57.svg' width='150%'>

### MySQL 5.5.58

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.58.svg' width='150%'>

### MySQL 5.5.59

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.5.59.svg' width='150%'>

### MySQL 5.6.27

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.27.svg' width='150%'>

### MySQL 5.6.28

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.28.svg' width='150%'>

### MySQL 5.6.29

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.29.svg' width='150%'>

### MySQL 5.6.30

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.30.svg' width='150%'>

### MySQL 5.6.31

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.31.svg' width='150%'>

### MySQL 5.6.32

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.32.svg' width='150%'>

### MySQL 5.6.33

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.33.svg' width='150%'>

### MySQL 5.6.34

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.34.svg' width='150%'>

### MySQL 5.6.35

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.35.svg' width='150%'>

### MySQL 5.6.36

Inode Not changed  
size: 9437184 => 9437184

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.36.svg' width='150%'>

### MySQL 5.6.37

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.37.svg' width='150%'>

### MySQL 5.6.38

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.38.svg' width='150%'>

### MySQL 5.6.39

Inode Not changed  
size: 9437184 => 9437184

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.6.39.svg' width='150%'>

### MySQL 5.7.9

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.9.svg' width='150%'>

### MySQL 5.7.10

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.10.svg' width='150%'>

### MySQL 5.7.11

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.11.svg' width='150%'>

### MySQL 5.7.12

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.12.svg' width='150%'>

### MySQL 5.7.13

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.13.svg' width='150%'>

### MySQL 5.7.14

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.14.svg' width='150%'>

### MySQL 5.7.15

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.15.svg' width='150%'>

### 5.7.16

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.16.svg' width='150%'>

### 5.7.17

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.17.svg' width='150%'>

### 5.7.18

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.18.svg' width='150%'>

### MySQL 5.7.19

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.19.svg' width='150%'>

### MySQL 5.7.20

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.20.svg' width='150%'>

### 5.7.21

Inode Not changed  
size: 10485760 => 10485760

<img src='https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/report/optimize-table/svg/5.7.21.svg' width='150%'>

