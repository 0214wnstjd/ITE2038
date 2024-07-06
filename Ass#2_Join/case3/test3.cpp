#include <bits/stdc++.h>

using namespace std;

class name_grade
{
public:
	string student_name;
	int korean;
	int math;
	int english;
	int science;
	int social;
	int history;

	void set_grade(string tuple)
	{
		stringstream tuplestr(tuple);
		string tempstr;

		getline(tuplestr, student_name, ',');

		getline(tuplestr, tempstr, ',');
		korean = stoi(tempstr);

		getline(tuplestr, tempstr, ',');
		math = stoi(tempstr);

		getline(tuplestr, tempstr, ',');
		english = stoi(tempstr);

		getline(tuplestr, tempstr, ',');
		science = stoi(tempstr);

		getline(tuplestr, tempstr, ',');
		social = stoi(tempstr);

		getline(tuplestr, tempstr);
		history = stoi(tempstr);
	}
};

class name_number
{
public:
	string student_name;
	string student_number;

	void set_number(string tuple)
	{
		stringstream tuplestr(tuple);
		string tempstr;

		getline(tuplestr, student_name, ',');
		getline(tuplestr, student_number, ',');
	}
};

string make_tuple(string name, string number)
{
	string ret = "";

	ret += name + "," + number + "\n";

	return ret;
}

int main()
{

	string buffer[2];
	name_grade temp0;
	name_grade temp1;
	name_number temp2;
	fstream block[12];
	ofstream output;

	output.open("./output3.csv");

	if (output.fail())
	{
		cout << "output file opening fail.\n";
	}

	/*********************************************************************/

	// partition
	for (int i = 0; i < 1000; i++) // 1000개의 file로 분할
	{
		block[0].open("./name_grade1/" + to_string(i) + ".csv"); // 0~999 name_grade1 file open
		block[3].open("./name_grade2/" + to_string(i) + ".csv"); // 0~999 name_grade2 file open
		block[5].open("./name_number/" + to_string(i) + ".csv"); // 0~999 name_number file open
		for (int j = 0; j < 10; j++)							 // 10개씩 저장
		{
			getline(block[0], buffer[0]); // name_grade1 file을 name attribute을 이용하여 ascii code로 bucket에 파일 저장
			temp0.set_grade(buffer[0]);	  // hash function은 앞 세글자를 ascii code로 변경 ex) aaa -> 979797
			block[1].open("../buckets/Grade1_" + to_string(temp0.student_name[0]) + to_string(temp0.student_name[1]) + to_string(temp0.student_name[2]) + ".csv", std::ios::out | std::ios::app);
			block[1] << buffer[0] << endl;
			block[1].close();
			getline(block[3], buffer[1]); // name_grade2도 동일
			temp1.set_grade(buffer[1]);
			block[2].open("../buckets/Grade2_" + to_string(temp1.student_name[0]) + to_string(temp1.student_name[1]) + to_string(temp1.student_name[2]) + ".csv", std::ios::out | std::ios::app);
			block[2] << buffer[1] << endl;
			block[2].close();
			getline(block[5], buffer[1]); // name_number도 동일
			temp2.set_number(buffer[1]);
			block[4].open("../buckets/number_" + to_string(temp2.student_name[0]) + to_string(temp2.student_name[1]) + to_string(temp2.student_name[2]) + ".csv", std::ios::out | std::ios::app);
			block[4] << buffer[1] << endl;
			block[4].close();
		}
		block[0].close();
		block[3].close();
		block[5].close();
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
		block[0].open("../buckets/Grade1_" + to_string(i) + to_string(j) + to_string(k) + ".csv"); // grade1의 첫번째 bucket file open
		block[1].open("../buckets/Grade2_" + to_string(i) + to_string(j) + to_string(k) + ".csv"); // grade2의 일치하는 bucket file open
		for (int m = 0; m < 10; m++)
		{
			getline(block[0], buffer[0]);
			temp0.set_grade(buffer[0]);
			for (int n = 0; n < 10; n++)
			{
				getline(block[1], buffer[1]);
				temp1.set_grade(buffer[1]);
				if (temp0.student_name.compare(temp1.student_name) == 0)
				{				 // name이 같으면 성적비교
					int cnt = 0; // 성적 향상이 일어난 과목 수
					if (temp1.english - temp0.english < 0)
						cnt++;
					if (temp1.history - temp0.history < 0)
						cnt++;
					if (temp1.korean - temp0.korean < 0)
						cnt++;
					if (temp1.math - temp0.math < 0)
						cnt++;
					if (temp1.science - temp0.science < 0)
						cnt++;
					if (temp1.social - temp0.social < 0)
						cnt++;
					if (cnt > 1)
					{																							   // 2과목 이상 성적 향상 시
						block[2].open("../buckets/number_" + to_string(i) + to_string(j) + to_string(k) + ".csv"); // 일치하는 name_number file open
						for (int l = 0; l < 10; l++)
						{
							getline(block[2], buffer[1]);
							temp2.set_number(buffer[1]);
							if (temp1.student_name[3] == temp2.student_name[3]) // 해당하는 name의 number를 찾음
							{
								output << make_tuple(temp2.student_name, temp2.student_number); // tuple로 만들어 output해줌
							}
						}
						block[2].close();
					}
					block[1].seekg(0); // Grade2_ bucket file 시작점으로 이동
					break;
				}
			}
		}
		block[0].close();
		block[1].close();
		k++;
	}

	// write codes here.

	/*********************************************************************/

	output.close();
}
