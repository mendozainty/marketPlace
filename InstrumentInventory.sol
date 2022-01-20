//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)

abstract contract Ownable {
    address payable public owner;
    
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }

    function getBalance() public view onlyOwner returns (uint _balance) {
        _balance = address(this).balance;
        return _balance;
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = owner;
        owner = payable(newOwner);
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

contract MyTest is Ownable {
    struct Instrument {
        string instrument;
        string model;
        uint price;
        uint quantity;
        bool available;      
    }
    
    Instrument[] private instruments;
    uint public itemCount;
    mapping(string => Instrument) itemStat;

    event newPrice (string, uint);
    event newItem (string, string, uint, uint);
    event itemSold (string);
    event newQuant (string, uint);
    event itemUnavail (string);


   function setItem(string memory _instrument, string memory _model, uint _price, uint _quantity) public onlyOwner returns (bool) {
        Instrument memory newInstrument = Instrument(_instrument, _model, _price, _quantity, true);
        itemStat[_instrument] = newInstrument;
        instruments.push(Instrument(_instrument, _model, _price, _quantity, true)); 
        itemCount++;
        emit newItem (_instrument, _model, _price, _quantity);
        
        return true;       
    }

    function isAvailable(string memory _instrument) internal view returns (bool) {
        return itemStat[_instrument].available;
    }

    function setUnavail(string memory _instrument) public onlyOwner returns (bool) {
        require(isAvailable(_instrument) == true, "Item not available");
        itemStat[_instrument].available = false;
        emit itemUnavail(_instrument);
        return true;
    }

    function getInventory() public view onlyOwner returns (Instrument[] memory _instruments) {
         _instruments = new Instrument[](itemCount); 
    
        for (uint i = 0; i < instruments.length; i++) {
            Instrument memory _Instrument = instruments[i];
            _instruments[i] = _Instrument;
        }
        return _instruments;
    }

    function GetItemStat(string memory _instrument) public view onlyOwner returns (Instrument memory _Instrument) {
        _Instrument = itemStat[_instrument];
        return _Instrument;
    }

    function sellItem(string memory _instrument) public returns (bool) {
        require(isAvailable(_instrument) == true, "Item not available");
                if (itemStat[_instrument].quantity == 1) {
                    itemStat[_instrument].quantity -= 1; 
                    setUnavail(_instrument);
                    emit itemUnavail(_instrument);
                } else {
                    itemStat[_instrument].quantity -= 1;
                }
        emit itemSold (_instrument);
        
        return true;     
    }

    function setPrice(string memory _instrument, uint _newPrice) public returns (bool) {
        require(isAvailable(_instrument) == true, "Item not available");
        itemStat[_instrument].price = _newPrice;
        emit newPrice (_instrument, _newPrice);
        return true;
    }

    function addQuant(string memory _instrument, uint _quantityAdd) public returns (bool) {
        require(isAvailable(_instrument) == true, "Item not available");
        itemStat[_instrument].quantity += _quantityAdd;
        emit newQuant (_instrument, itemStat[_instrument].quantity);
        return true;
    }

    // "guitar". "cord", 800, 5
    // "sax", "yamaha", 300, 10
    // "piano", "yamaha", 500, 11

}