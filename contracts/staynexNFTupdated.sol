pragma solidity ^0.5.17;
pragma experimental ABIEncoderV2;

// SPDX-License-Identifier: Creative Commons
// @author: Srihari Kapu <sri@sriharikapu.com>
// @author-website: http://www.sriharikapu.com
// SPDX-License-Identifier: CC-BY-4.0

// File: contracts/Strings.sol

library Strings {
  // via https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_0.5.sol
  function strConcat(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) internal pure returns (string memory) {
    bytes memory _ba = bytes(_a);
    bytes memory _bb = bytes(_b);
    bytes memory _bc = bytes(_c);
    bytes memory _bd = bytes(_d);
    bytes memory _be = bytes(_e);
    string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
    bytes memory babcde = bytes(abcde);
    uint k = 0;
    for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
    for (uint i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
    for (uint i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
    for (uint i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
    for (uint i = 0; i < _be.length; i++) babcde[k++] = _be[i];
    return string(babcde);
  }

  function strConcat(string memory _a, string memory _b, string memory _c, string memory _d) internal pure returns (string memory) {
    return strConcat(_a, _b, _c, _d, "");
  }

  function strConcat(string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
    return strConcat(_a, _b, _c, "", "");
  }

  function strConcat(string memory _a, string memory _b) internal pure returns (string memory) {
    return strConcat(_a, _b, "", "", "");
  }

  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
      return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
      len++;
      j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
      bstr[k--] = byte(uint8(48 + _i % 10));
      _i /= 10;
    }
    return string(bstr);
  }

  function fromAddress(address addr) internal pure returns(string memory) {
    bytes20 addrBytes = bytes20(addr);
    bytes16 hexAlphabet = "0123456789abcdef";
    bytes memory result = new bytes(42);
    result[0] = '0';
    result[1] = 'x';
    for (uint i = 0; i < 20; i++) {
      result[i * 2 + 2] = hexAlphabet[uint8(addrBytes[i] >> 4)];
      result[i * 2 + 3] = hexAlphabet[uint8(addrBytes[i] & 0x0f)];
    }
    return string(result);
  }
}

// File: openzeppelin-solidity/contracts/introspection/IERC165.sol

/**
 * @title IERC165
 * @dev https://eips.ethereum.org/EIPS/eip-165
 */
interface IERC165 {
    /**
     * @notice Query if a contract implements an interface
     * @param interfaceId The interface identifier, as specified in ERC-165
     * @dev Interface identification is specified in ERC-165. This function
     * uses less than 30,000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721.sol

/**
 * @title ERC721 Non-Fungible Token Standard basic interface
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) public view returns (uint256 balance);
    function ownerOf(uint256 tokenId) public view returns (address owner);

    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);

    function transferFrom(address from, address to, uint256 tokenId) public;
    function safeTransferFrom(address from, address to, uint256 tokenId) public;

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721Receiver.sol

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
}

// File: openzeppelin-solidity/contracts/math/SafeMath.sol

/**
 * @title SafeMath
 * @dev Unsigned math operations with safety checks that revert on error
 */
library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
    

}

// File: openzeppelin-solidity/contracts/utils/Address.sol

library logicalMath {
    
    function and(bytes32 a, bytes32 b) internal pure returns (bytes32) {
        return a & b;
    }
    
    function or(bytes32 a, bytes32 b) internal pure returns (bytes32) {
        return a | b;
    }
    
    function xor(bytes32 a, bytes32 b) internal pure returns (bytes32) {
        return a ^ b;
    }
    
}

/**
 * Utility library of inline functions on addresses
 */
library Address {
    /**
     * Returns whether the target address is a contract
     * @dev This function will return false if invoked during the constructor of a contract,
     * as the code is not actually created until after the constructor finishes.
     * @param account address of the account to check
     * @return whether the target address is a contract
     */
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        // XXX Currently there is no better way to check if there is a contract in an address
        // than to check the size of the code at that address.
        // See https://ethereum.stackexchange.com/a/14016/36603
        // for more details about how this works.
        // TODO Check this again before the Serenity release, because all addresses will be
        // contracts then.
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

// File: openzeppelin-solidity/contracts/drafts/Counters.sol

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the SafeMath
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

// File: openzeppelin-solidity/contracts/introspection/ERC165.sol

/**
 * @title ERC165
 * @author Matt Condon (@shrugs)
 * @dev Implements ERC165 using a lookup table.
 */
contract ERC165 is IERC165 {
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;
    /*
     * 0x01ffc9a7 ===
     *     bytes4(keccak256('supportsInterface(bytes4)'))
     */

    /**
     * @dev a mapping of interface id to whether or not it's supported
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    /**
     * @dev A contract implementing SupportsInterfaceWithLookup
     * implement ERC165 itself
     */
    constructor () internal {
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev implement supportsInterface(bytes4) using a lookup table
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev internal method for registering an interface
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff);
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721.sol

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    /*
     * 0x80ac58cd ===
     *     bytes4(keccak256('balanceOf(address)')) ^
     *     bytes4(keccak256('ownerOf(uint256)')) ^
     *     bytes4(keccak256('approve(address,uint256)')) ^
     *     bytes4(keccak256('getApproved(uint256)')) ^
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) ^
     *     bytes4(keccak256('isApprovedForAll(address,address)')) ^
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) ^
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) ^
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)'))
     */

    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    /**
     * @dev Gets the balance of the specified address
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0));
        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0));
        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender));

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId));
        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender);
        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address
     * Usage of this method is discouraged, use `safeTransferFrom` whenever possible
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId));

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data));
    }

    /**
     * @dev Returns whether the specified token exists
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to mint a new token
     * Reverts if the given token ID already exists
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0));
        require(!_exists(tokenId));

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner);

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from);
        require(to != address(0));

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to invoke `onERC721Received` on a target address
     * The call is not executed if the target address is not a contract
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev Private function to clear current approval of a given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721Enumerable.sol

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Enumerable is IERC721 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721Enumerable.sol

/**
 * @title ERC-721 Non-Fungible Token with optional enumeration extension logic
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Enumerable is ERC165, ERC721, IERC721Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) public _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;
    
    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
    
    /*
     * 0x780e9d63 ===
     *     bytes4(keccak256('totalSupply()')) ^
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) ^
     *     bytes4(keccak256('tokenByIndex(uint256)'))
     */

    /**
     * @dev Constructor function
     */
    constructor () public {
        // register the supported interface to conform to ERC721Enumerable via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256) {
        require(index < balanceOf(owner));
        return _ownedTokens[owner][index];
    }
    
    
    function ListOFtokensOwned(address owner) public view returns (uint256[] memory) {
        return _ownedTokens[owner];
    }
    
    
    /**
     * @dev Gets the total amount of tokens stored by the contract
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply());
        return _allTokens[index];
    }
    
    function getTokenList() public view returns (uint256[] memory){
        return _allTokens;
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        super._transferFrom(from, to, tokenId);

        _removeTokenFromOwnerEnumeration(from, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);
    }

    /**
     * @dev Internal function to mint a new token
     * Reverts if the given token ID already exists
     * @param to address the beneficiary that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);

        _addTokenToAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * Deprecated, use _burn(uint256) instead
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        _removeTokenFromOwnerEnumeration(owner, tokenId);
        // Since tokenId will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[tokenId] = 0;

        _removeTokenFromAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Gets the list of token IDs of the requested owner
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner) internal view returns (uint256[] storage) {
        return _ownedTokens[owner];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param tokenId uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the _ownedTokensIndex mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _ownedTokens[from].length--;

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param tokenId uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        // rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        // an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721Metadata.sol

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function supply() external view returns (uint256);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721Metadata.sol

contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;
    
    uint256 private _supply;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
    /*
     * 0x5b5e139f ===
     *     bytes4(keccak256('name()')) ^
     *     bytes4(keccak256('symbol()')) ^
     *     bytes4(keccak256('tokenURI(uint256)'))
     */

    /**
     * @dev Constructor function
     */
    constructor (string memory name, string memory symbol, uint256 supply) public {
        _name = name;
        _symbol = symbol;
        _supply = supply;
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
    }

    /**
     * @dev Gets the token name
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }
    
    function supply()external view returns (uint256) {
        return _supply;
    }

    /**
     * @dev Returns an URI for a given token ID
     * Throws if the token ID does not exist. May return an empty string.
     * @param tokenId uint256 ID of the token to query
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId));
        return _tokenURIs[tokenId];
    }

    /**
     * @dev Internal function to set the token URI for a given token
     * Reverts if the token ID does not exist
     * @param tokenId uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId));
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * Deprecated, use _burn(uint256) instead
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol

/**
 * @title Full ERC721 Token
 * This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
    constructor (string memory name, string memory symbol, uint256 supply) public ERC721Metadata(name, symbol, supply) {
        // solhint-disable-previous-line no-empty-blocks
    }
}

// File: openzeppelin-solidity/contracts/ownership/Ownable.sol

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @return the address of the owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    /**
     * @return true if `msg.sender` is the owner of the contract.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     * It will not be possible to call the functions with the `onlyOwner`
     * modifier anymore.
     * @notice Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: contracts/TradeableERC721Token.sol


contract OwnableDelegateProxy { }

contract ProxyRegistry {
    mapping(address => OwnableDelegateProxy) public proxies;
}

contract ERC20 {
    function transfer(address to, uint tokens) public returns (bool success);
}

/**
 * @title TradeableERC721
 * TradeableERC721Token - ERC721 contract that whitelists a trading address, and has minting functionality.
 */
contract TradeableERC721 is ERC721Full, Ownable {
  using Strings for string;
  using logicalMath for bytes32;

  address proxyRegistryAddress;
  uint256 private _currentTokenId = 0;
  uint256 private tsupply;
  string public _Version;
  uint256 public GRAVITY_LOCKED;
  string private IPFS_HASH;
  string private metadataDetails;
  ERC20 public token;    
  uint256[] public BurntTokens;
  uint256 Time;
  uint256 MAX;
  uint256 RedeemTimeLimit;
  address payable propertyowner;

  

   
  
  constructor(string memory _name, string memory _symbol, uint256 _supply, address _proxyRegistryAddress, string memory _version, uint256 _GRAVITY_LOCKED, address _ERC20_, uint256 _Time, uint256 _redeemTimeLimit, uint256 _maxDaysRedeemable) ERC721Full(_name, _symbol, _supply) public {
    proxyRegistryAddress = _proxyRegistryAddress;
    tsupply = _supply.sub(1);
    _Version = _version;
    GRAVITY_LOCKED = SafeMath.div(_GRAVITY_LOCKED,_supply);
    token = ERC20(_ERC20_);
    Time = _Time; // timestamp used for burn
    RedeemTimeLimit = _redeemTimeLimit;
    MAX = _maxDaysRedeemable++;
    propertyowner = msg.sender;
  }

  function setMax(uint256 _upperLimit) public onlyOwner{
      MAX = _upperLimit;
  }
  
  
  /**
    * @dev Mints a token to an address with a tokenURI.
    * @param _to address of the future owner of the token
    */
    
  function mintTo(address _to) public onlyOwner {
    require(_currentTokenId <= tsupply);
    uint256 newTokenId = _getNextTokenId();  
    _mint(_to, newTokenId);
    setInitials(msg.sender,newTokenId);
    _incrementTokenId();
  }


    
  function publicMint(address _to) public payable {

    require(_currentTokenId <= tsupply, "Token supply exceeded");
    require(msg.value == 0.1 ether, "Insufficient funds");

    uint256 newTokenId = _getNextTokenId();
    _mint(_to, newTokenId);
    _incrementTokenId();
    setInitials(msg.sender,newTokenId);
    // Transfer the payment to the payment address if there is any
    propertyowner.transfer(msg.value);
}

  
  function bulkMint(address _to, uint256 _numberofTokens) public onlyOwner {
      uint256 detailsLength = _currentTokenId.add(_numberofTokens);
      require(detailsLength <= tsupply);
      for(uint256 i = 0 ; i < detailsLength; i++){
          mintTo(_to);
      }
      
  }
    
  
  function burn(uint256 _tokenidentiy) public {
      require(block.timestamp > Time);
      uint256 decimal = pow(10,18);
      uint256 IXI_LOCKED_PER_NFT = SafeMath.mul(GRAVITY_LOCKED, decimal);
      _burn(msg.sender, _tokenidentiy);
      token.transfer(msg.sender, IXI_LOCKED_PER_NFT);
      BurntTokens.push(_tokenidentiy);
  }

	uint256 TS22 = 1650911056;
	uint256 TS23 = 1672511400;
	uint256 TS24 = 1704047400;
	uint256 TS25 = 1735669800;
	uint256 TS26 = 1767205800;
	uint256 TS27 = 1798741800;
	uint256 TS28 = 1830277800;
	uint256 TS29 = 1861900200;
	uint256 TS30 = 1893436200;
	uint256 TS31 = 1924972200;
	uint256 TS32 = 1956508200;
	uint256 TS33 = 1988130600;
	uint256 TS34 = 2019666600;


    struct BookingManager { 
      address _tokenOwner;
      uint _tokenid;
      uint _redeemedNights;
    }    

    BookingManager RED22;
    BookingManager RED23;
    BookingManager RED24;
    BookingManager RED25;
    BookingManager RED26;
    BookingManager RED27;
    BookingManager RED28;
    BookingManager RED29;
    BookingManager RED30;
    BookingManager RED31;
    BookingManager RED32;
    BookingManager RED33;

    function setBookingRED(address _tokenOwner, uint256 _tokenid, uint256 _redeemedNights) public onlyOwner {
        // This Method is used in the case of emergency to reset or set the Records by hotel owner
        if (block.timestamp >= TS22 && block.timestamp < TS23) {
            require(RED22._tokenid == 0, "Booking for RED22 already set");
            RED22 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS23 && block.timestamp < TS24) {
            require(RED23._tokenid == 0, "Booking for RED23 already set");
            RED23 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS24 && block.timestamp < TS25) {
            require(RED24._tokenid == 0, "Booking for RED24 already set");
            RED24 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS25 && block.timestamp < TS26) {
            require(RED25._tokenid == 0, "Booking for RED25 already set");
            RED25 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS26 && block.timestamp < TS27) {
            require(RED26._tokenid == 0, "Booking for RED26 already set");
            RED26 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS27 && block.timestamp < TS28) {
            require(RED27._tokenid == 0, "Booking for RED27 already set");
            RED27 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS28 && block.timestamp < TS29) {
            require(RED28._tokenid == 0, "Booking for RED28 already set");
            RED28 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS29 && block.timestamp < TS30) {
            require(RED29._tokenid == 0, "Booking for RED29 already set");
            RED29 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS30 && block.timestamp < TS31) {
            require(RED30._tokenid == 0, "Booking for RED30 already set");
            RED30 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS31 && block.timestamp < TS32) {
            require(RED31._tokenid == 0, "Booking for RED31 already set");
            RED31 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS32 && block.timestamp < TS33) {
            require(RED32._tokenid == 0, "Booking for RED32 already set");
            RED32 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS33 && block.timestamp < TS34) {
            require(RED33._tokenid == 0, "Booking for RED33 already set");
            RED33 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } 
    }

    function setInitials(address _sender,uint256 _tokenId) internal {
            RED22 = BookingManager(_sender, _tokenId, 0);
    	    RED23 = BookingManager(_sender, _tokenId, 0);
    	    RED24 = BookingManager(_sender, _tokenId, 0);
    	    RED25 = BookingManager(_sender, _tokenId, 0);
    	    RED26 = BookingManager(_sender, _tokenId, 0);
    	    RED27 = BookingManager(_sender, _tokenId, 0);
    	    RED28 = BookingManager(_sender, _tokenId, 0);
    	    RED29 = BookingManager(_sender, _tokenId, 0);
    	    RED30 = BookingManager(_sender, _tokenId, 0);
    	    RED31 = BookingManager(_sender, _tokenId, 0);
    	    RED32 = BookingManager(_sender, _tokenId, 0);
    	    RED33 = BookingManager(_sender, _tokenId, 0);
    }

    function changeOwnershipRED(uint256 _tokenid) public {
      require(ownerOf(_tokenid) == msg.sender, "INVALID_NEW_OWNER");
      require(block.timestamp > RedeemTimeLimit,"CLAIM_AFTER_REDEEM_TIME_LIMIT");
      require(getTokenOwnerFromRecords(_tokenid) != msg.sender, "CURRENT_OWNER_EXCEPTION");
      approve(msg.sender, _tokenid);

        if (block.timestamp > TS22 && block.timestamp < TS23) {
        	RED22 = BookingManager(msg.sender, _tokenid, RED22._redeemedNights);
    	    RED23 = BookingManager(msg.sender, _tokenid, 0);
    	    RED24 = BookingManager(msg.sender, _tokenid, 0);
    	    RED25 = BookingManager(msg.sender, _tokenid, 0);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS23 && block.timestamp < TS24) {
        	RED23 = BookingManager(msg.sender, _tokenid, RED23._redeemedNights);
    	    RED24 = BookingManager(msg.sender, _tokenid, 0);
    	    RED25 = BookingManager(msg.sender, _tokenid, 0);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS24 &&  block.timestamp < TS25) {
        	RED24 = BookingManager(msg.sender, _tokenid, RED24._redeemedNights);
    	    RED25 = BookingManager(msg.sender, _tokenid, 0);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS25 && block.timestamp < TS26) {
    	    RED25 = BookingManager(msg.sender, _tokenid, RED25._redeemedNights);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS26 && block.timestamp < TS27) {
    	    RED26 = BookingManager(msg.sender, _tokenid, RED26._redeemedNights);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS27 && block.timestamp < TS28) {
    	    RED27 = BookingManager(msg.sender, _tokenid, RED27._redeemedNights);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS28 && block.timestamp < TS29) {
    	    RED28 = BookingManager(msg.sender, _tokenid, RED28._redeemedNights);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS29 && block.timestamp < TS30) {
    	    RED29 = BookingManager(msg.sender, _tokenid, RED29._redeemedNights);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS30 && block.timestamp < TS31) {
    	    RED30 = BookingManager(msg.sender, _tokenid, RED30._redeemedNights);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS31 && block.timestamp < TS32) {
    	    RED31 = BookingManager(msg.sender, _tokenid, RED31._redeemedNights);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS32 && block.timestamp < TS33) {
    	    RED32 = BookingManager(msg.sender, _tokenid, RED32._redeemedNights);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS33 && block.timestamp < TS34) {
    	    RED33 = BookingManager(msg.sender, _tokenid, RED33._redeemedNights);
        }
        
    }


    function getNightsRED(uint256 _tokenId) public view returns (uint256) {
      uint256 currentTimestamp = block.timestamp;

      if (currentTimestamp >= TS22 && currentTimestamp < TS23) {
        require(RED22._tokenid == _tokenId, "Invalid token ID for RED22");
        return RED22._redeemedNights;
      } else if (currentTimestamp >= TS23 && currentTimestamp < TS24) {
        require(RED23._tokenid == _tokenId, "Invalid token ID for RED23");
        return RED23._redeemedNights;
      } else if (currentTimestamp >= TS24 && currentTimestamp < TS25) {
        require(RED24._tokenid == _tokenId, "Invalid token ID for RED24");
        return RED24._redeemedNights;
      } else if (currentTimestamp >= TS25 && currentTimestamp < TS26) {
        require(RED25._tokenid == _tokenId, "Invalid token ID for RED25");
        return RED25._redeemedNights;
      } else if (currentTimestamp >= TS26 && currentTimestamp < TS27) {
        require(RED26._tokenid == _tokenId, "Invalid token ID for RED26");
        return RED26._redeemedNights;
      } else if (currentTimestamp >= TS27 && currentTimestamp < TS28) {
        require(RED27._tokenid == _tokenId, "Invalid token ID for RED27");
        return RED27._redeemedNights;
      } else if (currentTimestamp >= TS28 && currentTimestamp < TS29) {
        require(RED28._tokenid == _tokenId, "Invalid token ID for RED28");
        return RED28._redeemedNights;
      } else if (currentTimestamp >= TS29 && currentTimestamp < TS30) {
        require(RED29._tokenid == _tokenId, "Invalid token ID for RED29");
        return RED29._redeemedNights;
      } else if (currentTimestamp >= TS30 && currentTimestamp < TS31) {
        require(RED30._tokenid == _tokenId, "Invalid token ID for RED30");
        return RED30._redeemedNights;
      } else if (currentTimestamp >= TS31 && currentTimestamp < TS32) {
        require(RED31._tokenid == _tokenId, "Invalid token ID for RED31");
        return RED31._redeemedNights;
      } else if (currentTimestamp >= TS32 && currentTimestamp < TS33) {
        require(RED32._tokenid == _tokenId, "Invalid token ID for RED32");
        return RED32._redeemedNights;
      } else if (currentTimestamp >= TS33 && currentTimestamp < TS34) {
        require(RED33._tokenid == _tokenId, "Invalid token ID for RED33");
        return RED33._redeemedNights;
      } else {
        revert("No RED number available for the current timestamp");
      }
    }

    function getTokenOwnerFromRecords(uint256 _tokenId) public view returns (address) {
        uint256 currentTimestamp = block.timestamp;
          if (currentTimestamp >= TS22 && currentTimestamp < TS23) {
            require(RED22._tokenid == _tokenId, "Invalid token ID for RED22");
            return RED22._tokenOwner;
          } else if (currentTimestamp >= TS23 && currentTimestamp < TS24) {
            require(RED23._tokenid == _tokenId, "Invalid token ID for RED23");
            return RED23._tokenOwner;
          } else if (currentTimestamp >= TS24 && currentTimestamp < TS25) {
            require(RED24._tokenid == _tokenId, "Invalid token ID for RED24");
            return RED24._tokenOwner;
          } else if (currentTimestamp >= TS25 && currentTimestamp < TS26) {
            require(RED25._tokenid == _tokenId, "Invalid token ID for RED25");
            return RED25._tokenOwner;
          } else if (currentTimestamp >= TS26 && currentTimestamp < TS27) {
            require(RED26._tokenid == _tokenId, "Invalid token ID for RED26");
            return RED26._tokenOwner;
          } else if (currentTimestamp >= TS27 && currentTimestamp < TS28) {
            require(RED27._tokenid == _tokenId, "Invalid token ID for RED27");
            return RED27._tokenOwner;
          } else if (currentTimestamp >= TS28 && currentTimestamp < TS29) {
            require(RED28._tokenid == _tokenId, "Invalid token ID for RED28");
            return RED28._tokenOwner;
          } else if (currentTimestamp >= TS29 && currentTimestamp < TS30) {
            require(RED29._tokenid == _tokenId, "Invalid token ID for RED29");
            return RED29._tokenOwner;
          } else if (currentTimestamp >= TS30 && currentTimestamp < TS31) {
            require(RED30._tokenid == _tokenId, "Invalid token ID for RED30");
            return RED30._tokenOwner;
          } else if (currentTimestamp >= TS31 && currentTimestamp < TS32) {
            require(RED31._tokenid == _tokenId, "Invalid token ID for RED31");
            return RED31._tokenOwner;
          } else if (currentTimestamp >= TS32 && currentTimestamp < TS33) {
            require(RED32._tokenid == _tokenId, "Invalid token ID for RED32");
            return RED32._tokenOwner;
          } else if (currentTimestamp >= TS33 && currentTimestamp < TS34) {
            require(RED33._tokenid == _tokenId, "Invalid token ID for RED33");
            return RED33._tokenOwner;
          } else {
            revert("No RED number available for the current timestamp");
        }
    }

    function getNightsRedeemed(uint256 _tokenId) public view returns (uint256) {
        uint256 currentTimestamp = block.timestamp;
        if (currentTimestamp >= TS22 && currentTimestamp < TS23) {
          require(RED22._tokenid == _tokenId, "Invalid token ID for RED22");
          return RED22._redeemedNights;
        } else if (currentTimestamp >= TS23 && currentTimestamp < TS24) {
            require(RED23._tokenid == _tokenId, "Invalid token ID for RED23");
            return RED23._redeemedNights;
        } else if (currentTimestamp >= TS24 && currentTimestamp < TS25) {
            require(RED24._tokenid == _tokenId, "Invalid token ID for RED24");
            return RED24._redeemedNights;
        } else if (currentTimestamp >= TS25 && currentTimestamp < TS26) {
            require(RED25._tokenid == _tokenId, "Invalid token ID for RED25");
            return RED25._redeemedNights;
        } else if (currentTimestamp >= TS26 && currentTimestamp < TS27) {
            require(RED26._tokenid == _tokenId, "Invalid token ID for RED26");
            return RED26._redeemedNights;
        } else if (currentTimestamp >= TS27 && currentTimestamp < TS28) {
            require(RED27._tokenid == _tokenId, "Invalid token ID for RED27");
            return RED27._redeemedNights;
        } else if (currentTimestamp >= TS28 && currentTimestamp < TS29) {
            require(RED28._tokenid == _tokenId, "Invalid token ID for RED28");
            return RED28._redeemedNights;
        } else if (currentTimestamp >= TS29 && currentTimestamp < TS30) {
            require(RED29._tokenid == _tokenId, "Invalid token ID for RED29");
            return RED29._redeemedNights;
        } else if (currentTimestamp >= TS30 && currentTimestamp < TS31) {
            require(RED30._tokenid == _tokenId, "Invalid token ID for RED30");
            return RED30._redeemedNights;
        } else if (currentTimestamp >= TS31 && currentTimestamp < TS32) {
            require(RED31._tokenid == _tokenId, "Invalid token ID for RED31");
            return RED31._redeemedNights;
        } else if (currentTimestamp >= TS32 && currentTimestamp < TS33) {
            require(RED32._tokenid == _tokenId, "Invalid token ID for RED32");
            return RED32._redeemedNights;
        } else if (currentTimestamp >= TS33 && currentTimestamp < TS34) {
            require(RED33._tokenid == _tokenId, "Invalid token ID for RED33");
            return RED33._redeemedNights;
        } else {
            revert("No RED number available for the current timestamp");
        }
    }

    function updateRedeemedNights(address _tokenOwner, uint256 _nights, uint256 _flag) internal {
        uint256 currentTimestamp = block.timestamp;
        if (currentTimestamp >= TS22 && currentTimestamp < TS23) {
            require(RED22._tokenOwner == _tokenOwner, "Invalid token owner for RED22");
            if (_flag == 1) {
                RED22._redeemedNights += _nights;
                } else if (_flag == 0) {
                RED22._redeemedNights -= _nights;
                }
        } else if (currentTimestamp >= TS23 && currentTimestamp < TS24) {
            require(RED23._tokenOwner == _tokenOwner, "Invalid token owner for RED23");
            if (_flag == 1) {
                RED23._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED23._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS24 && currentTimestamp < TS25) {
            require(RED24._tokenOwner == _tokenOwner, "Invalid token owner for RED24");
            if (_flag == 1) {
                RED24._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED24._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS25 && currentTimestamp < TS26) {
            require(RED25._tokenOwner == _tokenOwner, "Invalid token owner for RED25");
            if (_flag == 1) {
                RED25._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED25._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS26 && currentTimestamp < TS27) {
            require(RED26._tokenOwner == _tokenOwner, "Invalid token owner for RED26");
            if (_flag == 1) {
                RED26._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED26._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS27 && currentTimestamp < TS28) {
            require(RED27._tokenOwner == _tokenOwner, "Invalid token owner for RED27");
            if (_flag == 1) {
                RED27._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED27._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS28 && currentTimestamp < TS29) {
            require(RED28._tokenOwner == _tokenOwner, "Invalid token owner for RED28");
            if (_flag == 1) {
                RED28._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED28._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS29 && currentTimestamp < TS30) {
            require(RED29._tokenOwner == _tokenOwner, "Invalid token owner for RED29");
            if (_flag == 1) {
              RED29._redeemedNights += _nights;
            } else if (_flag == 0) {
              RED29._redeemedNights -= _nights;
            }
        else if (currentTimestamp >= TS30 && currentTimestamp < TS31) {
        require(RED30._tokenOwner == _tokenOwner, "Invalid token owner for RED30");
            if (_flag == 1) {
                RED30._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED30._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS31 && currentTimestamp < TS32) {
        require(RED31._tokenOwner == _tokenOwner, "Invalid token owner for RED31");
            if (_flag == 1) {
                RED31._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED31._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS32 && currentTimestamp < TS33) {
        require(RED32._tokenOwner == _tokenOwner, "Invalid token owner for RED32");
            if (_flag == 1) {
                RED32._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED32._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS33 && currentTimestamp < TS34) {
        require(RED33._tokenOwner == _tokenOwner, "Invalid token owner for RED33");
            if (_flag == 1) {
                RED33._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED33._redeemedNights -= _nights;
            }
        } else {
            revert("No RED number available for the current timestamp");
        }
        }
    }

    function redeemNights(uint256 _tokenidentiy, address _customerAddress, uint256 _numberDays) public {
        require(ownerOf(_tokenidentiy) == msg.sender, "Only NFT owner can redeem nights");
        require(getTokenOwnerFromRecords(_tokenidentiy) == msg.sender, "CLAIM_OWNERSHIP_RIGHTS");
        uint256 nRED = getNightsRedeemed(_tokenidentiy) + _numberDays;
        require(nRED < MAX);
        uint256 decimal = pow(10, 18);
        uint256 IXI_PER_REDEEM = SafeMath.mul(_numberDays, decimal);
        token.transfer(msg.sender, IXI_PER_REDEEM);
        updateRedeemedNights(msg.sender, _numberDays, 1);
    }

    function refundNights(uint256 _tokenidentiy, address _customerAddress, uint256 _numberDays) public payable returns(string memory) {
        require(msg.sender == propertyowner, "Only Hotel Owner can revert the nights");
        require(ownerOf(_tokenidentiy) == _customerAddress);
        require(msg.value == 0, "Insufficient funds");

        uint256 nRED = getNightsRedeemed(_tokenidentiy);
        if(nRED > _numberDays ){
            uint256 decimal = pow(10, 18);
            uint256 IXI_PER_REFUND = SafeMath.mul(_numberDays, decimal);
            token.transfer(_customerAddress, IXI_PER_REFUND);
            updateRedeemedNights(_customerAddress, _numberDays, 0);
            return("REFUND_SUCCESSFUL");
        }else if(nRED > _numberDays){
            uint256 decimal = pow(10, 18);
            uint256 IXI_PER_REFUND = SafeMath.mul(_numberDays, decimal);
            token.transfer(_customerAddress, IXI_PER_REFUND);
            updateRedeemedNights(_customerAddress, _numberDays, 0);
            return("REFUND_SUCCESSFUL");
        }else {
            return("INVALID_NUMBER_OF_NIGHTS");
        }

    }
    
  function getBurntTokens() public view returns(uint256[] memory){
     return BurntTokens;
  }
  
  
  function pow(uint256 base, uint256 exponent) internal pure returns (uint256) {
        if (exponent == 0) {
            return 1;
        }
        else if (exponent == 1) {
            return base;
        }
        else if (base == 0 && exponent != 0) {
            return 0;
        }
        else {
            uint256 z = base;
            for (uint256 i = 1; i < exponent; i++){
                 z = SafeMath.mul(z, base);                
            }
            return z;
        }
    }
  
  /**
    * @dev 
    * @return 
    */
  function _getDetails() public view returns(string memory _IPFS_HASH, string memory _metadataDetails) {

    (_IPFS_HASH, _metadataDetails) = (IPFS_HASH, metadataDetails);
    return (_IPFS_HASH, _metadataDetails);                
      
  } 

  /**
    * @dev updates the tokens details if specified incorrectly
    * @return nothing
    */
  function _setDetails(string memory _IPFS_HASH, string memory _metadataDetails) public onlyOwner {
    IPFS_HASH = _IPFS_HASH; 
    metadataDetails = _metadataDetails; 
  } 
  
  function getincirculation() public view returns(uint256) {
      return (tsupply.add(1)).sub(BurntTokens.length);
  }


  /**
    * @dev calculates the next token ID based on value of _currentTokenId 
    * @return uint256 for the next token ID
    */
    
  function _getNextTokenId() private view returns (uint256) {
    return _currentTokenId;
  }

  /**
    * @dev increments the value of _currentTokenId 
    */
    
  function _incrementTokenId() private  {
    _currentTokenId++;
  }
  

  function baseTokenURI() public view returns (string memory) {
    return "";
  }

  function tokenURI(uint256 _tokenId) external view returns (string memory) {
    return Strings.strConcat(
        baseTokenURI(),
        Strings.uint2str(_tokenId)
    );
  }
  
   /**
   * Override isApprovedForAll to whitelist user's Collectable proxy accounts to enable gas-less listings.
   */
  function isApprovedForAll(
    address owner,
    address operator
  )
    public
    view
    returns (bool)
  {
    // Whitelist Collectable proxy contract for easy trading.
    ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
    if (address(proxyRegistry.proxies(owner)) == operator) {
        return true;
    }

    return super.isApprovedForAll(owner, operator);
  }

}

contract ReentrancyGuard {
    bool private _notEntered;

    constructor () internal {

        _notEntered = true;
    }

    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_notEntered, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _notEntered = false;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _notEntered = true;
    }
}


// File: contracts/STAYNEX.sol

contract STAYNEX_GENISIS is TradeableERC721, ReentrancyGuard {
  string private _baseTokenURI;

  constructor(
    string memory _name,
    string memory _symbol,
    uint256 _supply,
    address _proxyRegistryAddress,
    string memory baseURI,
    string memory _version,
    uint256 _gravity_locked,
    address _ERC20,
    uint256 _timeLimit,
    uint256 _redemptionTimeLimit,
    uint256 _maxDaysRedemable
    
  ) TradeableERC721(_name, _symbol, _supply, _proxyRegistryAddress, _version, _gravity_locked, _ERC20, _timeLimit, _redemptionTimeLimit, _maxDaysRedemable) public {
    _baseTokenURI = Strings.strConcat(baseURI, Strings.fromAddress(address(this)), "/");
  }

  function transferVersion() public pure returns (string memory) {
    return "1.0.0";
  }


  function baseTokenURI() public view returns (string memory) {
    return _baseTokenURI;
  }

  function setBaseTokenURI(string memory uri) public onlyOwner {
    _baseTokenURI = uri;
  }
}
 