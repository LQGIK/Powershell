function getUsers {

    $users = Get-LocalUser;
    $len = $users.Count;
    $usernames = @();

    for ($i = 0; $i -lt $len; $i++){
   
        $user_info = $users[$i] | Out-String;
        $user_info = $user_info -replace "-";
    
        $user_info = $user_info.Split();
        $items = $user_info.Count;

        # Iterate Items of the user_info
        for ($j = 0; $j -lt $items; $j++){
        
            # If the next item is a boolean, syntactically, the previous item must be the username.
            if ($user_info[$j + 1] -eq "True" -or $user_info[$j + 1] -eq "False"){
                $username = $user_info[$j] -replace " ";

                # Do not add the DefaultAccount, Guest, HomeGroupUser$, or WDAGUtilityAccount
                if (-not ($username -eq "DefaultAccount" -or $username -eq "HomeGroupUser$" -or $username -eq "Guest" -or $username -eq "Administrator" -or $username -eq "WDAGUtilityAccount")){
                    $usernames = $usernames + $user_info[$j];
                }
            }
        }
    }

    return $usernames;

}

$users = getUsers;




