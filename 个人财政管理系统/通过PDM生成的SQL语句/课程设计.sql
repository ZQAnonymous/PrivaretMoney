/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2016-12-25 23:01:02                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MyMoney') and o.name = 'FK_MYMONEY_RELATIONS_ADMIN')
alter table MyMoney
   drop constraint FK_MYMONEY_RELATIONS_ADMIN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MyMoney')
            and   name  = 'Relationship_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index MyMoney.Relationship_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MyMoney')
            and   type = 'U')
   drop table MyMoney
go

if exists (select 1
            from  sysobjects
           where  id = object_id('admin')
            and   type = 'U')
   drop table admin
go

/*==============================================================*/
/* Table: MyMoney                                               */
/*==============================================================*/
create table MyMoney (
   incomeID             int                  not null,
   userName             varchar(12)          null,
   date                 datetime             not null,
   type                 varchar(4)           not null,
   project              varchar(15)          not null,
   inMoney              float                not null,
   outMoney             float                not null,
   sumMoney             float                not null,
   constraint PK_MYMONEY primary key nonclustered (incomeID)
)
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/
create index Relationship_1_FK on MyMoney (
userName ASC
)
go

/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin (
   userName             varchar(12)          not null,
   passWord             varchar(16)          not null,
   name                 varchar(10)          not null,
   sex                  varchar(2)           not null,
   brithday             datetime             null,
   tel                  varchar(11)          null,
   job                  varchar(20)          null,
   identify             varchar(18)          null,
   constraint PK_ADMIN primary key nonclustered (userName)
)
go

alter table MyMoney
   add constraint FK_MYMONEY_RELATIONS_ADMIN foreign key (userName)
      references admin (userName)
go

