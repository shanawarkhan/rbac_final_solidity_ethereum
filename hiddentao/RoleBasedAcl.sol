// https://gist.github.com/hiddentao/06a3eee75fb433192563890a5d605240
pragma solidity ^0.4.13;

contract RoleBasedAcl {
	address creator;
	mapping(address => mapping(string => bool)) roles;

	function RoleBasedAcl() {
		creator = msg.sender;
	}

	function assignRole(address entity, string role) hasRole('superadmin') {
		roles[entity][role] = true;
	}

	function unassignRole(address entity, string role) hasRole('superadmin') {
		roles[entity][role] = false;
	}

	function isAssignedRole(address entity, string role) return (bool) {
		return roles[entity][role];
	}

	modifier hasRole(string role) {
		if (!roles[msg.sender][role] && msg.sender != creator) {
			revert();
		}
		_;
	}
}