//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;
//pragma experimental ABIEncoderV2;

contract MyTest {
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


   function setItem(string memory _instrument, string memory _model, uint _price, uint _quantity) public returns (bool) {
        Instrument memory newInstrument = Instrument(_instrument, _model, _price, _quantity, true);
        itemStat[_instrument] = newInstrument;
        instruments.push(Instrument(_instrument, _model, _price, _quantity, true)); 
        itemCount++;
        emit newItem (_instrument, _model, _price, _quantity);
        
        return true;       
    }

    function isAvailable(string memory _instrument) internal returns (bool) {
        require(itemStat[_instrument].available = true, "Item not available");
        return true;
    }

    function delItem(string memory _instrument) public returns (bool) {
        isAvailable;
        itemStat[_instrument].available = false;
        return true;
    }

    function getInventory() public view returns (Instrument[] memory _instruments) {
         _instruments = new Instrument[](itemCount); 
    
        for (uint i = 0; i < instruments.length; i++) {
            Instrument storage _Instrument = instruments[i];
            _instruments[i] = _Instrument;
        }
        return _instruments;
    }

    function GetItemStat(string memory _instrument) public view returns (Instrument memory _Instrument) {
        _Instrument = itemStat[_instrument];
        return _Instrument;
    }

    function sellItem(string memory _instrument) public returns (bool) {
        Instrument storage _Instrument = itemStat[_instrument];
        require(_Instrument.quantity != 0);
        _Instrument.quantity -= 1;
        emit itemSold (_instrument);
        return true;     
    }

    function setPrice(string memory _instrument, uint _newPrice) public returns (bool) {
        Instrument storage _Instrument = itemStat[_instrument];
        _Instrument.price = _newPrice;
        emit newPrice (_instrument, _newPrice);
        return true;
    }

    function addQuant(string memory _instrument, uint _quantityAdd) public returns (bool) {
        Instrument storage _Instrument = itemStat[_instrument];
        _Instrument.quantity += _quantityAdd;
        emit newQuant (_instrument, _Instrument.quantity);
        return true;
    }

    // "guitar". "cord", 800, 5
    // "sax", "yamaha", 300, 10
    // "piano", "yamaha", 500, 11

}