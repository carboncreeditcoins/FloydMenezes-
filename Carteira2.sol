// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CarbonCreditCoin is ERC20, Ownable {

    // =========================
    // SUPPLY
    // =========================
    uint256 public constant MAX_SUPPLY = 20_000_000_000 * 10**18;

    // =========================
    // ADMIN
    // =========================
    address public treasury;

    // =========================
    // METADADOS (SEUS LINKS)
    // =========================
    string public projectWebsite = "https://bitcoincompanies.co/";
    string public analytics = "https://coinstats.app/coins/bitcoin/";
    string public marketData = "https://www.okx.com/pt-br/price/bitcoin-btc";
    string public bridge = "https://jumper.xyz/pt";
    string public explorer = "https://etherscan.io/address/0x77696bb39917c91a0c3908d577d5e322095425ca";
    string public custody = "https://blockscan.com/group?id=85e66a96-efbc-f98b-b511-e7c103286a99";
    string public whitepaper = "https://docs.google.com/spreadsheets/d/1mabXCaQwt8pxq45xsqosEAUqZ-F6csD3r771DxE9fJE";

    // =========================
    // EVENTOS
    // =========================
    event TreasuryUpdated(address indexed oldTreasury, address indexed newTreasury);
    event MetadataUpdated(string field, string value);

    // =========================
    // CONSTRUTOR
    // =========================
    constructor(address initialOwner, address initialTreasury)
        ERC20("Carbon Credit Coins", "CCC")
        Ownable(initialOwner)
    {
        require(initialOwner != address(0), "Owner invalido");
        require(initialTreasury != address(0), "Treasury invalida");

        treasury = initialTreasury;

        // MINT TOTAL
        _mint(initialTreasury, MAX_SUPPLY);
    }

    // =========================
    // ADMIN
    // =========================
    function setTreasury(address newTreasury) external onlyOwner {
        require(newTreasury != address(0), "Endereco invalido");
        address old = treasury;
        treasury = newTreasury;
        emit TreasuryUpdated(old, newTreasury);
    }

    // =========================
    // ATUALIZA LINKS
    // =========================
    function setProjectWebsite(string calldata v) external onlyOwner {
        projectWebsite = v;
        emit MetadataUpdated("website", v);
    }

    function setAnalytics(string calldata v) external onlyOwner {
        analytics = v;
        emit MetadataUpdated("analytics", v);
    }

    function setMarketData(string calldata v) external onlyOwner {
        marketData = v;
        emit MetadataUpdated("market", v);
    }

    function setBridge(string calldata v) external onlyOwner {
        bridge = v;
        emit MetadataUpdated("bridge", v);
    }

    function setExplorer(string calldata v) external onlyOwner {
        explorer = v;
        emit MetadataUpdated("explorer", v);
    }

    function setCustody(string calldata v) external onlyOwner {
        custody = v;
        emit MetadataUpdated("custody", v);
    }

    function setWhitepaper(string calldata v) external onlyOwner {
        whitepaper = v;
        emit MetadataUpdated("whitepaper", v);
    }

    // =========================
    // QUEIMA (OPCIONAL)
    // =========================
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}