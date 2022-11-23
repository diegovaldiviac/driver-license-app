import sys 
import random

LOGIN_CREDENTIALS = [["admin","admin1234"], ["johan","johan"],["hans1","okidoki"]]
USER_TYPES = [["admin", "sysadmin"], ["johan","client"], ["hans1","clerk"]]
LIST_OF_LICENSEES = [["Carlos","M","Gimeno",10001,"CURRENT"],["Pepito","M","Palotes",10002,"PENDING"]]

def main(): 
    while True:
        login_bool, login_priv = login()
        if login_bool:
            if login_priv == "sysadmin":
                main_loop()
            if login_priv == "client":
                main_loop_client()
            if login_priv == "clerk": 
                main_loop_clerk()
            quit_option = input ("Quit the program? (y/n): ")
            if quit_option == "y": 
                exit()
            
def login(): 
    while True:
        print("--Welcome to the DMV e-office. Please login using your credentials--")
        username = input("Username:")
        password = input("Password:")
        for credentials in LOGIN_CREDENTIALS: 
            if [username,password] == credentials: 
                
                for user_priv in USER_TYPES: 
                    if user_priv[0] == username: 
                        print("configuring user access")
                        print("\n \nWelcome, "+ username+ "[LEVEL ACCESS:" + user_priv[1] + "]!")
                        return True, user_priv[1]
        quit_option = input ("Quit the program? (y/n): ")
        if quit_option == "y": 
                exit()

def main_loop():
    
    while True:
        sys.stdout.write("\nPlease select one of these options: \n - (1) Apply for a new DL \n - (2) Renew an existing DL \n - (3) Log out\n - (4) View all stored Licensees\n")
        input1 = input()

        if input1 == "1": 
            print("apply for a new DL")
            data,data2 = application()
            LIST_OF_LICENSEES.append(data2)

            print("SQL QUERY RESULT: "+ data)


        if input1 == "2": 
            print("Renew an existing DL")
            renew(LIST_OF_LICENSEES)

        if input1 == "3": 
            print("Logging Out")
            break

        if input1 == "4":
            print("--printing all licenseIDs--")
            
            for item in LIST_OF_LICENSEES: 
                print("licenseID:" + item[3])
    return True

def main_loop_client():
    while True: 
        sys.stdout.write("\nPlease select one of these options: \n - (1) Apply for a new Drivers License \n - (2) Renew a License \n - (3) View my data \n - (4) Log out\n")
        input1 = input()

        if input1 == '1': 
            pass 
        if input1 == '2': 
            pass 
        if input1 == '3': 
            pass 
        if input1 == '4': 
            print("Logging Out")
            break
    return True

def main_loop_clerk(): 
    while True: 
        sys.stdout.write("\nPlease select one of these options: \n - (1) Find new applications \n - (2) Find client \n - (3) Log out\n - (4) View all stored Licensees\n")
        input1 = input()

        if input1 == '1': 
            find_pending_applications()
        if input1 == '2': 
            pass 
        if input1 == '3': 
            print("Logging Out")
            break 
        if input1 == '4': 
            pass 
    return True

def find_pending_applications(): 
    pending_appl_list = []
    for client in LIST_OF_LICENSEES: 
        if client[4] == "PENDING": 
            pending_appl_list.append(client)
    if len(pending_appl_list): 
        print("No Pending Applications Found!")
        return None
    print("Found " + len(pending_appl_list) + "pending applications!")
    for client in pending_appl_list: 
        print("--applicant's data--")
        print ("First Name:" + client[0] + "\n Last Name" + client[1] +"\nDriving Test Status:" + client[5] +  "\nLearner's Permit status:" + client[6] )
        approve = input ("Approve the candidate? (y/n)")
        if approve == "y":
            pass
    


def application(): 
    firstName = input("First Name:")
    middleInitial = input("Middle Initial:")
    lastName = input("Last Name: ")
    application_status = "PENDING"
    
    
    sql = "INSERT INTO PERSON (firstName,middleInitial,LastName) VALUES (" + firstName + "," + middleInitial + ","+ lastName +");"
    licenseID = str(random.randint(10000,20000))
    listing = [firstName,middleInitial, lastName,licenseID,application_status]
    print("Application submitted ! \n Your License ID is:"+ licenseID)
    print("\n")
    return sql,listing


def renew(LIST_OF_LICENSEES):
    
    licenseID = input("licenseID:")

    for item in LIST_OF_LICENSEES: 
        if licenseID == item[3]: 
            print("Found a match !\n")
            print("First Name: " + item[0])
            print("Last Name: " + item[2])
            want_to_renew = input("Do you want to renew? (y/n): ")
            if want_to_renew == "y": 
                print("\n validity extended for another 5 years!\n ")
                return None



main()