library libraryExample{
    // enum Logic{
    //     addTwice,
    //     removeTwice,
    //     addOnce,
    //     removeOnce
    // } 

    function approvalMaker(mapping(address=>uint256) storage mapForApprovals, address[] memory data ) public {

        for(uint256 i; i<data.length; i++){
            uint256 count=mapForApprovals[data[i]];
            if(count>0){
                emit approvalMade(data[i], count);
            }
        }
        
    }

    event approvalMade(address user, uint256 currentApprovedAmount);
}