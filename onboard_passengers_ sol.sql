CREATE TABLE Payment_data (date date, merchant varchar(30), ammount int , payment_mode varchar(30))
INSERT INTO Payment_data values('2022-04-02', 'merchant_1',150,'CASH'),
								('2022-04-02', 'merchant_1',500,'ONLINE'),
								('2022-04-03', 'merchant_2',450,'ONLINE'),
								('2022-04-03', 'merchant_1',100,'CASH'),
								('2022-04-03', 'merchant_3',600,'CASH'),
								('2022-04-05', 'merchant_5',200,'ONLINE'),
								('2022-04-05', 'merchant_2',100,'ONLINE')