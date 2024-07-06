#include "bpt.h"

// global ghost array and count
int ghostCnt = 0;
Ghost ghost[5];

int main()
{
    int64_t input;
    char instruction;
    char buf[120];
    char *result;
    off_t position;
    open_table("test.db");
    while (scanf("%c", &instruction) != EOF)
    {
        switch (instruction)
        {
        case 'i':
            scanf("%ld %s", &input, buf);
            db_insert(input, buf);
            break;
        case 'f':
            scanf("%ld", &input);
            // if input is in ghost, break
            int k;
            for (k = 0; k < ghostCnt; k++)
            {
                if (ghost[k].key == input)
                {
                    printf("Not Exists\n");
                    fflush(stdout);
                    break;
                }
            }
            if (k != ghostCnt)
            {
                break;
            }
            // if input is not in ghost
            result = db_find(input);
            if (result)
            {
                position = find_leaf(input);
                printf("Key: %ld, Value: %s, Position: %lld\n", input, result, position);
            }
            else
                printf("Not Exists\n");

            fflush(stdout);
            break;
        case 'd':
            scanf("%ld", &input);
            // if input is in ghost, cannot ghost twice
            int j;
            for (j = 0; j < ghostCnt; j++)
            {
                if (input == ghost[j].key)
                {
                    break;
                }
            }
            if (j != ghostCnt)
            {
                printf("already ghosted!\n");
                break;
            }
            // if input is not in ghost, add into ghost
            ghost[ghostCnt].key = input;
            ghost[ghostCnt].loc = find_leaf(input);
            ghostCnt++;
            // if ghost is full, delete
            if (ghostCnt == 5)
            {
                for (int i = 0; i < 5; i++)
                {
                    db_delete(ghost[i].key);
                    printf("ghost key %ld is deleted\n", ghost[i].key);
                }
                ghostCnt = 0;
            }
            // show ghost record every time (necessary to show for result)
            for (int i = 0; i < ghostCnt; i++)
            {
                printf("ghost record %d : %ld\n", i + 1, ghost[i].key);
            }
            break;
        case 'q':
            while (getchar() != (int)'\n')
                ;
            // delete ghost keys before quit
            for (int i = 0; i < ghostCnt; i++)
            {
                db_delete(ghost[i].key);
            }
            return EXIT_SUCCESS;
            break;
        }
        while (getchar() != (int)'\n')
            ;
    }
    printf("\n");
    return 0;
}
