def vote_menu():
    print('----------------------------------')
    print('VOTE MENU')
    print('----------------------------------')
    print('v: Vote')
    print('x: Exit')
    option = input('Option: ')

    if option == 'v' or option == 'x':
        return option
    else:
        print('Invalid (v/x): ')


def candidate_menu():
    print('----------------------------------')
    print("CANDIDATE MENU")
    print('----------------------------------')
    print('1: Cameron')
    print('2: Allison')
    print('3: Diego')
    choice = input("Select a candidate (1/2/3): ")

    if choice in ['1', '2', '3']:
        return int(choice)
    else:
        print('Invalid (1/2/3).')


def main():
    cameron = 0
    allison = 0
    diego = 0

    while True:
        option = vote_menu()

        if option == 'v':
            candidate_choice = candidate_menu()
            if candidate_choice == 1:
                print('Voted Cameron')
                cameron += 1
            elif candidate_choice == 2:
                print('Voted Allison')
                allison += 1
            elif candidate_choice == 3:
                print('Voted Diego')
                diego += 1

        elif option == 'x':
            total_votes = cameron + allison + diego
            print('----------------------------------')
            print(f'Cameron- {cameron}, Allison- {allison}, Diego- {diego}, Total- {total_votes}.')
            break


if __name__ == '__main__':
    main()
