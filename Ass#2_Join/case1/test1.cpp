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
	int current_block[2] = {};
	fstream block[12];
	ofstream output;

	output.open("./output1.csv");

	if (output.fail())
	{
		cout << "output file opening fail.\n";
	}

	/*********************************************************************************/

	int pr = 0; // block 내에서 몇번째 튜플을 buffer에 받는지 체크
	int ps = 0;

	block[0].open("./name_age/" + to_string(current_block[0]) + ".csv"); // 01 파일 open
	block[1].open("./name_salary/" + to_string(current_block[1]) + ".csv");
	getline(block[0], buffer[0]); // buffer에 옮김
	getline(block[1], buffer[1]);
	temp0.set_name_age(buffer[0]); // tuple을 attribute대로 분리
	temp1.set_name_salary(buffer[1]);
	while (1)
	{

		if (!temp0.name.compare(temp1.name)) // name_age에서 불러온 tuple의 name이 name_salary에서 불러온 tuple 보다 크지 않을때(name의 알파벳 기준)
		{
			if (temp0.name.compare(temp1.name) == 0)					   // name이 같으면
				output << make_tuple(temp0.name, temp0.age, temp1.salary); // make_tuple로 join해서 넣음
			pr++;														   // name_age의 merge pointer 1 증가
			if (pr == 10)												   // pr은 0~9까지이고, 10이 될시 다음 file 열음
			{
				if (current_block[0] == 999) // 마지막 파일의 끝까지 읽었을 때 break
				{
					break;
				}
				pr = 0;
				block[0].close();
				block[0].open("./name_age/" + to_string(++current_block[0]) + ".csv"); // 다음 file open
			}
			getline(block[0], buffer[0]);
			temp0.set_name_age(buffer[0]); // 다음 tuple
		}
		else // name_age에서 불러온 tuple이 name_salary에서 불러온 tuple 보다 클때(name)
		{
			ps++; // name_salary의 merge pointer 1 증가
			if (ps == 10)
			{
				if (current_block[1] == 999)
				{
					break;
				}
				ps = 0;
				block[1].close();
				block[1].open("./name_salary/" + to_string(++current_block[1]) + ".csv");
			}
			getline(block[1], buffer[1]);
			temp1.set_name_salary(buffer[1]);
		}
	}

	block[0].close();
	block[1].close();

	// write codes here.

	/*********************************************************************************/

	output.close();
}
