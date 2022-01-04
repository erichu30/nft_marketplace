// a variable call KryptoBird grab the artifacts from KryptoBird JSON
const KryptoBird = artifacts.require("KryptoBird");

module.exports = function(deployer){
    deployer.deploy(KryptoBird);
}