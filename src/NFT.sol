// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "openzeppelin-contracts/contracts/access/AccessControl.sol";
import "openzeppelin-contracts/contracts/utils/Base64.sol";
import "./IERC721TokenDescriptor.sol";

contract NFT is AccessControl, ERC721Enumerable {
    using Strings for uint256;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    address public _tokenDescriptor;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        _setRoleAdmin(MINTER_ROLE, MINTER_ROLE);
        _setupRole(MINTER_ROLE, _msgSender());
    }

    function setTokenDescriptor(address tokenDescriptor_)
        public
        onlyRole(MINTER_ROLE)
    {
        _tokenDescriptor = tokenDescriptor_;
    }

    function mint(address to, uint256 tokenId) public onlyRole(MINTER_ROLE) {
        _mint(to, tokenId);
    }

    function mint(address[] memory _toList, uint256[] memory _tokenIdList)
        external
    {
        require(
            _toList.length == _tokenIdList.length,
            "input length must be same"
        );
        for (uint256 i = 0; i < _tokenIdList.length; i++) {
            mint(_toList[i], _tokenIdList[i]);
        }
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                tokenId.toString(),
                                '", "description":"',
                                '", "image": "',
                                "data:image/svg+xml;base64,",
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, ERC721Enumerable)
        returns (bool)
    {
        return
            AccessControl.supportsInterface(interfaceId) ||
            ERC721.supportsInterface(interfaceId);
    }
}
