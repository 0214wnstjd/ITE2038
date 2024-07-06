#include <bits/stdc++.h>

using namespace std;

class name_age
{
public:
	string name;
	string age;

	void set_name_age(string tuple)
	{
		stringstream tuplestr(tuple);
		string agestr;

		getline(tuplestr, name, ',');
		getline(tuplestr, age);
	}
};

class name_salary
{
public:
	string name;
	string salary;

	void set_name_salary(string tuple)
	{
		stringstream tuplestr(tuple);
		string salarystr;

		getline(tuplestr, name, ',');
		getline(tuplestr, salary);
	}
};

string make_tuple(string name, string age, string salary)
{
	return name + ',' + age + ',' + salary + '\n';
}

int main()
{

	string buffer[2];
	name_age temp0;
	name_salary temp1;
	fstream block[12];
	ofstream output;

	output.open("./output2.csv");

	if (output.fail())
	{
		cout << "output file opening fail.\n";
	}

	/******************************************************************/

	// partition
	for (int i = 0; i < 1000; i++) // 1000개의 file로 분할
	{
		block[0].open("./name_age/" + to_string(i) + ".csv");	 // 0~999 name_age file open
		block[3].open("./name_salary/" + to_string(i) + ".csv"); // 0~999 name_salary file open
		for (int j = 0; j < 10; j++)							 // 10개씩 저장
		{
			getline(block[0], buffer[0]);  // name_age file을 name attribute을 이용하여 ascii code로 bucket에 파일 저장
			temp0.set_name_age(buffer[0]); // hash function은 앞 세글자를 ascii code로 변경 ex) aaa -> 979797
			block[1].open("../buckets/Age_" + to_string(temp0.name[0]) + to_string(temp0.name[1]) + to_string(temp0.name[2]) + ".csv", std::ios::out | std::ios::app);
			block[1] << buffer[0] << endl;
			block[1].close();
			getline(block[3], buffer[1]); // name_salary도 동일
			temp1.set_name_salary(buffer[1]);
			block[2].open("../buckets/Salary_" + to_string(temp1.name[0]) + to_string(temp1.name[1]) + to_string(temp1.name[2]) + ".csv", std::ios::out | std::ios::app);
			block[2] << buffer[1] << endl;
			block[2].close();
		}
		block[0].close();
		block[3].close();
	}

	// join
	int i = 97, j = 97, k = 97; // 시작 값
	while (1)
	{
		if (k == 107)
		{
			k = 97;
			j++;
		}
		if (j == 107)
		{
			j = 97;
			i++;
		}
		if (i == 107) // 끝
		{
			break;
		}
		block[0].open("../buckets/Age_" + to_string(i) + to_string(j) + to_string(k) + ".csv");	   // 첫번째 bucket file open
		block[1].open("../buckets/Salary_" + to_string(i) + to_string(j) + to_string(k) + ".csv"); // 일치하는 bucket file open
		for (int m = 0; m < 10; m++)
		{
			getline(block[0], buffer[0]);
			temp0.set_name_age(buffer[0]);
			for (int n = 0; n < 10; n++)
			{
				getline(block[1], buffer[1]);
				temp1.set_name_salary(buffer[1]);
				if (temp0.name.compare(temp1.name) == 0)
				{ // name이 같으면 join
					output << make_tuple(temp0.name, temp0.age, temp1.salary);
					block[1].seekg(0); // Salary_ bucket file 시작점으로 이동
					break;
				}
			}
		}
		block[0].close();
		block[1].close();
		k++;
	}

	// write codes here.

	/******************************************************************/

	output.close();
}
