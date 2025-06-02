-include .env

deploy-nft-anvil:; forge script script/DeployBasicNft.s.sol:DeployBasicNft --broadcast --rpc-url $(ANVIL_RPC) --account defaultKey

mint-nft-anvil:; forge script script/Interactions.s.sol:MintBasicNft --broadcast --rpc-url $(ANVIL_RPC) --account defaultKey

test-anvil:; forge test